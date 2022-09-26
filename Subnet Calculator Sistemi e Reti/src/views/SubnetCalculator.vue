<template>
  <div class="col">
    <div class="col-md-12">
      <h1>SUBNET CALCULATOR</h1>  
    </div>
    <div class="input-group mb-3">
      <div class="input-group-append">
        <span class="input-group-text" id="basic-addon2">IP</span>
      </div>
      <input type="text" class="form-control" placeholder="insert ip address" v-model="Data.ip">
    </div>
    <div class="input-group mb-3">
      <div class="input-group-append">
        <span class="input-group-text" id="basic-addon2">SUBNET</span>
      </div>
      <input type="text" class="form-control" placeholder="insert subnet bit" v-model="Data.subnet">
    </div>
    <div class="input-group mb-3">
      <div class="btn btn-primary" @click="getData">Send</div>
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
    getData() {
      let Data = {
        ip: this.Data.ip,
        subnet: this.Data.subnet,
      };
      console.log(Data.ip, Data.subnet);
      axios
        .get(`https://networkcalc.com/api/ip/${this.Data.ip}/${this.Data.subnet}`)
        //.get("https://networkcalc.com/api/ip/192.168.1.1/25")
        .then(response => {
          console.log(response)
        })
    },
  },
};
</script>

<style>
@import'bootstrap/dist/css/bootstrap.css';
</style>
