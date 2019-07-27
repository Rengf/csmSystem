<template>
  <div class="admin">
    <div class="userlistbox">
      <div class="somebtn">
        <button @click="getalladmin()">全部管理员</button>
        <button @click="getadmin('isadmin',1)">普通管理员</button>
        <button @click="getadmin('isadmin',2)">超级管理员</button>
        <search-box @searchmsg="searchuser"></search-box>
      </div>
      <div class="adminlist">
        <table>
          <thead>
            <tr>
              <th width="30">#</th>
              <th width="120">用户名</th>
              <th width="100">真实姓名</th>
              <th width="150">用户类型</th>
              <th width="100">注册电话</th>
              <th width="150">注册邮箱</th>
              <th width="180">注册时间</th>
              <th width="180">最后修改时间</th>
              <th width="70">登录统计</th>
              <th width="180">上次登录</th>
              <th width="100">操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(user,index) in adminlist" :key="index">
              <td>{{index+1}}</td>
              <td>
                <router-link :to="{path:'/admin/userinfo?user_id='+user.user_id}">{{user.user_name}}</router-link>
              </td>
              <td>{{user.real_name==null?'未实名':user.real_name}}</td>
              <td>{{user.isadmin=='1'?'普通管理员':'超级管理员'}}</td>
              <td>{{user.user_tel}}</td>
              <td>{{user.user_email}}</td>
              <td>{{user.regist_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
              <td>{{user.last_modified_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
              <td>{{user.statistics}}</td>
              <td>{{user.last_login_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
              <td>
                <button @click="deleteuser(user.user_id)">删除</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <Tips v-if="showtips" :tips="tips"></Tips>
  </div>
</template>
<script>
import SearchBox from "@/components/Communal/searchbox";
import Tips from "@/components/Communal/tips";
import axios from "axios";
import { mapActions, mapGetters } from "vuex";
import { RECEIVE_ADMIN_LIST } from "@/store/mutations-types";
export default {
  name: "userlist",
  data() {
    return {
      showtips: false,
      tips: "",
      condition: ""
    };
  },
  created() {
    this.condition = this.$route.query;
    this.$store.dispatch("getAdminlist", this.condition);
  },
  computed: {
    ...mapGetters(["adminlist"])
  },
  methods: {
    getadmin(way, data) {
      this.$router.push("/admin/adminlist?" + way + "=" + data);
      this.condition = this.$route.query;
      this.$store.dispatch("getAdminlist", this.condition);
    },
    deleteuser(id) {
      axios
        .post("http://localhost:3333/admin/deleteuser", {
          user_id: id
        })
        .then(
          response => {
            if (response.data.code == 0) {
              this.$store.dispatch("getAdminlist");
              console.log(response.data.message);
            } else {
              console.log("删除失败");
            }
          },
          response => {
            console.log("error:" + response);
          }
        );
    },
    searchuser(searchmsg) {
      axios
        .post("http://localhost:3333/admin/searchadmin", {
          searchmsg: searchmsg
        })
        .then(
          response => {
            if (response.data.code == 0) {
              this.$store.commit(RECEIVE_ADMIN_LIST, response.data.adminlist);
              this.tips = response.data.message;
              this.showtips = true;
              setTimeout(() => {
                this.showtips = false;
              }, 2000);
            } else {
              console.log("查询失败");
            }
          },
          response => {
            console.log("error:" + response);
          }
        );
    }
  },
  components: {
    SearchBox,
    Tips
  }
};
</script>
<style scoped>
.userlistbox {
  padding: 20px;
  border: 1px solid #ccc;
}
.adminlist {
  margin-top: 30px;
  border: 1px solid #ccc;
  padding: 30px;
}
.adminlist table {
  display: block;
}

.adminlist thead > tr {
  color: #707070;
  font-weight: normal;
  background: #f2f2f2;
  background-image: -webkit-gradient(
    linear,
    left 0,
    left 100%,
    from(#f8f8f8),
    to(#ececec)
  );
  background-image: -webkit-linear-gradient(top, #f8f8f8, 0%, #ececec, 100%);
  background-image: -moz-linear-gradient(top, #f8f8f8 0, #ececec 100%);
  background-image: linear-gradient(to bottom, #f8f8f8 0, #ececec 100%);
  background-repeat: repeat-x;
}
.somebtn {
  width: 100%;
  height: 50px;
  border: 1px solid #ccc;
}
.somebtn button {
  margin-top: 7px;
  margin-left: 10px;
  color: #fff;
  background: #438eb9 !important;
  border: none;
  width: 100px;
  height: 36px;
  border-radius: 3px;
  cursor: pointer;
}
.adminlist th {
  height: 29px;
  line-height: 29px;
  padding: 5px 10px;
  vertical-align: middle;
  border: 1px solid #ddd;
  font-size: 14px;
  color: #666;
  text-align: center;
}
.adminlist td {
  padding: 5px 30px;
  line-height: 30px;
  vertical-align: middle;
  border: 1px solid #ddd;
  color: #666;
  text-align: center;
  font-size: 12px;
}
tr:hover {
  background: rgb(174, 241, 253);
}
button {
  width: 70px;
  outline: 0;
  background: #3a8ee6;
  border: 0px;
  color: #fff;
}
button:hover {
  cursor: pointer;
}
</style>
