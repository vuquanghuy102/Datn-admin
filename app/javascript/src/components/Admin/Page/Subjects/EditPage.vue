<template>
  <div>
    <Form v-if="loading"
          :subject="subject"
          :is-create="false" />
    <button class="btn btn-info" @click="onIndexSubject()">Trở về danh sách</button>
  </div>
</template>
<script>
import
 { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const SubjectsRepository = RepositoryFactory.get("adminSubjects");
const SubjectsRequiredRepository = RepositoryFactory.get("adminSubjectsRequired");
const SubjectsPairRepository = RepositoryFactory.get("adminSubjectsPair");
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
      loading: false,
      subject: {}
    };
  },
  methods: {
    onIndexSubject: function() {
      window.location.replace("/subjects");
    },
    fetchSubject: async function() {
      const result = await SubjectsRepository.get(this.subjectId);
      const subjectRequired = await SubjectsRequiredRepository.get(this.subjectId);
      const subjectPair = await SubjectsPairRepository.get(this.subjectId);

      this.subject = result.data
      this.subject.subject_required = subjectRequired.data
      this.subject.subject_pair = subjectPair.data

      this.loading = true

    }
  }
};
</script>