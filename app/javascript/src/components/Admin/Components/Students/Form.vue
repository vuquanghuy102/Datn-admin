<template>
  <div>
    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Mã sinh viên</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="student.student_code"
          class="form-control"
          readonly
        />
        <div class="validation" v-if="errors.student_code">
          <p v-for="(error, key) in errors.student_code" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Họ sinh viên</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="fp_user.first_name"
          class="form-control"
        />
        <div class="validation" v-if="errors.first_name">
          <p v-for="(error, key) in errors.first_name" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Tên đệm sinh viên</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="fp_user.last_name"
          class="form-control"
        />
        <div class="validation" v-if="errors.last_name">
          <p v-for="(error, key) in errors.last_name" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Sinh ngày</label>
      <div class="col-sm-10">
        <date-picker v-model="student.dob" valueType="format"></date-picker>
        <div class="validation" v-if="errors.dob">
          <p v-for="(error, key) in errors.dob" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Lớp học</label>
      <div class="col-sm-10">
        <select v-model="student.class_name" class="form-control">
          <option v-bind:value="null">--Vui lòng chọn--</option>
          <option v-for="(className, index) in classNameOption"
                  v-bind:value="className"
                  :key="index">
            {{ className }}</option>
        </select>
        <div class="validation" v-if="errors.class_name">
          <p v-for="(error, key) in errors.class_name" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Chương trình học</label>
      <div class="col-sm-10">
        <select v-model="student.program" class="form-control">
          <option v-bind:value="null">--Vui lòng chọn--</option>
          <option v-for="(program, index) in programOption"
                  v-bind:value="program"
                  :key="index">
            {{ program }}</option>
        </select>
        <div class="validation" v-if="errors.program">
          <p v-for="(error, key) in errors.program" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Email</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="fp_user.email"
          class="form-control"
        />
        <div class="validation" v-if="errors.email">
          <p v-for="(error, key) in errors.email" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row" v-if="isCreate">
      <label for="kind" class="col-sm-2 col-form-label">Mật khẩu</label>
      <div class="col-sm-10">
        <input
          type="password"
          v-model="fp_user.password"
          class="form-control"
        />
        <div class="validation" v-if="errors.password">
          <p v-for="(error, key) in errors.password" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row" v-if="isCreate">
      <label for="kind" class="col-sm-2 col-form-label">Xác nhận mật khẩu</label>
      <div class="col-sm-10">
        <input
          type="password"
          v-model="fp_user.password_confirmation"
          class="form-control"
        />
        <div class="validation" v-if="errors.password_confirmation">
          <p v-for="(error, key) in errors.password_confirmation" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <button
      class="btn btn-primary float-right"
      @click.prevent="save(student)"
    >
      Lưu lại
    </button>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const StudentsRepository = RepositoryFactory.get("adminStudents");

import DatePicker from 'vue2-datepicker';
import 'vue2-datepicker/index.css';

export default {
  components: {
    DatePicker
  },
  props: {
    student: {
      type: Object,
      required: true
    },
    fp_user: {
      type: Object,
      required: true
    },
    isCreate: Boolean
  },
  data: function() {
    return {
      errors: {},
      classNameOption: [],
      programOption: []
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
          ? await StudentsRepository.create(this.student, this.fp_user)
          : await StudentsRepository.update(this.student, this.fp_user);

        await this.$swal.fire({
          icon: "success",
          title: "Sinh viên đã được lưu.",
          showConfirmButton: false,
          timer: 1500
        });

        this.onIndexStudent();
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
    onIndexStudent: function() {
      window.location.replace("/students");
    },
    fetchListOptionSelect: async function() {
      const result_class_name_option = await StudentsRepository.getListClassNameOption();
      const result_program_option = await StudentsRepository.getListProgramOption();

      this.classNameOption = await result_class_name_option.data
      this.programOption = await result_program_option.data
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
