<template>
    <div>
        <h4>{{title}}</h4>
        <b-table show-empty
                 empty-text="No content"
                 responsive="sm"
                 small
                 :fields="tableFields()"
                 sticky-header="16em" striped bordered hover :head-variant="'dark'" :items="comments">
            <template v-slot:cell(comment)="data">
                {{ data.item.comment }}
            </template>
            <template v-slot:cell(action)="data" v-if="showButton" >
                <b-button variant="danger" @click="reportComment(data.item.comment)" size="sm">Report</b-button>
            </template>
        </b-table>
    </div>
</template>

<script>
    import Vue from 'vue';
    import {BTable, BButton} from 'bootstrap-vue';

    Vue.component('b-table', BTable);
    Vue.component('b-button', BButton);

    export default {
        props: [
            'comments', 'title', 'showButton'
        ],
        data() {
            return {
                comments: props.comments,
                title: props.title
            }
        },
        methods: {
            tableFields() {
                return ['comment', {key: 'action', label: '', tdClass: "px-1 action-column"}];
            },
            reportComment(comment) {
                console.log(`reporting ${comment}`);
                this.$emit('report-comment', {comment: comment});
            }
        }
    }
</script>

<style>
    .action-column {
        width: 5em;
    }
</style>