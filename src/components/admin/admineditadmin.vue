<template>
  <div class="userlist">
    <div class="userlistbox">
      <table>
        <thead>
          <tr>
            <th width="30">#</th>
            <th width="100">用户名</th>
            <th width="100">真实姓名</th>
            <th width="150">用户类型</th>
            <th width="100">注册电话</th>
            <th width="150">注册邮箱</th>
            <th width="180">注册时间</th>
            <th width="180">上次登录</th>
            <th width="200">权限分配</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(user,index) in userlist" :key="index">
            <td>{{index+1}}</td>
            <td>
              <router-link :to="{path:'/admin/userinfo?user_id='+user.user_id}">{{user.user_name}}</router-link>
            </td>
            <td>{{user.real_name==null?'未实名':user.real_name}}</td>
            <td>{{user.isadmin=='0'?'普通用户':(user.isadmin=='1'?'普通管理员':'超级管理员')}}</td>
            <td>{{user.user_tel}}</td>
            <td>{{user.user_email}}</td>
            <td>{{user.regist_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
            <td>{{user.last_login_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
            <td>
              <button @click="edituser(user.user_id)">编辑</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="edit" v-if="show">
      <div class="editheader">
        <span>设置管理员级别</span>
        <i @click="close" class="iconfont close">&#xe711;</i>
      </div>
      <div class="editbody">
        <label for="editadmin">选择管理员级别:</label>
        <select name="eidtadmin" v-model="selected">
          <option value="请选择" disabled selected="selected">请选择</option>
          <option value="2">超级管理员</option>
          <option value="1">普通管理员</option>
          <option value="0">普通用户</option>
        </select>
      </div>
      <div class="editbtn">
        <span @click="editsure">确认修改</span>
      </div>
    </div>
    <Tips v-if="showtips" :tips="tips"></Tips>
    <Background v-show="show"></Background>
  </div>
</template>
<script>
import Background from "@/components/Communal/background";
import Tips from "@/components/Communal/tips";
import axios from "axios";
import { mapActions, mapGetters } from "vuex";
export default {
  name: "eidtamin",
  data() {
    return {
      show: false,
      showtips: false,
      selected: "请选择",
      user_id: "",
      tips: ""
    };
  },
  created() {
    this.$store.dispatch("getUserlist");
  },
  computed: {
    ...mapGetters(["userlist"])
  },
  methods: {
    close() {
      this.show = false;
    },
    getuserlist() {},
    edituser(id) {
      this.show = true;
      this.user_id = id;
    },
    editsure() {
      if (this.selected == "请选择") {
        this.showtips = true;
        this.tips = "请选择管理员级别";
        setTimeout(() => {
          this.showtips = false;
        }, 3000);
        return;
      }
      axios
        .post("http://localhost:3333/admin/editadmin", {
          user_id: this.user_id,
          isadmin: this.selected
        })
        .then(
          response => {
            if (response.data.code == 0) {
              this.$store.dispatch("getUserlist");
              this.showtips = true;
              this.show = false;
              this.tips = response.data.message;
              setTimeout(() => {
                this.showtips = false;
              }, 3000);
            } else {
              console.log("设置失败");
            }
          },
          response => {
            console.log("error:" + response);
          }
        );
    }
  },
  components: {
    Background,
    Tips
  }
};
</script>
<style scoped>
.iconfont {
  font-family: "iconfont" !important;
  font-size: 16px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.userlistbox {
  padding: 20px;
  border: 1px solid #ccc;
}

/* .userlist th:nth-child(1){
    width: 20px;
} */
.userlist thead > tr {
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
.userlist th {
  height: 29px;
  line-height: 29px;
  padding: 5px 10px;
  vertical-align: middle;
  border: 1px solid #ddd;
  font-size: 14px;
  color: #666;
  text-align: center;
}
.userlist td {
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
  margin: 0 5px;
  width: 70px;
  outline: 0;
  background: #3a8ee6;
  border: 0px;
  color: #fff;
}
button:hover {
  cursor: pointer;
}
.edit {
  position: fixed;
  width: 300px;
  height: 300px;
  border: 1px solid #aaa;
  top: 50%;
  left: 50%;
  margin-top: -150px;
  margin-left: -150px;
  background: #fff;
  z-index: 9999;
}
.editheader {
  width: 100%;
  height: 40px;
  background: #f8f8f8;
}
.editheader span {
  margin-left: 20px;
  font-size: 14px;
  color: #333;
  line-height: 40px;
  text-overflow: ellipsis;
  white-space: nowrap;
}
.close {
  position: relative;
  font-size: 16px;
  left: 148px;
}
.close:hover {
  cursor: pointer;
}

.editbody {
  width: 100%;
  height: 150px;
}
.editbody label {
  font-size: 15px;
  position: relative;
  width: 120px;
  text-align: right;
  line-height: 150px;
  color: #666;
  float: left;
  vertical-align: middle;
}
.editbody select {
  margin-top: 63px;
  margin-left: 10px;
  border-radius: 0 !important;
  color: #666666;
  background-color: #fff;
  border: 1px solid #c6c6c6;
  padding: 0px 5px;
  line-height: 1.2;
  font-size: 14px;
  height: 25px;
  font-family: inherit;
  -webkit-box-shadow: none !important;
  box-shadow: none !important;
  -webkit-transition-duration: 0.1s;
  transition-duration: 0.1s;
  outline: none;
}
.editbtn span {
  margin: auto;
  display: block;
  border-radius: 3px;
  height: 35px;
  width: 100px;
  text-align: center;
  font-size: 14px;
  line-height: 35px;
  outline: 0;
  border: 0px;
  color: #fff;
  background: #3a8ee6;
}
.editbtn span:hover {
  cursor: pointer;
}
</style>
