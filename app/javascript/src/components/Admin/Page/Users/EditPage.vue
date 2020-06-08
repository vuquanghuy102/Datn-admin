<template>
  <div>
    <Form :user="user" :is-create="false" :role-options="roleOptions" :user-roles-attributes="userRolesAttributes"/>
    <button class="btn btn-info" @click="onIndexUser()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Users/Form";
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const UsersRepository = RepositoryFactory.get("adminUsers");
const RolesRepository = RepositoryFactory.get("adminRoles");

export default {
  components: {
    Form
  },
  props: {
    userId: {
      type: String,
      required: true
    }
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
      const result = await UsersRepository.get(this.userId);
      const res = await RolesRepository.getListSelect();

      this.user = result.data
      this.userRolesAttributes = this.user.user_roles
      this.roleOptions = res.data
    }
  }
};
</script>