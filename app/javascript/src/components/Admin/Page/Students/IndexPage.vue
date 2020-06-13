<template>
  <div>
    <Search v-on:search-students="onSearch" />
    <div class="card">
      <div class="card-header card-header-success">
        <h4 class="card-title">Danh sách sinh viên</h4>
        <p class="card-category"></p>
      </div>
      <div class="card-body">
        <div v-if="studentsList.length > 0">
          <Paging :meta="meta" v-on:change-page="onChangePage" />
          <div class="table-responsive">
            <table class="table">
              <thead class="text-primary">
                <tr>
                  <th width="5%">Id</th>
                  <th width="10%">Mã sinh viên</th>
                  <th width="15%">Tên sinh viên</th>
                  <th width="10%">Ngày sinh</th>
                  <th width="15%">Tên lớp</th>
                  <th width="15%">Tên chương trình học</th>
                  <th width="10%">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <Item
                  v-for="student in studentsList"
                  :key="student.id"
                  :student="student"
                  v-on:delete-student="onDelete"
                />
              </tbody>
            </table>
          </div>
          <Paging :meta="meta" v-on:change-page="onChangePage" />
        </div>
        <div v-else>
          <h3>Không có dữ liệu phù hợp</h3>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import Item from "../../Components/Students/Item";
import Paging from "../../Shared/Paging";
import Search from "../../Components/Students/Search";

import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const StudentsRepository = RepositoryFactory.get("adminStudents");

export default {
  components: {
    Item,
    Paging,
    Search
  },
  data: function() {
    return {
      studentsList: [],
      meta: {
        total: null,
        page: 1,
        from: null,
        to: null,
        series: []
      },
      q: {}
    };
  },
  created: function() {
    this.fetchStudentsList();
  },
  methods: {
    fetchStudentsList: async function() {
      try {
        this.$root.$refs.loading.show();

        const result = await StudentsRepository.getList({
          q: this.q,
          page: this.meta.page
        });

        this.studentsList = result.data.students;
        this.meta = result.data.meta;
      } catch (e) {
        console.log(e.message);
      } finally {
        this.$root.$refs.loading.hide();
      }
    },
    onChangePage: function(page) {
      this.meta.page = page;
      this.fetchStudentsList();
    },
    onSearch: async function(params) {
      this.q = params;
      this.fetchStudentsList();
    },
    onDelete: function() {
      this.fetchStudentsList();
    }
  }
};
</script>