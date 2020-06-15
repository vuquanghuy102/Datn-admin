<template>
  <div>
    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Tuần học</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="schedule.week_value"
          class="form-control"
        />
        <div class="validation" v-if="errors.week_value">
          <p v-for="(error, key) in errors.week_value" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Ngày học trong tuần</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="schedule.week_day_value"
          class="form-control"
        />
        <div class="validation" v-if="errors.week_day_value">
          <p v-for="(error, key) in errors.week_day_value" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Các tiết học trong ngày</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="schedule.period_value"
          class="form-control"
        />
        <div class="validation" v-if="errors.period_value">
          <p v-for="(error, key) in errors.period_value" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Địa điểm học</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="schedule.location"
          class="form-control"
        />
        <div class="validation" v-if="errors.location">
          <p v-for="(error, key) in errors.location" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Chương trình học (Mã)</label>
      <div class="col-sm-10">
        <select v-model="schedule.course_id" class="form-control">
          <option v-bind:value="null">--Vui lòng chọn--</option>
          <option v-for="(course, index) in courseCodeOption"
                  v-bind:value="course.value"
                  :key="index">
            {{ course.code }}</option>
        </select>
        <div class="validation" v-if="errors.course_id">
          <p v-for="(error, key) in errors.course_id" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <button
      class="btn btn-primary float-right"
      @click.prevent="save(schedule)"
    >
      Lưu lại
    </button>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const SchedulesRepository = RepositoryFactory.get("adminSchedules");
const CoursesRepository = RepositoryFactory.get("adminCourses");

export default {
  props: {
    schedule: {
      type: Object,
      required: true
    },
    isCreate: Boolean
  },
  data: function() {
    return {
      errors: {},
      courseCodeOption: []
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
          ? await SchedulesRepository.create(this.schedule)
          : await SchedulesRepository.update(this.schedule);

        await this.$swal.fire({
          icon: "success",
          title: "Lịch học đã được lưu.",
          showConfirmButton: false,
          timer: 1500
        });

        this.onIndexSchedule();
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
    onIndexSchedule: function() {
      window.location.replace("/schedules");
    },
    fetchListOptionSelect: async function() {
      const result_courses_code_option = await CoursesRepository.getListCoursesCodeOption();

      this.courseCodeOption = await result_courses_code_option.data
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
