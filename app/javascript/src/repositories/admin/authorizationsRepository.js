import Repository from "../../AdminRepository";
import qs from "qs";

const resource = "authorizations";

export default {
  getList() {
    return Repository.get(`${resource}/get_list.json`)
  }
};