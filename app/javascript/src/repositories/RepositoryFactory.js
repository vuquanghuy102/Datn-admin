// admin
import AdminUsersRepository from "./admin/usersRepository";
import AdminRolesRepository from "./admin/rolesRepository";
import AdminPermissionsRepository from "./admin/permissionsRepository";
import AdminAuthorizationsRepository from "./admin/authorizationsRepository";
import AdminSubjectsRepository from "./admin/subjectsRepository";
import AdminStudentsRepository from "./admin/studentsRepository";
import AdminCoursesRepository from "./admin/coursesRepository";
import AdminSchedulesRepository from "./admin/schedulesRepository";

import AdminSubjectsRequiredRepository from "./admin/subjectsRequiredRepository";
import AdminSubjectsPairRepository from "./admin/subjectsPairRepository";

const repositories = {
  // Admin page
  adminUsers: AdminUsersRepository,
  adminRoles: AdminRolesRepository,
  adminPermissions: AdminPermissionsRepository,
  adminAuthorizations: AdminAuthorizationsRepository,
  adminSubjects: AdminSubjectsRepository,
  adminStudents: AdminStudentsRepository,
  adminCourses: AdminCoursesRepository,
  adminSchedules: AdminSchedulesRepository,

  adminSubjectsRequired: AdminSubjectsRequiredRepository,
  adminSubjectsPair:AdminSubjectsPairRepository,
};

export const RepositoryFactory = {
  get: (name) => repositories[name],
};
