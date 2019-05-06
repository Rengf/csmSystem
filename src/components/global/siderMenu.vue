<template>
  <div class="siderMenu">
    <ul class="siderBarMenu">
        <li v-for="(category,index) in categorylist.slice(5,10)" :key="index">
            <router-link :to="{path:'/index/goodslist',query:{goods_type_id:category.goods_type_id}}">{{category.goods_type_name}}</router-link>
            <i></i>
            <ul class="siderBarSubMenu siderBarSubMenuPhone">
                <li v-for="(goodslist,index) in goodslist" :key="index" v-show="goodslist.goods_type_id==category.goods_type_id">
                    <router-link :to="{path:'/index/goodsdetail',query:{goods_id:goodslist.goods_id}}"> {{goodslist.goods_name}} </router-link>
                </li>
            </ul>
        </li>
    </ul>
  </div>
</template>
<script>
import axios from "axios";
import { mapGetters } from "vuex";
export default {
  name: "SiderMenu",
  data() {
    return {
    };
  },
  mounted() {
    this.$store.dispatch("getCategoryList","getGoodsList");
  },
  computed: {
    ...mapGetters(["categorylist","goodslist"])
  }
};
</script>
<style scoped>
.siderMenu {
  position: relative;
  width: 242px;
  height: 500px;
  margin: 1px;
  margin-left: 338px;
  background: #076ce0;
  z-index: 999;
}

.siderBarMenu > li {
  position: relative;
  height: 99px;
  display: block;
  border-bottom: 1px solid rgba(255, 255, 255, 0.4);
}

.siderBarMenu > li > a {
  height: 99px;
  display: block;
  margin-left: 20px;
  float: left;
  width: 70%;
  color: #fff;
  line-height: 99px;
  font-family: 寰蒋闆呴粦;
  font-size: 14px;
  font-weight: bold;
}

.siderBarMenu > li > i {
  margin-top: 43px;
  display: block;
  float: left;
  background: url(../../assets/images/vbg01.png) 0 -1530px no-repeat;
  width: 5%;
  height: 15px;
  min-width: 6.7px;
}

.siderBarMenu > li:hover {
  background: #05f;
}

.siderBarMenu > li:hover .siderBarSubMenu {
  display: block;
  position: absolute;
}

.siderBarSubMenu {
  display: none;
  height: 498px;
  width: 250px;
  left: 241px;
  border: 1px solid #076ce0;
  background: #fff;
}

.siderBarMenu > li:nth-child(2) .siderBarSubMenu {
  top: -100px;
}

.siderBarMenu > li:nth-child(3) .siderBarSubMenu {
  top: -200px;
}

.siderBarMenu > li:nth-child(4) .siderBarSubMenu {
  top: -300px;
}

.siderBarMenu > li:nth-child(5) .siderBarSubMenu {
  top: -400px;
}

.siderBarSubMenu li {
  width: 100%;
  height: 50px;
}

.siderBarSubMenu li a {
  width: 60%;
  height: 50px;
  display: block;
  margin: auto;
  color: #555;
  font-weight: bold;
  font-size: 12px;
  line-height: 50px;
}

.siderBarSubMenu li a:hover {
  color: #076ce0;
}
</style>

