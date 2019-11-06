<template>
    <div id="app">
        <span>type something: </span>
        <input v-model="message" type="text">
        <button v-on:click="reverse(message)">Send</button>
        <h2 class="message">{{ result }}</h2>
        <br />
        <input v-model="comment" type="text">
        <button v-on:click="sendComment(comment)">Send Comment</button>
        <button v-on:click="loadComments()">Load Comments</button>
        <br />
        <div>Comments</div>
        <div id="comments">
            <div v-for="comment in comments">
                <div class="comment-left">
                    {{ comment }}
                </div>
                <div class="comment-right">
                    <button v-on:click="reportComment(comment)">report</button>
                </div>
            </div>
        </div>
        <div>Reports</div>
        <div id="reports">
            <div v-for="comment in reportedComments">
                <div class="comment-left">
                    {{ comment.key }}
                </div>
                <div class="comment-right">
                    {{ comment.value }}
                </div>
            </div>
        </div>
    </div>
</template>
<style>
    .message {
        font-size: 18px;
        font-family: 'Roboto', sans-serif;
        color: blue;
    }

    #comments, #reports {
        margin: 5px;
        padding: 5px;
        width: 30em;
        border: 1px black inset;
    }
    .comment-left {
    }
    .comment-right {
        float: right;
        margin-top: -1.1em;
    }
</style>
<script>
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
        methods: {
            reverse: function (theMessage) {
                axios
                    .post(
                        url + "echo/reverse",
                        theMessage,
                        {
                            headers: {
                                'Content-Type': 'text/plain'
                            }
                        }
                    )
                    .then(response => {
                        console.log(response);
                        this.result = `reversed is ${response.data}`
                    });
            },
            sendComment: function (theComment) {
                axios({
                    method: 'post',
                    url: url + "comments",
                    data: theComment,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                    .then(response => {
                        console.log(response);
                        this.comment = '';
                        this.loadComments();
                    })
            },
            loadComments: function () {
                axios({
                    method: 'get',
                    url: url + 'comments',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                    .then(response => {
                        console.log(response);
                        this.comments = response.data
                    })
            },
            reportComment: function (theComment) {
                axios({
                    method: 'put',
                    url: url + 'comments/' + theComment + "/report",
                    data: theComment
                })
                    .then(response => {
                        console.log(response);
                        this.loadReports();
                    })
            },
            loadReports: function () {
                axios({
                    method: 'get',
                    url: url + 'comments/reports',
                    headers: {
                        'Accept': 'application/json'
                    }
                })
                    .then(response => {
                        console.log(response);
                        this.reportedComments = [];
                        for (const [k, v] of Object.entries(response.data)) {
                            console.log(k + "-" + v);
                            this.reportedComments.push({key: k, value: v});
                        }
                    })
            },
        }
    };
</script>
