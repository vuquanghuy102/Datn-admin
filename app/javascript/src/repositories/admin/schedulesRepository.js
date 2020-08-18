import Repository from "../../AdminRepository";
import qs from "qs";

const resource = "schedules";
const headers = {
  'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6Ik5UZG1aak00WkRrM05qWTBZemM1TW1abU9EZ3dNVEUzTVdZd05ERTVNV1JsWkRnNE56YzRaQT09In0.eyJhdWQiOiJodHRwOlwvXC9vcmcud3NvMi5hcGltZ3RcL2dhdGV3YXkiLCJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhcHBsaWNhdGlvbiI6eyJvd25lciI6ImFkbWluIiwidGllclF1b3RhVHlwZSI6InJlcXVlc3RDb3VudCIsInRpZXIiOiJVbmxpbWl0ZWQiLCJuYW1lIjoiREFUTiIsImlkIjozNCwidXVpZCI6bnVsbH0sInNjb3BlIjoiYW1fYXBwbGljYXRpb25fc2NvcGUgZGVmYXVsdCIsImlzcyI6Imh0dHBzOlwvXC9sb2NhbGhvc3Q6OTQ0M1wvb2F1dGgyXC90b2tlbiIsInRpZXJJbmZvIjp7IlVubGltaXRlZCI6eyJ0aWVyUXVvdGFUeXBlIjoicmVxdWVzdENvdW50Iiwic3RvcE9uUXVvdGFSZWFjaCI6dHJ1ZSwic3Bpa2VBcnJlc3RMaW1pdCI6MCwic3Bpa2VBcnJlc3RVbml0IjpudWxsfX0sImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOiJjYXJib24uc3VwZXIiLCJuYW1lIjoiQ1JFQVRFIFNUVURFTlQiLCJjb250ZXh0IjoiXC9jcmVhdGVfc3R1ZGVudFwvMS4wIiwicHVibGlzaGVyIjoiYWRtaW4iLCJ2ZXJzaW9uIjoiMS4wIiwic3Vic2NyaXB0aW9uVGllciI6IlVubGltaXRlZCJ9LHsic3Vic2NyaWJlclRlbmFudERvbWFpbiI6ImNhcmJvbi5zdXBlciIsIm5hbWUiOiJDUkVBVEUgU0NIRURVTEUiLCJjb250ZXh0IjoiXC9jcmVhdGVfc2NoZWR1bGVcLzEuMCIsInB1Ymxpc2hlciI6ImFkbWluIiwidmVyc2lvbiI6IjEuMCIsInN1YnNjcmlwdGlvblRpZXIiOiJVbmxpbWl0ZWQifSx7InN1YnNjcmliZXJUZW5hbnREb21haW4iOiJjYXJib24uc3VwZXIiLCJuYW1lIjoiQ1JFQVRFIENPVVJTRSIsImNvbnRleHQiOiJcL2NyZWF0ZV9jb3Vyc2VcLzEuMCIsInB1Ymxpc2hlciI6ImFkbWluIiwidmVyc2lvbiI6IjEuMCIsInN1YnNjcmlwdGlvblRpZXIiOiJVbmxpbWl0ZWQifSx7InN1YnNjcmliZXJUZW5hbnREb21haW4iOiJjYXJib24uc3VwZXIiLCJuYW1lIjoiQ1JFQVRFIFNVQkpFQ1QiLCJjb250ZXh0IjoiXC9jcmVhdGVfc3ViamVjdFwvMS4wIiwicHVibGlzaGVyIjoiYWRtaW4iLCJ2ZXJzaW9uIjoiMS4wIiwic3Vic2NyaXB0aW9uVGllciI6IlVubGltaXRlZCJ9XSwiY29uc3VtZXJLZXkiOiJjT1k0ZVNjY1g2a2d4WEZLZmJBeElOZUVlaDRhIiwiZXhwIjozNzQ1MTE5MzE2LCJpYXQiOjE1OTc2MzU2NjksImp0aSI6ImI4NzQyN2Q0LTY3MDItNGNhNC05MThkLWMxNWYzODFmZmYxMCJ9.nCLEp_Bo5qk18JiuEJ84QL_I-RpC2cXoCO-NLNyX4Um7xSUXDukvzjVY8qPIJftHaAB5Tl1Zs2MML_5kRAeXsLJIbpOSdWQBoYx_KvMDTvkPqSZBcrDpDdihCjCWI3au8vLLOptcYwE0knzlbu3NFT5Q1UYhtJRuZkNS4mlqvZ3Lr2GxNQJbRacWH73Vcso7CMhztIZTxIPdczncCYWnKsuYimllXSvc-ICxHYYnb5uQ2Cf-s7kprQrhGbvsAtvQHYQzxJBCfo1bMANdk2OCxrfrWp459Vq9XEK7iqjsHTEWmoNQkXa8uF9vflmIXzJBTchLayFQLT9uGmetpm-6yQ'
};

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
  create(params) {
    return Repository.post(
      `https://localhost:8243/create_schedule/1.0?week_value=${params.week_value}&week_day_value=${params.week_day_value}&period_value=${params.period_value}&location=${params.location}&course_id=${params.course_id}`, params, {
        headers: headers
    });
  },
  update(params) {
    return Repository.put(`${resource}/${params.id}.json`, params);
  },
  destroy(id) {
    return Repository.delete(`${resource}/${id}.json`);
  }
};
