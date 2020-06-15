<template>
  <div>
    <Form :schedule="schedule"
          :is-create="true" />
    <button class="btn btn-info" @click="onIndexSchedule()">Trở về danh sách</button>
  </div>
</template>
<script>
import Form from "../../Components/Schedules/Form";

export default {
  components: {
    Form,
  },
  data: function() {
    return {
      schedule: {}
    };
  },
  methods: {
    onIndexSchedule: function() {
      window.location.replace("/schedules");
    }
  }
};
</script>