// admin
import AdminUsersRepository from "./admin/usersRepository";
import AdminRolesRepository from "./admin/rolesRepository";
import AdminPermissionsRepository from "./admin/permissionsRepository";
import AdminAuthorizationsRepository from "./admin/authorizationsRepository";
import AdminSubjectsRepository from "./admin/subjectsRepository"
import AdminStudentsRepository from "./admin/studentsRepository"

const repositories = {
  // Admin page
  adminUsers: AdminUsersRepository,
  adminRoles: AdminRolesRepository,
  adminPermissions: AdminPermissionsRepository,
  adminAuthorizations: AdminAuthorizationsRepository,
  adminSubjects: AdminSubjectsRepository,
  adminStudents: AdminStudentsRepository,
};

export const RepositoryFactory = {
  get: (name) => repositories[name],
};
