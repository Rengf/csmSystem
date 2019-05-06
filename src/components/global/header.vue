<template>
   <div class="header">
            <div class="logo">
                <div class="logoImg">
                 
                </div>
                <div class="search">
                    <div class="searchBox">
                        <input type="text" v-model="searchmsg">
                        <router-link :to="{path:'/index/goodslist', query:{searchgoods:searchmsg}}"></router-link>
                    </div>
                    <div class="searchList">
                        <ul>
                            <li v-for="(category,index) in categorylist.slice(5,8)" :key="index">
                                <router-link :to="{path:'/index/goodslist', query:{goods_type_id:category.goods_type_id}}">{{category.goods_type_name}}</router-link>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="menu">
                <ul class="menuList">
                    <li>全部商品分类</li>
                    <li>
                        <router-link :to="{path:'/index/goodslist'}"></router-link>
                    </li>
                    <li><router-link :to="{path:'/'}">首页</router-link></li>
                    <li v-for="(category,index) in categorylist.slice(5,10)" :key="index">
                        <router-link :to="{path:'/index/goodslist', query:{goods_type_id:category.goods_type_id}}">{{category.goods_type_name}}</router-link>
                    </li>
                    <li><a @click="showmore">更多</a></li>
                </ul>
                 <ul class="categoryList" v-show="showlist">
                    <li v-for="(category,index) in categorylist" :key="index">
                        <router-link :to="{path:'/index/goodslist', query:{goods_type_id:category.goods_type_id}}">{{category.goods_type_name}}</router-link>
                    </li>
                </ul>
            </div>
        </div>
</template>
<script>
import { mapGetters } from "vuex";
export default {
    name: "Header",
    data() {
        return {
          searchmsg:'',
          showlist:false,
        };
    },
    mounted() {
        this.$store.dispatch("getCategoryList");
    },
    computed: {
        ...mapGetters(["categorylist"]),
    },
    methods:{
      showmore(){
        this.showlist=!this.showlist
      }
    }
};

</script>
<style scoped>
.header {
  margin-top: 50px;
  height: 150px;
  width: 100%;
}

.logo {
  width: 100%;
  height: 96px;
  background:url(../../assets/images/logo.jpg) no-repeat;
  background-position:350px ,0px;
}

.ylg{
  display: block;
  width: 100%;
  height: 100px;
  font-size: 30px;
  text-align: center;
  line-height: 100px;
  font-family: '华文彩云', Times, serif;
text-indent: 20px
}
.logoImg {
  width: 30%;
  height: 96px;
  float: left;
}

.search {
  width: 59%;
  height: 100px;
  float: right;
}

.searchBox {
  margin-top: 20px;
  width: 380px;
}

.searchBox input {
  width: 265px;
  height: 30px;
  border: 2px solid red;
  outline: none;
  font: 14px/30px "microsoft yahei";
  vertical-align: middle;
  padding-left: 20px;
  padding-right: 20px;
}

.searchBox a {
  margin-left: -5px;
  width: 65px;
  height: 36px;
  border: none;
  outline: none;
  font: 14px/34px "microsoft yahei";
  display: inline-block;
  background: url(../../assets/images/vbg01.png) no-repeat red;
  background-position: -1967px -262px;
  vertical-align: middle;
}

.searchList li {
  float: left;
  width: 50px;
  height: 20px;
}

.searchList a {
  width: 50px;
  height: 20px;
  font-size: 14px;
  color: #888;
  line-height: 20px;
  text-align: center;
}

.menu {
  height: 50px;
  width: 100%;
  background: #076ce0;
}

.menuList {
  width: 1200px;
  height: 50px;
  margin-left: 340px;
}

.menuList li {
  width: 130px;
  height: 50px;
  display: block;
  line-height: 50px;
  color: #fff;
  text-align: center;
  float: left;
  z-index: 999;
}

.menuList li a {
  display: block;
  width: 130px;
  height: 50px;
  line-height: 50px;
  color: #fff;
  text-align: center;
}

.menuList li a:hover {
  background: #fff;
  cursor: pointer;
  color: #076ce0;
}

.menuList li:nth-child(2) a {
  width: 15px;
  height: 15px;
  display: block;
  margin: 18px auto;
  background: url(../../assets/images/vbg01.png) no-repeat;
  background-position: 0px -1479px;
}
.menuList li:nth-child(n+4){
  margin-top:-4px;
}
.categoryList{
  position: relative;
  top: 5px;
  width: 1200px;
  margin: auto;
  z-index: 9999;
  background: #0a46ec;
  border: 1px solid #0a46ec;
}
.categoryList li{
  display: inline-block;
  min-width: 100px;
  height: 30px;
}
.categoryList li a{
  display: block;
  width: 100%;
  height: 100%;
  color: #fff;
  line-height: 30px;
  text-align: center;
}
.categoryList li a:hover {
  background: #fff;
  cursor: pointer;
  color: #0a46ec;
}
</style>


