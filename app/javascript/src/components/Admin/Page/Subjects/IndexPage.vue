<template>
  <div>
    <Search v-on:search-subjects="onSearch" />
    <div class="card">
      <div class="card-header card-header-success">
        <h4 class="card-title">Danh sách môn hoc</h4>
        <p class="card-category"></p>
      </div>
      <div class="card-body">
        <div v-if="subjectsList.length > 0">
          <Paging :meta="meta" v-on:change-page="onChangePage" />
          <div class="table-responsive">
            <table class="table">
              <thead class="text-primary">
                <tr>
                  <th width="5%">Id</th>
                  <th width="8%">Mã môn học</th>
                  <th width="15%">Tên môn học</th>
                  <th width="10%">Loại môn học</th>
                  <th width="10%">Hệ số môn học</th>
                  <th width="15%">Miêu tả môn học</th>
                  <th width="10%">Mã khoa</th>
                  <th width="7%">Trạng thái</th>
                  <th width="7%">redit</th>
                  <th width="10%">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <Item
                  v-for="subject in subjectsList"
                  :key="subject.id"
                  :subject="subject"
                  v-on:delete-subject="onDelete"
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
import Item from "../../Components/Subjects/Item";
import Paging from "../../Shared/Paging";
import Search from "../../Components/Subjects/Search";

import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const SubjectsRepository = RepositoryFactory.get("adminSubjects");

export default {
  components: {
    Item,
    Paging,
    Search
  },
  data: function() {
    return {
      subjectsList: [],
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
    this.fetchSubjectsList();
  },
  methods: {
    fetchSubjectsList: async function() {
      try {
        this.$root.$refs.loading.show();

        const result = await SubjectsRepository.getList({
          q: this.q,
          page: this.meta.page
        });

        this.subjectsList = result.data.subjects;
        this.meta = result.data.meta;
      } catch (e) {
        console.log(e.message);
      } finally {
        this.$root.$refs.loading.hide();
      }
    },
    onChangePage: function(page) {
      this.meta.page = page;
      this.fetchSubjectsList();
    },
    onSearch: async function(params) {
      this.q = params;
      this.fetchSubjectsList();
    },
    onDelete: function() {
      this.fetchSubjectsList();
    }
  }
};
</script>