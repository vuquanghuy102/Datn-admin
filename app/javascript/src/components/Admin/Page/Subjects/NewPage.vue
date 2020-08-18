<template>
  <div>
    <Form :subject="subject"
          :is-create="true" />
    <button class="btn btn-info" @click="onIndexSubject()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Subjects/Form";

export default {
  components: {
    Form,
  },
  data: function() {
    return {
      subject: {
        subject_type: null,
        department: null,
        status: null,
        require_pair: null,
        subject_required: null,
        require_pair: null
      }
    };
  },
  methods: {
    onIndexSubject: function() {
      window.location.replace("/subjects");
    }
  }
};
</script>