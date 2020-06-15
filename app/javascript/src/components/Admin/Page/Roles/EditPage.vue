<template>
  <div>
    <Form :role="role" :is-create="false" />
    <button class="btn btn-info" @click="onIndexRole()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Roles/Form";
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const RolesRepository = RepositoryFactory.get("adminRoles");

export default {
  components: {
    Form
  },
  props: {
    roleId: {
      type: String,
      required: true
    }
  },
  data: function() {
    return {
      role: {}
    };
  },
  created: function() {
    this.fetchRole()
  },
  methods: {
    onIndexRole: function() {
      window.location.replace("/roles");
    },
    fetchRole: async function() {
      const result = await RolesRepository.get(this.roleId);

      this.role = result.data
    }
  }
};
</script>