import Vue from 'vue';
import axios from 'axios'
import App from './App.vue';

window.axios = require('axios');
Vue.prototype.axios = window.axios

new Vue({
    el: '#app',
    render: h => h(App),
});