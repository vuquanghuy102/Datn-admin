import Repository from "../../AdminRepository";
import qs from "qs";

const resource = "subjects_required";

export default {
  get(subject_id) {
    return Repository.get(`${resource}/get_list.json`, {
      params: {
        subject_id: subject_id
      }
    });
  }
};