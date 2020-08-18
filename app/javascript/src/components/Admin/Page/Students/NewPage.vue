<template>
  <div>
    <Form :student="student"
          :fp_user="student.fp_user"
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
      student: {
        fp_user: {},
        class_name: null,
        program: null
      }
    };
  },
  methods: {
    onIndexSubject: function() {
      window.location.replace("/students");
    }
  }
};
</script>