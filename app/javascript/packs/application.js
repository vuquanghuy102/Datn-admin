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

import ApiService from '../src/repositories/admin/apiService';

import Toasted from 'vue-toasted';
Vue.prototype.$toasted = Toasted;

import Swal from 'sweetalert2'
Vue.prototype.$swal = Swal;

import Vue from 'vue/dist/vue.esm';
import '../styles/application.scss'

import Loading from '../src/components/Admin/Shared/Loading'

document.addEventListener('DOMContentLoaded', () => {
  const app = document.getElementById("app");

  const vue = new Vue({
    el: "#app",
    components: {
      Loading: Loading,
      RolesIndex: () => import('../src/components/Admin/Page/Roles/IndexPage'),
      RolesNewPage: () => import('../src/components/Admin/Page/Roles/NewPage'),
      RolesEditPage: () => import('../src/components/Admin/Page/Roles/EditPage'),
      UsersIndex: () => import('../src/components/Admin/Page/Users/IndexPage'),
      UsersNewPage: () => import('../src/components/Admin/Page/Users/NewPage'),
      UsersEditPage: () => import('../src/components/Admin/Page/Users/EditPage'),
      PermissionsIndex: () => import('../src/components/Admin/Page/Permissions/IndexPage'),
      SubjectsIndex: () => import('../src/components/Admin/Page/Subjects/IndexPage'),
      SubjectsNewPage: () => import('../src/components/Admin/Page/Subjects/NewPage'),
      SubjectsEditPage: () => import('../src/components/Admin/Page/Subjects/EditPage'),
      StudentsIndex: () => import('../src/components/Admin/Page/Students/IndexPage'),
      StudentsNewPage: () => import('../src/components/Admin/Page/Students/NewPage'),
      StudentsEditPage: () => import('../src/components/Admin/Page/Students/EditPage'),
      CoursesIndex: () => import('../src/components/Admin/Page/Courses/IndexPage'),
      CoursesNewPage: () => import('../src/components/Admin/Page/Courses/NewPage'),
      CoursesEditPage: () => import('../src/components/Admin/Page/Courses/EditPage'),
      SchedulesIndex: () => import('../src/components/Admin/Page/Schedules/IndexPage'),
      SchedulesNewPage: () => import('../src/components/Admin/Page/Schedules/NewPage'),
      SchedulesEditPage: () => import('../src/components/Admin/Page/Schedules/EditPage'),
    }
  });
  
  const toastOption = { 
    duration: 3000,
    theme: "bubble"
  };
  Vue.use(Toasted, toastOption);
  Vue.prototype.apiService = new ApiService(vue);
});