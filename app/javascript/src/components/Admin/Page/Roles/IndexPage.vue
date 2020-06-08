<template>
  <div>
    <Search v-on:search-roles="onSearch" />
    <div class="card">
      <div class="card-header card-header-success">
        <h4 class="card-title">Danh sách chức vụ</h4>
        <p class="card-category"></p>
      </div>
      <div class="card-body">
        <div v-if="rolesList.length > 0">
          <Paging :meta="meta" v-on:change-page="onChangePage" />
          <div class="table-responsive">
            <table class="table">
              <thead class="text-primary">
                <tr>
                  <th width="10%">Id</th>
                  <th width="25%">Tên chức vụ</th>
                  <th width="55%">Miêu tả chức vụ</th>
                  <th width="10%">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <Item
                  v-for="role in rolesList"
                  :key="role.id"
                  :role="role"
                  v-on:delete-role="onDelete"
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
import Item from "../../Components/Roles/Item";
import Paging from "../../Shared/Paging";
import Search from "../../Components/Roles/Search";

import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const RolesRepository = RepositoryFactory.get("adminRoles");

export default {
  components: {
    Item,
    Paging,
    Search
  },
  data: function() {
    return {
      rolesList: [],
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
    this.fetchRolesList();
  },
  methods: {
    fetchRolesList: async function() {
      try {
        this.$root.$refs.loading.show();

        const result = await RolesRepository.getList({
          q: this.q,
          page: this.meta.page
        });

        this.rolesList = result.data.roles;
        this.meta = result.data.meta;
      } catch (e) {
        console.log(e.message);
      } finally {
        this.$root.$refs.loading.hide();
      }
    },
    onChangePage: function(page) {
      this.meta.page = page;
      this.fetchRolesList();
    },
    onSearch: async function(params) {
      this.q = params;
      this.fetchRolesList();
    },
    onDelete: function() {
      this.fetchRolesList();
    }
  }
};
</script>