<template>
    <div>
        <h4>{{title}}</h4>
        <b-table show-empty
                 empty-text="No content"
                 responsive="sm"
                 :fields="tableFields()"
                 small
                 sticky-header="16em" striped bordered hover :head-variant="'dark'" :items="comments">
            <template v-slot:cell(key)="data">
                {{ data.item.key }}
            </template>
            <template v-slot:cell(value)="data">
                {{ data.item.value }}
            </template>
            <template v-slot:cell(action)="data" v-if="showButton" >
                <b-button variant="danger" @click="deleteComment(data.item.key)" size="sm">Delete</b-button>
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
                return [
                    {key: 'key', label: 'Testo'},
                    {key: 'value', label: 'Segnalazioni'},
                    {key: 'action', label: '', tdClass: "px-1 action-column"}
                ];
            },
            deleteComment(comment) {
                console.log(`deleting ${comment}`);
                this.$emit("delete-comment", {comment: comment});
            }
        }
    }
</script>

<style>
    .action-column {
        width: 5em;
    }
</style>