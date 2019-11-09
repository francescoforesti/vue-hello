<template>
    <div id="app">
        <b-container fluid>
            <b-row>
                <b-col cols="7">
                    <b-input-group prepend="Write something: " class="mt-3">
                        <b-form-input v-model="message"></b-form-input>
                        <b-input-group-append>
                            <b-button @click="reverse(message)">Send Text</b-button>
                        </b-input-group-append>
                    </b-input-group>
                </b-col>
                <b-col cols="5">
                    <h3 class="message vertical-center">{{ result }}</h3>
                </b-col>
            </b-row>
            <b-row class="mt-2">
                <b-col cols="12">
                    <b-input-group prepend="Add a comment" class="mt-3">
                        <b-form-input v-model="comment"></b-form-input>
                        <b-input-group-append>
                            <b-button @click="sendComment(comment)">Send Comment</b-button>
                        </b-input-group-append>
                    </b-input-group>
                </b-col>
            </b-row>
            <b-row class="mt-2">
                <b-col cols="12">
                    <comment-list :comments="comments" :title="'Comments'" :showButton="true"
                                  @report-comment="reportComment"></comment-list>
                </b-col>
            </b-row>
            <b-row class="mt-1">
                <b-col cols="12">
                    <reported-comment-list :comments="reportedComments" :title="'Reports'" :showButton="true"
                                           @delete-comment="deleteComment"></reported-comment-list>
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<style>
    .message {
        font-size: 18px;
        font-family: 'Roboto', sans-serif;
        color: blue;
    }

    .vertical-center {
        margin: 0;
        position: absolute;
        top: 55%;
        -ms-transform: translateY(-50%);
        transform: translateY(-50%);
    }
</style>
<script>
    import Vue from 'vue';
    import CommentList from "./components/CommentList.vue";
    import ReportedCommentList from "./components/ReportedCommentList.vue";
    import {BButton, BCol, BContainer, BFormInput, BInputGroup, BInputGroupAppend, BRow} from 'bootstrap-vue';

    Vue.component('b-container', BContainer);
    Vue.component('b-row', BRow);
    Vue.component('b-col', BCol);
    Vue.component('b-input-group', BInputGroup);
    Vue.component('b-form-input', BFormInput);
    Vue.component('b-input-group-append', BInputGroupAppend);
    Vue.component('b-button', BButton);

    export default {
        data() {
            return {
                message: '',
                result: '',
                comments: [],
                comment: '',
                reportedComments: []
            };
        },
        components: {
            CommentList, ReportedCommentList
        },
        methods: {
            reverse: function (theMessage) {
                axios
                    .post(
                        `${url}echo/reverse`,
                        theMessage,
                        {
                            headers: {
                                'Content-Type': 'text/plain'
                            }
                        }
                    )
                    .then(response => {
                        //console.log(response);
                        this.result = `reversed is ${response.data}`
                    });
            },
            sendComment: function (theComment) {
                axios({
                    method: 'post',
                    url: `${url}comments`,
                    data: theComment,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(response => {
                    //console.log(response);
                    this.comment = '';
                    this.loadComments();
                })
            },
            loadComments: function () {
                axios({
                    method: 'get',
                    url: `${url}comments`,
                    headers: {
                        'Accept': 'application/json'
                    }
                }).then(response => {
                    let items = [];
                    let data = response.data;
                    data.forEach(d => items.push({comment: d}));
                    //console.log(JSON.stringify(items, null,2));
                    this.comments = items;
                })
            },
            loadReports: function () {
                axios({
                    method: 'get',
                    url: `${url}comments/reports`,
                    headers: {
                        'Accept': 'application/json'
                    }
                }).then(response => {
                    //console.log(response);
                    this.reportedComments = [];
                    for (const [k, v] of Object.entries(response.data)) {
                        this.reportedComments.push({key: k, value: v});
                    }
                })
            },
            reportComment: function (event) {

                const theComment = event.comment;
                axios({
                    method: 'put',
                    url: `${url}comments/${theComment}/report`,
                    data: theComment
                }).then(response => {
                    //console.log(response);
                    this.loadReports();
                })
            },
            deleteComment: function (event) {

                const theComment = event.comment;
                axios({
                    method: 'delete',
                    url: `${url}comments/${theComment}`,
                    data: theComment
                }).then(response => {
                    //console.log(response);
                    this.loadComments();
                    this.loadReports();
                })
            },
        },
        mounted() {
            this.loadComments();
            this.loadReports();
        }
    };
</script>
