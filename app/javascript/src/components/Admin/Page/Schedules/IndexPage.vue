<template>
  <div>
    <Search v-on:search-schedules="onSearch" />
    <div class="card">
      <div class="card-header card-header-success">
        <h4 class="card-title">Danh sách lịch học</h4>
        <p class="card-category"></p>
      </div>
      <div class="card-body">
        <div v-if="schedulesList.length > 0">
          <Paging :meta="meta" v-on:change-page="onChangePage" />
          <div class="table-responsive">
            <table class="table">
              <thead class="text-primary">
                <tr>
                  <th width="5%">Id</th>
                  <th width="8%">Tuần học</th>
                  <th width="15%">Ngày học trong tuần</th>
                  <th width="10%">Các tiết học trong ngày</th>
                  <th width="10%">Địa điểm học</th>
                  <th width="15%">Mã học phần</th>
                  <th width="10%">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <Item
                  v-for="schedule in schedulesList"
                  :key="schedule.id"
                  :schedule="schedule"
                  v-on:delete-schedule="onDelete"
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
import Item from "../../Components/Schedules/Item";
import Paging from "../../Shared/Paging";
import Search from "../../Components/Schedules/Search";

import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const SchedulesRepository = RepositoryFactory.get("adminSchedules");

export default {
  components: {
    Item,
    Paging,
    Search
  },
  data: function() {
    return {
      schedulesList: [],
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
    this.fetchSchedulesList();
  },
  methods: {
    fetchSchedulesList: async function() {
      try {
        this.$root.$refs.loading.show();

        const result = await SchedulesRepository.getList({
          q: this.q,
          page: this.meta.page
        });

        this.schedulesList = result.data.schedules;
        this.meta = result.data.meta;
      } catch (e) {
        console.log(e.message);
      } finally {
        this.$root.$refs.loading.hide();
      }
    },
    onChangePage: function(page) {
      this.meta.page = page;
      this.fetchSchedulesList();
    },
    onSearch: async function(params) {
      this.q = params;
      this.fetchSchedulesList();
    },
    onDelete: function() {
      this.fetchSchedulesList();
    }
  }
};
</script>