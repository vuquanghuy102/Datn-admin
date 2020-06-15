<template>
  <div>
    <Form :schedule="schedule"
          :is-create="false" />
    <button class="btn btn-info" @click="onIndexSchedule()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Schedules/Form";
import { RepositoryFactory } from "../../../../repositories/RepositoryFactory";
const SchedulesRepository = RepositoryFactory.get("adminSchedules");

export default {
  components: {
    Form,
  },
  props: {
    scheduleId: {
      type: Number,
      required: true
    }
  },
  data: function() {
    return {
      schedule: {}
    };
  },
  created: function() {
    this.fetchSchedule()
  },
  methods: {
    onIndexSchedule: function() {
      window.location.replace("/schedules");
    },
    fetchSchedule: async function() {
      const result = await SchedulesRepository.get(this.scheduleId);

      this.schedule = result.data
    }
  }
};
</script>