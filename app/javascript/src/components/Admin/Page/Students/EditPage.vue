<template>
  <div>
    <Form :student="student"
          :is-create="false" />
    <button class="btn btn-info" @click="onIndexSubject()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Students/Form";
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const StudentsRepository = RepositoryFactory.get("adminStudents");

export default {
  components: {
    Form,
  },
  props: {
    studentId: {
      type: Number,
      required: true
    }
  },
  created: function() {
    this.fetchStudent()
  },
  data: function() {
    return {
      student: {}
    };
  },
  methods: {
    onIndexSubject: function() {
      window.location.replace("/subjects");
    },
    fetchStudent: async function() {
      const result = await StudentsRepository.get(this.studentId);

      this.student = result.data
    }
  }
};
</script>