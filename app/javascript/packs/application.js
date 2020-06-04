// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

import 'bootstrap/dist/js/bootstrap';
import 'bootstrap'

import Axios from './axios';
Vue.prototype.$axios = Axios;

import ApiService from '../api/apiService';

import Toasted from 'vue-toasted';
Vue.prototype.$toasted = Toasted;

import Swal from 'sweetalert2'
Vue.prototype.$swal = Swal;

import Vue from 'vue/dist/vue.esm';
import '../styles/application.scss'

import Loading from './components/share/Loading'

document.addEventListener('DOMContentLoaded', () => {
  const app = document.getElementById("app");

  const vue = new Vue({
    el: "#app",
    components: {
      Loading: Loading,
      RolesIndex: () => import('./components/roles/Index'),
      RolesNewPage: () => import('./components/roles/new'),
      RolesEditPage: () => import('./components/roles/edit'),
      UsersIndex: () => import('./components/users/Index'),
      UsersNewPage: () => import('./components/users/new'),
      UsersEditPage: () => import('./components/users/edit'),
      PermissionsIndex: () => import('./components/permissions/Index'),
      SubjectsIndex: () => import('./components/subjects/Index'),
      SubjectsNewPage: () => import('./components/subjects/new'),
      SubjectsEditPage: () => import('./components/subjects/edit'),
      StudentsIndex: () => import('./components/students/Index'),
      StudentsNewPage: () => import('./components/students/new'),
      StudentsEditPage: () => import('./components/students/edit'),
      CoursesIndex: () => import('./components/courses/Index'),
      CoursesNewPage: () => import('./components/courses/new'),
      CoursesEditPage: () => import('./components/courses/edit'),
      SchedulesIndex: () => import('./components/schedules/Index'),
      SchedulesNewPage: () => import('./components/schedules/new'),
      SchedulesEditPage: () => import('./components/schedules/edit'),
    }
  });
  
  const toastOption = { 
    duration: 3000,
    theme: "bubble"
  };
  Vue.use(Toasted, toastOption);
  Vue.prototype.apiService = new ApiService(vue);
});