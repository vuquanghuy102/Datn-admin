<template>
  <div>
    <Form :role="role" :is-create="true" />
    <button class="btn btn-info" @click="onIndexRole()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Roles/Form";

export default {
  components: {
    Form
  },
  data: function() {
    return {
      role: {}
    };
  },
  methods: {
    onIndexRole: function() {
      window.location.replace("/roles");
    }
  }
};
</script>