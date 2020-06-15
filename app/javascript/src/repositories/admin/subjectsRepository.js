import Repository from "../../AdminRepository";
import qs from "qs";

const resource = "subjects";

export default {
  get(id) {
    return Repository.get(`${resource}/${id}.json`);
  },
  getList(searchParams) {
    const paramsSerializer = (params = {}) =>
      qs.stringify(searchParams, { arrayFormat: "brackets" });

    const params = {
      q: this.q,
      page: this.page,
    };

    return Repository.get(`${resource}.json`, {
      params,
      paramsSerializer,
    });
  },
  getListDepartmentOption() {
    return Repository.get(`${resource}/get_list_department_option.json`);
  },
  getListSubjectTypeOption() {
    return Repository.get(`${resource}/get_list_subject_type_option.json`);
  },
  getListNameOption() {
    return Repository.get(`${resource}/get_list_name_option.json`);
  },
  create(params) {
    return Repository.post(`${resource}.json`, params);
  },
  update(params) {
    return Repository.put(`${resource}/${params.id}.json`, params);
  },
  destroy(id) {
    return Repository.delete(`${resource}/${id}.json`);
  }
};
