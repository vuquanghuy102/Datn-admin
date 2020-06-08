<template>
  <div>
    <Search v-on:search-users="onSearch"/>
    <div class="card">
      <div class="card-header card-header-success">
        <h4 class="card-title">Danh sách tài khoản</h4>
        <p class="card-category"></p>
      </div>
      <div class="card-body">
        <div v-if="usersList.length > 0">
          <Paging :meta="meta" v-on:change-page="onChangePage" />
          <div class="table-responsive">
            <table class="table">
              <thead class="text-primary">
                <tr>
                  <th width="10%">Id</th>
                  <th width="25%">Tên người giữ tài khoản</th>
                  <th width="25%">Email</th>
                  <th width="25%">Chức vụ</th>
                  <th width="10%">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <Item
                  v-for="user in usersList"
                  :key="user.id"
                  :user="user"
                  v-on:delete-user="onDelete"
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
import Item from "../../Components/Users/Item";
import Paging from "../../Shared/Paging";
import Search from "../../Components/Users/Search";

import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const UsersRepository = RepositoryFactory.get("adminUsers");

export default {
  components: {
    Item,
    Paging,
    Search
  },
  data: function() {
    return {
      usersList: [],
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
    this.fetchUsersList();
  },
  methods: {
    fetchUsersList: async function() {
      try {
        this.$root.$refs.loading.show();

        const result = await UsersRepository.getList({
          q: this.q,
          page: this.meta.page
        });

        this.usersList = result.data.users;
        this.meta = result.data.meta;
      } catch (e) {
        console.log(e.message);
      } finally {
        this.$root.$refs.loading.hide();
      }
    },
    onChangePage: function(page) {
      this.meta.page = page;
      this.fetchUsersList();
    },
    onSearch: async function(params) {
      this.q = params;
      this.fetchUsersList();
    },
    onDelete: function() {
      this.fetchUsersList();
    }
  }
};
</script>