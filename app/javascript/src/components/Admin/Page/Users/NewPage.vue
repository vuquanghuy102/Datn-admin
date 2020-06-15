<template>
  <div>
    <Form :user="user" :is-create="true" :role-options="roleOptions" :user-roles-attributes="userRolesAttributes"/>
    <button class="btn btn-info" @click="onIndexUser()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Users/Form";
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const RolesRepository = RepositoryFactory.get("adminRoles");

export default {
  components: {
    Form
  },
  data: function() {
    return {
      user: {},
      roleOptions: [],
      userRolesAttributes: []
    };
  },
  created: function() {
    this.fetchUser()
  },
  methods: {
    onIndexUser: function() {
      window.location.replace("/users");
    },
    fetchUser: async function() {
      const res = await RolesRepository.getListSelect();
      this.roleOptions = res.data
    }
  }
};
</script>