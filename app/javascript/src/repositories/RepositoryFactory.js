// admin
import AdminUsersRepository from "./admin/usersRepository";
import AdminRolesRepository from "./admin/rolesRepository";

const repositories = {
  // Admin page
  adminUsers: AdminUsersRepository,
  adminRoles: AdminRolesRepository,
};

export const RepositoryFactory = {
  get: (name) => repositories[name],
};
