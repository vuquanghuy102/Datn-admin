<template>
  <div class="card">
    <div class="card-header card-header-success">
      <h4 class="card-title">Tìm kiếm sinh viên</h4>
    </div>
    <div class="card-body">
      <form>
        <div class="form-group">
          <div class="row mb-8">
            <div class="col-md-3">
              <label for="name">Theo tên mã sinh viên</label>
              <input type="text" class="form-control" id="name" v-model="q.student_code_cont" />
            </div>
            <div class="col-md-3">
              <label for="name">Theo tên sinh viên</label>
              <input type="text" class="form-control" id="name" v-model="q.name_cont" />
            </div>
            <div class="col-md-3">
              <label for="name">Theo lớp học</label>
              <select v-model="q.class_name_eq" class="form-control">
                <option v-bind:value="null">--Vui lòng chọn--</option>
                <option v-for="(className, index) in classNameOption"
                        v-bind:value="className"
                        :key="index">
                  {{ className }}</option>
              </select>
            </div>
            <div class="col-md-3">
              <label for="name">Theo chương trình học</label>
              <select v-model="q.program_eq" class="form-control">
                <option v-bind:value="null">--Vui lòng chọn--</option>
                <option v-for="(program, index) in programOption"
                        v-bind:value="program"
                        :key="index">
                  {{ program }}</option>
              </select>
            </div>
          </div>
        </div>
        <button class="btn btn-success" @click.prevent="onSearch()">Tìm kiếm</button>
        <button class="btn btn-success" @click.prevent="onNewStudents()">Tạo mới sinh viên</button>
      </form>
    </div>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const StudentsRepository = RepositoryFactory.get("adminStudents");

export default {
  data: function() {
    return {
      q: {
        student_code_cont: null,
        name_cont: null,
        class_name_eq: null,
        program_eq: null
      },
      classNameOption: [],
      programOption: [],
      modalExportCsv: false
    };
  },
  created() {
    this.fetchListOptionSelect();
  },
  methods: {
    onSearch: function() {
      this.$emit("search-students", this.q);
    },
    onNewStudents: function() {
      window.location.href = "/students/new";
    },
    fetchListOptionSelect: async function() {
      const result_class_name_option = await StudentsRepository.getListClassNameOption();
      const result_program_option = await StudentsRepository.getListProgramOption();

      this.classNameOption = await result_class_name_option.data
      this.programOption = await result_program_option.data
    },
    onOpenFormExpoCSV: function() {
      this.modalExportCsv = true
    }
  }
};
</script>
<style>
.col-search {
  display: flex;
  flex-direction: column;
}
.mb-8 {
  margin-bottom: 8px;
}
</style>