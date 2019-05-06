<template>
  <div class="siderBar">
    <div class="siderBarLeft">
      <ul class="siderBarUser">
        <li class="likeList">
          <a @click="showmessage">
            <span id="username" slot="header">我的资料</span>
            <i></i>
          </a>
        </li>
        <li class="likeList">
          <a href="">
            <span>我的收藏</span>
            <i></i>
          </a>
        </li>
        <li class="car">
          <router-link :to="{path:'/index/shopcar'}">
            <span></span>
            <p>购物车</p>
            <i>{{this.cartlist.length}}</i>
          </router-link>
        </li>
        <li>
          <a href=""></a>
        </li>
        <li class="likeList">
          <a href="order.jsp">
            <span>我的订单</span>
            <i></i>
          </a>
        </li>
        <li class="likeList">
          <a href="">
            <span>留言</span>
            <i></i>
          </a>
        </li>
        <li>
          <a href=""></a>
        </li>
        <li class="likeList">
          <a href="#">
            <span>回到顶部</span>
            <i></i>
          </a>
        </li>
      </ul>
    </div>
    <show-box  v-show="isShow" @closeBox='closeBox'></show-box>
  </div>
</template>
<script>
import axios from "axios";
import ShowBox from "./showBox";
import { mapGetters } from 'vuex';
export default {
  name: "SiderBar",
  data() {
    return {
      isShow:false,
    };
  },
  created() {
    this.$store.dispatch('getUserInfo');
    axios.get("http://localhost:3333/api").then(response=>{
            if(response.data.code==0){
                this.user_id=response.data.user.user_id;
                this.$store.dispatch('getCartList',this.user_id);
                }else{
                    console.log('获取失败')
                }
        },response=>{
            console.log("error:"+response)
        })
  },
  computed: {
      ...mapGetters(['userinfo','cartlist'])
  },
  methods: {
    showmessage() {
      if (!this.userinfo.user_name) {
        this.$router.push({ path: "/login" });
      } else {
        this.isShow = !this.isShow;
      }
    },
    closeBox(){
      this.isShow=false;
    }
  },
  components: {
    ShowBox
  }
};
</script>
<style scoped>
.siderBar {
  position: fixed;
  height: 100%;
  background: #000;
  top: 0px;
  right: 0px;
  z-index: 999;
}
.siderBarLeft {
  width: 35px;
  float: left;
}

.siderBarUser {
  width: 100%;
}

.siderBarUser li:nth-child(2),
.siderBarUser li:nth-child(1) {
  width: 35px;
  height: 40px;
}

.siderBarUser li:nth-child(2) a,
.siderBarUser li:nth-child(1) a {
  width: 35px;
  height: 40px;
  display: block;
  background-color: #000;
  background-position: 0px 0px;
}

.car {
  width: 35px;
  height: 150px;
}

.car span {
  display: block;
  width: 35px;
  height: 40px;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: 4px -1944px;
  margin-bottom: 15px;
}

.car p {
  display: block;
  width: 15px;
  font-size: 15px;
  color: #fff;
  height: 60px;
  margin: auto;
}

.car i {
  display: block;
  margin: auto;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  color: #fff;
  background: #c40000;
  text-align: center;
  line-height: 20px;
}

.siderBarUser {
  margin-top: 50px;
}

.siderBarUser li {
  margin-top: 10px;
}

.siderBarUser li:hover {
  background: #c40000;
}

.siderBarUser li:nth-child(1) a {
  width: 35px;
  height: 40px;
  display: block;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: 12px -400px;
}

.siderBarUser li:nth-child(2) a {
  width: 35px;
  height: 40px;
  display: block;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: 10px -835px;
}

.siderBarUser li:nth-child(4) a {
  width: 35px;
  height: 40px;
  display: block;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: -516px -2088px;
}

.siderBarUser li:nth-child(5) a {
  width: 35px;
  height: 40px;
  display: block;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: -29px -400px;
}

.siderBarUser li:nth-child(6) a {
  width: 35px;
  height: 40px;
  display: block;
  margin-top: 200px;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: -515px -1052px;
}

.siderBarUser li:nth-child(7) a {
  width: 35px;
  height: 40px;
  display: block;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: 8px -645px;
}

.siderBarUser li:nth-child(8) a {
  width: 35px;
  height: 40px;
  display: block;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: -528px -2497px;
}
.likeList span {
  position: relative;
  display: none;
  height: 40px;
  width: 120px;
  right: 120px;
  color: rgba(255, 255, 255, 0.8);
  font-size: 14px;
  line-height: 40px;
  background: #777;
  text-align: center;
}

.likeList i {
  position: relative;
  top: -30px;
  display: none;
  width: 0;
  height: 0;
  border-width: 10px;
  border-style: solid;
  border-color: transparent transparent transparent #777;
}

.likeList:hover i,
.likeList:hover span {
  display: block;
}
</style>

