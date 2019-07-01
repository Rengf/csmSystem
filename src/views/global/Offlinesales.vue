<template>
    <div class="category">
        <div class="goods">
            <div class="goodsHeader">
                <div class="line"></div>
                <div class="goodsCategory">
                    <h3>全品类</h3>
                    <span>新品上市，强势进入</span>
                </div>
            </div>
            <div class="goodsBody">
                <div class="goodsMessage">
                    <div class="goodsMsgImg"><img src="../../assets/images/phone.jpg" alt=""></div>
                    <div class="goodsMsg">
                        <h3>智能手机</h3>
                        <i></i>
                        <p>智能手机（Smartgoods），是指像个人电脑一样，具有独立的操作系统，大多数是大屏机，而且是触摸电容屏，也有部分是电阻屏，功能强大实用性高</p>
                    </div>
                </div>
                <div class='newPhone' v-for="(goods,index) of goodslist" :key="index" v-if="index==0">
                    <div class='newPhoneImg'>
                        <img :src="goods.goods_picture" alt="">
                    </div>
                    <div class='goodsName'>
                        <span>{{goods.goods_name}}</span>
                    </div>
                    <div class='buttonBuy'>
                        <span> {{goods.goods_price}}</span>
                        <a @click="offlinesales(goods.goods_id)"> 购买 </a>
                    </div>
                </div>
            </div>
            <div class="goodsFooter">
                <div class='goodsListbox' v-for="(goods,index) of goodslist" :key="index" v-if="index>0">
                    <div class=goodsList>
                        <div class='newPhoneImg'>
                            <img :src="goods.goods_picture" alt=''>
                        </div>
                        <div class='goodsName'>
                            <span>{{goods.goods_name}}</span>
                        </div>
                        <div class='buttonBuy'>
                            <span>￥{{goods.goods_price}}</span>
                            <a @click="offlinesales(goods.goods_id,goods.goods_price)"> 购买 </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
          </div>
</template>
<script>
import {mapGetters} from 'vuex'
import axios from 'axios'
export default {
  name: "GoodsCategory",
  data() {
    return {
       condition:''
    };
  },
  mounted() {
      this.condition=this.$route.query;
      this.$store.dispatch('getGoodsList',[,this.condition]);
  },
   computed: {
      ...mapGetters(['goodslist']),
    },
    methods:{
        offlinesales(id,price){
            axios.post("http://localhost:3333/main/offlinesales",{
                goods_id:id,
                goods_price:price
            }).then(response=>{
                if(response.data.code==0){
                   console.log("购买成功")
                }else{
                    console.log("失败")
                }
            },
            response=>{
                console.log("error:"+response)
            })
        }
    }
};
</script>
<style scoped>
.category {
  position: relative;
  width: 63%;
  margin: auto;
}

.goods {
  clear: both;
  height: 830px;
  width: 100%;
}


.goodsHeader {
  height: 62px;
  width: 100%;
  margin-top: 100px;
}

.line {
  width: 5px;
  height: 62px;
  margin: auto 10px;
  background: #076ce0;
  float: left;
}


.goodsCategory {
  float: left;
}


.goodsCategory h3 {
  text-align: left;
  font-size: 28px;
  color: #555;
  font-weight: bold;
}

.goodsCategory span {
  font-size: 20px;
  line-height: 45px;
  color: #777;
}

.goodsBody {
  width: 100%;
  height: 350px;
}


.goodsMessage {
  width: 74%;
  height: 350px;
  margin-top: 50px;
}


.goodsMsgImg {
  margin-left: 50px;
  float: left;
  width: 30%;
}


.goodsMsg {
  margin-top: 50px;
  width: 300px;
  float: left;
}

.goodsMsg h3 {
  text-align: left;
  font-size: 20px;
  color: #2b2b2b;
}


.goodsMsg i {
  margin-top: 20px;
  margin-bottom: 30px;
  display: block;
  width: 80px;
  height: 2px;
  background: #076ce0;
}

.goodsMsg p {
  color: #999;
  font-size: 14px;
  line-height: 25px;
}

.newPhone {
  position: relative;
  float: left;
  width: 25%;
  height: 350px;
  top: -350px;
  right: -900px;
}

.newPhoneImg img,
.newPhoneImg {
  width: 200px;
  height: 200px;
}

.goodsMsgImg img {
  margin-top: 30px;
}

.goodsName span {
  font-size: 15px;
  color: #999;
  line-height: 23px;
}

.buttonBuy {
  margin-top: 15px;
}

.buttonBuy span {
  height: 30px;
  line-height: 30px;
  display: inline-block;
  font-size: 18px;
  color: #076ce0;
  font-weight: bold;
}



.buttonBuy a {
  display: inline-block;
  width: 80px;
  height: 30px;
  margin-left: 30px;
  font-size: 14px;
  font-weight: normal;
  line-height: 30px;
  text-align: center;
  background: #076ce0;
  border-radius: 3px;
  color: #fff;
}

.goodsFooter {
  position: relative;
  clear: both;
  top: -350px;
  width: 100%;
  height: 350px;
}

.goodsListbox {
  width: 25%;
  height: 350px;
  float: left;
}

.goodsList {
  margin: auto;
  width: 210px;
  height: 350px;
}

</style>