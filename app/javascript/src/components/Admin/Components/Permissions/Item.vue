<template>
  <div class="card-body">
    <div class="table-responsive">
      <table class="table">
        <thead class="text-primary">
          <tr>
            <th class="stickie">Tên chức năng (màn hình)</th>
            <th class="stickie second">Action</th>
            <th v-for="role in roles" :key="role.id">{{ role.name }}</th>
          </tr>
        </thead>
        <template v-for="group in authorizations">
          <tr v-for="(authorization, index) in group.authorizations" :key="authorization.id">
            <td
              class="stickie"
              :rowspan="group.authorizations.length"
              v-if="index==0"
            >{{ group.target_name }}</td>
            <td class="stickie second">{{ authorization.name }}</td>
            <td v-for="role in roles" :key="role.id">
              <input v-if="isAdmin(role)" type="checkbox" checked disabled />
              <input
                v-else
                type="checkbox"
                :id="`checkbox_${role.id}_${authorization.id}`"
                v-model="checkboxes[role.id][authorization.id]"
                @change="change(role.id, authorization.id)"
              />
              <label :for="`checkbox_${role.id}_${authorization.id}`"></label>
            </td>
          </tr>
        </template>
      </table>
    </div>
  </div>
</template>
<script>
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const PermissionsRepository = RepositoryFactory.get("adminPermissions");

export default {
  props: {
    authorizations: Array,
    permissions: Array,
    roles: Array,
  },
  data() {
    return {
      checkboxes: {}
    };
  },
  created() {
    this.generateCheckboxes();
  },
  methods: {
    isAdmin(role) {
      return role.name.toLocaleLowerCase() == "admin";
    },
    generateCheckboxes() {
      console.log(this.authorizations)
      console.log(this.permissions)
      console.log(this.roles)
      this.roles.forEach(role => {
        this.checkboxes[role.id] = {};
        this.authorizations.forEach(group => {
          group.authorizations.forEach(authorization => {
            this.checkboxes[role.id][authorization.id] = this.findInArray(
              role.id,
              authorization.id,
              this.permissions
            );
          });
        });
      });
    },
    findInArray(roleId, authorizationId, array) {
      const result = array.find(
        item =>
          item.role_id == roleId && item.authorization_id == authorizationId
      );

      return result ? true : false;
    },
    change(roleId, authorizationId) {
      this.apiService.call(
        async () => {
          if (this.checkboxes[roleId][authorizationId]) {
            await PermissionsRepository.create({
              roleId: roleId,
              authorizationId: authorizationId
            });
            this.$toasted.success("Cấp quyền thành công.");
          } else {
            await PermissionsRepository.remove({
              roleId: roleId,
              authorizationId: authorizationId
            });
            this.$toasted.success("Xoá quyền thành công.");
          }
        },
        e => {
          this.$toasted.error("Không thể thêm quyền quản trị!");
          console.log(e);
        }
      );
    }
  }
};
</script>
