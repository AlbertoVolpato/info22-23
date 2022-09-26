<template>
  <h1 style="text-align: center;">SUBNET CALCULATOR</h1>
  <div class="row">
    <div class="input-group mb-3">
      <input type="text" class="form-control" placeholder="insert ip address" v-model="Data.ip">
      <div class="input-group-append">
        <span class="input-group-text" id="basic-addon2">IP</span>
      </div>
    </div>
    <div class="input-group mb-3">
      <input type="text" class="form-control" placeholder="insert subnet bit" v-model="Data.subnet">
      <div class="input-group-append">
        <span class="input-group-text" id="basic-addon2">SUBNET</span>
      </div>
    </div>
    <div class="input-group mb-3">
      <div class="btn btn-primary" @click="getPorcoDio">Send</div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  name: "AboutView",
  data() {
    return {
      Data: { ip: "", subnet: "" },
    };
  },
  methods: {
    getPorcoDio() {
      axios
        //.get(`https://networkcalc.com/api/ip/${ip}/${subnet}`)
        .get("https://networkcalc.com/api/ip/192.168.1.1/25")
        .then(console.log(response.data))
    },
    getData() {
      let Data = {
        ip: this.Data.ip,
        subnet: this.Data.subnet,
      };
      console.log("ciaooo", ip, subnet);
      axios
        //.get(`https://networkcalc.com/api/ip/${ip}/${subnet}`)
        .get("https://networkcalc.com/api/ip/192.168.1.1/25")
        .then(console.log(response.data))
    },
  },
};
</script>

<style>
@import'bootstrap/dist/css/bootstrap.css';

@media (min-width: 1024px) {
  .about {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}
</style>
