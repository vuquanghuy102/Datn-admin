<template>
  <div>
    <Form :course="course"
          :is-create="true" />
    <button class="btn btn-info" @click="onIndexSubject()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Courses/Form";

export default {
  components: {
    Form,
  },
  data: function() {
    return {
      course: {}
    };
  },
  methods: {
    onIndexSubject: function() {
      window.location.replace("/courses");
    }
  }
};
</script>