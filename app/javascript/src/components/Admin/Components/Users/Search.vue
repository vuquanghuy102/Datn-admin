<template>
  <div class="card">
    <div class="card-header card-header-success">
      <h4 class="card-title">Tìm kiếm tài khoản</h4>
    </div>
    <div class="card-body">
      <form>
        <div class="form-group">
          <div class="row mb-8">
            <div class="col-md-6">
              <label for="name">Theo tên người giữ tài khoản</label>
              <input type="text" class="form-control" id="name" v-model="q.name_cont" />
            </div>
            <div class="col-md-6">
              <label for="name">Theo email tài khoản</label>
              <input type="text" class="form-control" id="name" v-model="q.email_cont" />
            </div>
          </div>
        </div>
        <button class="btn btn-success" @click.prevent="onSearch()">Tìm kiếm</button>
        <button class="btn btn-success" @click.prevent="onNewUsers()">Tạo mới tài khoản</button>
      </form>
    </div>
  </div>
</template>
<script>
export default {
  data: function() {
    return {
      q: {
        name_cont: null,
        email_cont: null
      }
    };
  },
  methods: {
    onSearch: function() {
      this.$emit("search-users", this.q);
    },
    onNewUsers: function() {
      window.location.href = "/users/new";
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