<template>
  <div>
    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Chức vụ</label>
      <div class="col-sm-10">
        <div v-for="(userRole, index) in userRolesAttributes" :key="index">
          <div class="flex w-full items-center mb-3 select_role" v-if="!userRole._destroy">
            <div class="select-wrapper select_option_role">
              <select :key="index" v-model="userRole.role_id" class="form-control">
                <option
                  v-for="role in roleOptions"
                  v-bind:value="role.value"
                  :key="role.value"
                >{{ role.name }}</option>
              </select>
            </div>
            <a class="button danger mr-2 ml-4 destroy_role"
               @click="removeUserRole(index)"
               v-if="!userRole._destroy">
              <i class="fas fa-trash fa-lg" />
            </a>
          </div>
        </div>
        <button class="btn btn-primary" @click="addUserRole" >
          <i class="fas fa-plus"></i>
        </button><br>
        <div class="validation" v-if="errors.user_roles">
          <p v-for="(error, key) in errors.user_roles" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Email</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="user.email"
          class="form-control"
        />
        <div class="validation" v-if="errors.email">
          <p v-for="(error, key) in errors.email" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row">
      <label for="kind" class="col-sm-2 col-form-label">Tên người giữ tài khoản</label>
      <div class="col-sm-10">
        <input
          type="text"
          v-model="user.name"
          class="form-control"
        />
        <div class="validation" v-if="errors.name">
          <p v-for="(error, key) in errors.name" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <div class="form-group row" v-if="isCreate">
      <label for="kind" class="col-sm-2 col-form-label">Mật khẩu</label>
      <div class="col-sm-10">
        <input
          type="password"
          v-model="user.password"
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
          v-model="user.password_confirmation"
          class="form-control"
        />
        <div class="validation" v-if="errors.password_confirmation">
          <p v-for="(error, key) in errors.password_confirmation" :key="key">{{ error }}</p>
        </div>
      </div>
    </div>

    <button
      class="btn btn-primary float-right"
      @click.prevent="save(user)"
    >
      Lưu lại
    </button>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const UsersRepository = RepositoryFactory.get("adminUsers");

export default {
  props: {
    user: {
      type: Object,
      required: true
    },
    roleOptions: {
      type: Array,
      required: true
    },
    userRolesAttributes: {
      type: Array,
      required: true
    },
    isCreate: Boolean
  },
  data: function() {
    return {
      errors: {}
    };
  },
  methods: {
    removeUserRole: function(index) {
      const userRole = this.userRolesAttributes[index];

      if (userRole.id == null) {
        this.userRolesAttributes.splice(index, 1);
      } else {
        this.$set(this.userRolesAttributes[index], "_destroy", true);
      }
    },
    addUserRole: function() {
      this.userRolesAttributes.push({
        id: null,
        _destroy: false
      });
    },
    save: async function() {
      this.errors = {};
      let arr = this.userRolesAttributes.filter(x => {
        return x.role_id != undefined;
      });

      this.user.user_roles_attributes = arr;
      let self = this;

      try {
        const response = this.isCreate
          ? await UsersRepository.create(this.user)
          : await UsersRepository.update(this.user);

        await this.$swal.fire({
          icon: "success",
          title: "Tài khoản đã được lưu.",
          showConfirmButton: false,
          timer: 1500
        });

        this.onIndexRole();
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
    onIndexRole: function() {
      window.location.replace("/users");
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

.select_role {
  display: flex;
}

.select_option_role {
  width: 30%;
}

.destroy_role {
  margin-top: 8px;
  margin-left: 15px !important;
  color: red !important;
}
</style>
