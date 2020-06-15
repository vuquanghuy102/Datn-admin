<template>
  <div>
    <Form :course="course"
          :is-create="false" />
    <button class="btn btn-info" @click="onIndexSubject()">Trở về danh sách</button>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const CoursesRepository = RepositoryFactory.get("adminCourses");
import Form from "../../Components/Courses/Form";

export default {
  components: {
    Form,
  },
  props: {
    courseId: {
      type: Number,
      required: true
    }
  },
  data: function() {
    return {
      course: {}
    };
  },
  created() {
    this.fetchCourse()
  },
  methods: {
    onIndexSubject: function() {
      window.location.replace("/courses");
    },
    fetchCourse: async function() {
      const result = await CoursesRepository.get(this.courseId);

      this.course = result.data
    }
  }
};
</script>