<template>
  <div class="warp">
    <div class="login">
      <div class="loginAdvertising">
      </div>
      <div class="loginFrme">
        <div class="loginHeader">
          <span>登录</span>
        </div>
        <div class="loginBody">
          <div class="loginErrorMessage">
            <p>{{warning}}</p>
          </div>
          <div class="loginForm">
            <div class="user">
              <label for="user" class="userLable"></label>
              <input
                type="text"
                class="userInput"
                placeholder="请输入用户名/电话/邮箱"
                v-model="username"
              >
            </div>
            <div class="password">
              <label
                for="password"
                class="passwordLable"
              ></label>
              <input
                type="password"
                class="passwordInput"
                placeholder="请输入密码"
                v-model="password"
              >
            </div>
            <div class="captchaBox">
              <label
                for="captcha"
                class="control-lable"
              >验证码:</label>
              <input
                type="text"
                placeholder="输入验证码"
                v-model="captchatext"
                maxlength="5"
              >
              <span
                v-html="captcha"
                class="captcha"
                @click="getCaptcha"
              ></span>
            </div>
            <div class="forget">
              <p><a href="#">忘记密码？</a>还没有账户，去<router-link
                  style="padding: 0 5px"
                  :to="{path:'/regist'}"
                >注册</router-link>！</p>
            </div>
            <div class="submit">
              <input
                type="submit"
                value="登    录"
                @click="login"
              >
            </div>
          </div>
        </div>
        <div class="loginFooter">

        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from "axios";
import {mapGetters} from 'vuex'
export default {
  name: "Login",
  data() {
    return {
      user: {},
      username: "",
      password: "",
      warning:'',
      isAdmin: false,
      captchatext: "",
    };
  },
  created() {
      this.username=localStorage.getItem("username");
      this.password=localStorage.getItem("password");
  },
  mounted() {
    this.getCaptcha();
  },
  computed: {
    ...mapGetters(['result','captcha']),
  },
  methods: {
    login() {
      if (this.username == "") {
        this.warning = "用户名不能为空";
        return;
      } else if (this.password == "") {
        this.warning = "密码不能为空";
        return;
      } else if (this.captchatext == "") {
        this.warning = "验证码不能为空";
        return;
      }
       var data={
          username: this.username,
          password: this.password,
          captcha: this.captchatext
        };
        this.$store.dispatch('login',data).then(
          res=>{
            if(this.$store.getters.result.code==0){
                localStorage.setItem('username',this.username)
                localStorage.setItem('password',this.password)
                this.warning=this.$store.getters.result.message+',即将跳转到前一页';
                setTimeout(()=>{
                  this.$router.go(-1);
                },3000)
            }
            else{
              this.warning=this.$store.getters.result.message;
              this.getCaptcha();
            }
          },
          res=>{
            console.log("error:"+res)
          }
        );
    },
    getCaptcha() {
      this.$store.dispatch('getCaptcha').then(
        response => {
          console.log("获取成功")
        },
        response => {
          console.log("error:" + response);
        }
      );
    }
  },
  components: {

  }
};
</script>
<style scoped>
.login {
  width: 80%;
  margin: auto;
}
.header {
  height: 150px;
  width: 100%;
  background: #fff;
}

.body {
  width: 80%;
  height: 600px;
  margin: auto;
}

.registAdvertising,
.loginAdvertising {
  width: 65%;
  height: 600px;
  float: left;
  background: url(../../assets/images/login.jpg) no-repeat;
  background-position: 200px, 200px;
}

.loginFrme {
  margin-top: 100px;
  width: 35%;
  height: 400px;
  float: left;
}

.protectFrme,
.registFrme {
  margin-top: 80px;
  width: 35%;
  height: 600px;
  float: left;
  border-bottom: 1px solid #ccc;
}

.protectHeader,
.registHeader,
.loginHeader {
  width: 90%;
  height: 40px;
  margin: 10px auto;
  border-bottom: 1px solid #ddd;
}

.registHeader span,
.loginHeader span {
  display: block;
  font-size: 24px;
  font-weight: bold;
  line-height: 40px;
  color: #333;
  width: 100%;
  text-align: center;
}

.protectErrorMessage,
.registErrorMessage,
.loginErrorMessage {
  width: 90%;
  height: 25px;
  margin: 20px auto;
}

.protectErrorMessage p,
.registErrorMessage p,
.loginErrorMessage p {
  display: block;
  width: 100%;
  height: 25px;
  border: 1px solid #ffcc00;
  background: #ffff99;
  color: #ff0000;
  line-height: 25px;
  font-size: 12px;
  text-indent: 1em;
}

.user,
.password {
  position: relative;
  z-index: 1;
  border: 1px solid #bdbdbd;
  height: 40px;
  width: 90%;
  margin: 15px auto;
}

.userLable {
  position: absolute;
  z-index: 3;
  width: 40px;
  height: 40px;
  background: url(../../assets/images/user.png) no-repeat #ccc;
  background-position: center;
  background-size: 70% 70%;
  -moz-background-size: 70% 70%;
}

.passwordLable {
  position: absolute;
  z-index: 3;
  width: 40px;
  height: 40px;
  background: url(../../assets/images/suo.png) no-repeat #ccc;
  background-position: center;
  background-size: 70% 70%;
  -moz-background-size: 70% 70%;
}

.userInput,
.passwordInput {
  line-height: 20px;
  border: 0;
  padding: 10px 0 10px 50px;
  width: 268px;
  float: none;
  overflow: hidden;
  font-size: 14px;
  font-family: "\5b8b\4f53";
  outline: none;
}

.forget {
  width: 90%;
  height: 20px;
  margin: auto;
}

.forget p {
  width: 100%;
  height: 20px;
  font-size: 12px;
  text-align: right;
}

.submit {
  width: 90%;
  height: 35px;
  margin: auto;
}

.submit input {
  width: 100%;
  height: 35px;
  background: #ff0000;
  border: none;
  color: aliceblue;
  font-size: 20px;
  font-weight: bold;
}
.submit input:hover {
  cursor: pointer;
}
.captchaBox {
  width: 100%;
  height: 50px;
}
.control-lable {
  margin-left: 30px;
  line-height: 50px;
  font-size: 15px;
  font-weight: bold;
  display: inline-block;
  color: #888;
}
.captchaBox input {
  height: 40px;
  width: 100px;
  display: inline-block;
}
.captcha {
  position: absolute;
  width: 200px;
  height: 42px;
}
</style>
