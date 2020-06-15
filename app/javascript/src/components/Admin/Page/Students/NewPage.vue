<template>
  <div>
    <Form :student="student"
          :is-create="true" />
    <button class="btn btn-info" @click="onIndexSubject()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Students/Form";

export default {
  components: {
    Form,
  },
  data: function() {
    return {
      student: {}
    };
  },
  methods: {
    onIndexSubject: function() {
      window.location.replace("/students");
    }
  }
};
</script>