<template>
  <div>
    <Form :subject="subject"
          :is-create="false" />
    <button class="btn btn-info" @click="onIndexSubject()">Trở về danh sách</button>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const SubjectsRepository = RepositoryFactory.get("adminSubjects");
import Form from "../../Components/Subjects/Form";

export default {
  components: {
    Form,
  },
  props: {
    subjectId: {
      type: Number,
      required: true
    }
  },
  created: function() {
    this.fetchSubject()
  },
  data: function() {
    return {
      subject: {}
    };
  },
  methods: {
    onIndexSubject: function() {
      window.location.replace("/subjects");
    },
    fetchSubject: async function() {
      const result = await SubjectsRepository.get(this.subjectId);

      this.subject = result.data
    }
  }
};
</script>