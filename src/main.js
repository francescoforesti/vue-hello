import Vue from 'vue';
import BootstrapVue from 'bootstrap-vue'
import axios from 'axios'
import App from './App.vue';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';

window.axios = require('axios');
Vue.prototype.axios = window.axios;
Vue.config.productionTip = false;

new Vue({
    el: '#app',
    render: h => h(App)
});