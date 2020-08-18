<template>
  <div>
    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Mã học phần</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="course.course_code"
          class="form-control"
          readonly
        />
        <div class="validation" v-if="errors.course_code">
          <p v-for="(error, key) in errors.course_code" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Số lượng sinh viên giới hạn</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="course.max_slot"
          class="form-control"
        />
        <div class="validation" v-if="errors.max_slot">
          <p v-for="(error, key) in errors.max_slot" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Trạng thái</label>
      <div class="col-sm-10">
        <select v-model="course.status" class="form-control">
          <option v-bind:value="null">--Vui lòng chọn--</option>
          <option v-for="status in statusOption"
                  v-bind:value="status.key"
                  :key="status.value">
            {{ status.value }}</option>
        </select>
        <div class="validation" v-if="errors.status">
          <p v-for="(error, key) in errors.status" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Chương trình học</label>
      <div class="col-sm-10">
        <select v-model="course.subject_id" class="form-control">
          <option v-bind:value="null">--Vui lòng chọn--</option>
          <option v-for="(subject, index) in subjectNameOption"
                  v-bind:value="subject.value"
                  :key="index">
            {{ subject.name }}</option>
        </select>
        <div class="validation" v-if="errors.program">
          <p v-for="(error, key) in errors.program" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <button
      class="btn btn-primary float-right"
      @click.prevent="save(course)"
    >
      Lưu lại
    </button>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const SubjectsRepository = RepositoryFactory.get("adminSubjects");
const CoursesRepository = RepositoryFactory.get("adminCourses");

export default {
  props: {
    course: {
      type: Object,
      required: true
    },
    isCreate: Boolean
  },
  data: function() {
    return {
      errors: {},
      statusOption: [],
      subjectNameOption: []
    };
  },
  created() {
    this.fetchListOptionSelect();
  },
  methods: {
    save: async function() {
      let self = this;

      try {
        const response = this.isCreate
          ? await CoursesRepository.create(this.course)
          : await CoursesRepository.update(this.course);

        await this.$swal.fire({
          icon: "success",
          title: "Học phần đã được lưu.",
          showConfirmButton: false,
          timer: 1500
        });

        this.onIndexCourse();
      } catch (e) {
        console.log(e)
        await this.$swal.fire({
          icon: "error",
          title: "Một lỗi đã xảy ra. Vui lòng kiểm tra.",
          showConfirmButton: false,
          timer: 1500
        });

        this.errors = e.response.data;
      }
    },
    onIndexCourse: function() {
      window.location.replace("/courses");
    },
    fetchListOptionSelect: async function() {
      const result_subject_name_option = await SubjectsRepository.getListNameOption();
      const result_course_status_option = await CoursesRepository.getListCourseStatusOption();

      this.statusOption = await result_course_status_option.data
      this.subjectNameOption = await result_subject_name_option.data
    }
  }
};
</script>
<style scoped lang="scss">
.article-image {
  width: 500px;
}
.height-editor {
  height: 420px;
}
.height-row-editor {
  height: 304px;
}
</style>
