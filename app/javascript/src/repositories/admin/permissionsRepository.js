import Repository from "../../AdminRepository";
import qs from "qs";

const resource = "permissions";

export default {
  getList() {
    return Repository.get(`${resource}/get_list.json`)
  },
  create(params) {
    return Repository.post(`${resource}`, params);
  },
  remove(params) {
    return Repository.post(`${resource}/remove`, params);
  }
};
