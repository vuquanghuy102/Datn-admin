// admin
import AdminUsersRepository from "./admin/usersRepository";
import AdminRolesRepository from "./admin/rolesRepository";
import AdminPermissionsRepository from "./admin/permissionsRepository";
import AdminAuthorizationsRepository from "./admin/authorizationsRepository";

const repositories = {
  // Admin page
  adminUsers: AdminUsersRepository,
  adminRoles: AdminRolesRepository,
  adminPermissions: AdminPermissionsRepository,
  adminAuthorizations: AdminAuthorizationsRepository,
};

export const RepositoryFactory = {
  get: (name) => repositories[name],
};
