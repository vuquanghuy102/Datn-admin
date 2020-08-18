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
      const requirePair = await SubjectsPairRepository.get(this.subjectId);

      this.subject = result.data
      if (requirePair.data == null) {
        this.subject.require_pair = requirePair.data
      } else {
        this.subject.require_pair = requirePair.data.requirecode
      }

      if (subjectRequired.data == null) {
        this.subject.subject_required = subjectRequired.data
      } else {
        this.subject.subject_required = subjectRequired.data.requirecode
      }

      this.loading = true

    }
  }
};
</script>