<template>
  <div class="card">
    <div class="card-header card-header-success">
      <h4 class="card-title">Tìm kiếm môn học</h4>
    </div>
    <div class="card-body">
      <form>
        <div class="form-group">
          <div class="row mb-8">
            <div class="col-md-4">
              <label for="name">Theo tên mã môn học</label>
              <input type="text" class="form-control" id="name" v-model="q.subject_code_cont" />
            </div>
            <div class="col-md-4">
              <label for="name">Theo tên môn học</label>
              <input type="text" class="form-control" id="name" v-model="q.subject_name_cont" />
            </div>
            <div class="col-md-4">
              <label for="name">Theo loại môn học</label>
              <select v-model="q.subject_type_eq" class="form-control">
                <option v-bind:value="null">--Vui lòng chọn--</option>
                <option v-for="(subjectType, index) in subjectTypeOption"
                        v-bind:value="subjectType"
                        :key="index">
                  {{ subjectType }}</option>
              </select>
            </div>
          </div>
          <div class="row mb-8">
            <div class="col-md-4">
              <label for="name">Theo miêu tả môn học</label>
              <input type="text" class="form-control" id="name" v-model="q.jhi_desc_cont" />
            </div>
            <div class="col-md-3">
              <label for="name">Theo mã khoa</label>
              <select v-model="q.department_eq" class="form-control">
                <option v-bind:value="null">--Vui lòng chọn--</option>
                <option v-for="(department, index) in departmentOption"
                        v-bind:value="department"
                        :key="index">
                  {{ department }}</option>
              </select>
            </div>
            <div class="col-md-3">
              <label for="name">Theo trạng thái môn học</label>
              <select v-model="q.status_eq" class="form-control">
                <option v-bind:value="null">--Vui lòng chọn--</option>
                <option value="1">Active</option>
                <option value="0">Archived</option>
              </select>
            </div>
          </div>
        </div>
        <button class="btn btn-success" @click.prevent="onSearch()">Tìm kiếm</button>
        <button class="btn btn-success" @click.prevent="onNewSubjects()">Tạo mới môn học</button>
      </form>
    </div>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const SubjectsRepository = RepositoryFactory.get("adminSubjects");

export default {
  data: function() {
    return {
      q: {
        subject_code_cont: null,
        subject_name_cont: null,
        subject_type_eq: null,
        jhi_desc_cont: null,
        department_eq: null,
        status_eq: null
      },
      departmentOption: [],
      subjectTypeOption: []
    };
  },
  created() {
    this.fetchListOptionSelect();
  },
  methods: {
    onSearch: function() {
      this.$emit("search-subjects", this.q);
    },
    onNewSubjects: function() {
      window.location.href = "/subjects/new";
    },
    fetchListOptionSelect: async function() {
      const result_department_option = await SubjectsRepository.getListDepartmentOption();
      const result_subject_type_option = await SubjectsRepository.getListSubjectTypeOption();

      this.departmentOption = await result_department_option.data
      this.subjectTypeOption = await result_subject_type_option.data
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