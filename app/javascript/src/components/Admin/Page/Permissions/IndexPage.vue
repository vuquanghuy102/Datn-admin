<template>
  <div>
    <div class="card">
      <div class="card-header card-header-success">
        <h4 class="card-title">Danh sách chức vụ</h4>
        <p class="card-category"></p>
      </div>
      <Item :permissions="permissions"
            :roles="roles"
            :authorizations="authorizations"
            />
    </div>
  </div>
</template>
<script>
import Item from "../../Components/Permissions/Item"
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const PermissionsRepository = RepositoryFactory.get("adminPermissions");
const RolesRepository = RepositoryFactory.get("adminRoles");
const AuthorizationsRepository = RepositoryFactory.get("adminAuthorizations");

export default {
  props: {
    authorizations: Array,
    permissions: Array,
    roles: Array
  },
  components: {
    Item
  },
  // data() {
  //   return {
  //     authorizations: [],
  //     permissions: [],
  //     roles: [],
  //   };
  // },
  // created: async function() {
  //   await this.fetchData();
  // },
  // methods: {
  //   fetchData: async function() {
  //     const result_permissions = await PermissionsRepository.getList();
  //     const result_roles = await RolesRepository.getListAll();
  //     const result_authorizations = await AuthorizationsRepository.getList();

  //     this.authorizations = await result_authorizations.data
  //     this.permissions = await result_permissions.data
  //     this.roles = await result_roles.data
  //   }
  // }
};
</script>
