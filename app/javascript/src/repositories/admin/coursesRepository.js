import Repository from "../../AdminRepository";
import qs from "qs";

const resource = "courses";

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
  getListCourseStatusOption() {
    return Repository.get(`${resource}/get_list_courses_status_option.json`);
  },
  getListCoursesCodeOption() {
    return Repository.get(`${resource}/get_list_courses_code_option.json`);
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
