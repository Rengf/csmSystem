<template>
    <div class="goodsDetails">
        <div class='goodsDetailsImg'>
            <img :src="goods.goods_picture" alt=''>
        </div>
        <div class='goodsDetailsMsg'>
            <div class='goodsDetailsMsgHeader'>
                <h3> {{goods.goods_name}} </h3>
                <span>商品编号:
                    <i>{{goods.goods_type_id}}</i>
                </span>
                <span>商品价格:
                    <i>￥ {{goods.goods_price}} </i>
                </span>
            </div>
            <div class='goodsDetailsMsgBody'>
                <span>上市时间：
                    <i> {{goods.addgoods_time|dateformat('YYYY-MM-DD HH:mm:ss')}} </i>
                </span>
            </div>
            <div class='goodsDetailsMsgFooter'>
                <span>商品描述：
                    <i> {{goods.goods_description}} </i>
                </span>
            </div>
            <div class='goodsDetailsMsgNumber'>
                <div class='buyNumber'>
                    <span>购买数量：</span>
                    <span>{{conter}}</span>
                    <span>
                        <i @click='add'>+</i>
                        <i @click='reduce'>-</i>
                    </span>
                </div>
                <div class='stockNumber'>
                    <span>库存量： {{goods.stock}} </span>
                </div>
            </div>
            <div class='goodsDetailsMsgButton'>
                <a @click='addshopcar'>加入购物车</a>
                <span @click='addshopcar'>购买</span>
            </div>
        </div>
    </div>
</template>

<script>
import {mapGetters,mapActions} from 'vuex'
import axios from 'axios'
export default {
  name: "Details",
  data() {
    return {
       goods_id:this.$route.query.goods_id,
       conter: 1,
       goods:{}
    };
  },
  created() {
     axios.post('http://localhost:3333/main/getgoodsdetail',{
         goods_id:this.goods_id
     }).then(response=>{
         if(response.data.code==0){
             this.goods=response.data.goods[0];
         }else{
             console.log("获取失败")
         }
     },response=>{
         console.log("error:"+response)
     })
  },
  computed: {
    ...mapGetters(['userinfo','counter']),
  },
  methods: {
    add() {
      if (this.conter < this.goods.stock) {
        this.conter++;
      }
    },
    reduce() {
      if (this.conter > 1) {
        this.conter--;
      }
    },
    commitorder(){
      var data=this.conter;
      this.$store.dispatch('commitorder',data);
      console.log(this.counter)
    },
    addshopcar(){
      if(this.userinfo.user_id=={}||this.userinfo.user_id==''|| this.userinfo.user_id==undefined){
        this.$router.push({ path: "/login" });
      }
        var userId=this.userinfo.user_id;
        console.log(userId)
        axios.post("http://localhost:3333/main/addcart", {
          goods_id: this.goods_id,
          user_id:userId,
          goods_count:this.conter,
        }).then(
          response => {
            if (response.data.code ==0) {
              this.$router.push('/sureorder?goods_id='+this.goods_id)
            } else {
              console.log("添加失败")
            }
          },
          response => {
            console.log("error:" + response);
          }
        );
    }
  }
};
</script>

<style scoped>
.goodsDetails {
  width: 1200px;
  height: 818px;
  margin: auto;
  border: 1px solid #888;
}

.goodsDetailsImg {
  margin-top: 50px;
  float: left;
  width: 500px;
  height: 500px;
  border: 1px solid #ddd;
}

.goodsDetailsImg img {
  display: block;
  margin: 50px auto;
  width: 400px;
  height: 400px;
}

.goodsDetailsMsg {
  margin-top: 50px;
  width: 598px;
  height: 500px;
  margin-left: 100px;
  float: left;
}

.goodsDetailsMsg span {
  display: block;
  height: 35px;
  font-size: 14px;
  font-weight: normal;
  line-height: 35px;
  color: #585858;
}

.goodsDetailsMsg span i {
  display: inline-block;
  margin-left: 20px;
}

.goodsDetailsMsgHeader span:nth-child(3) > i {
  font-size: 40px;
  color: #076ce0;
  font-weight: bold;
  vertical-align: middle;
}

.goodsDetailsMsgHeader {
  height: 170px;
  border-bottom: 1px solid #ddd;
}

.goodsDetailsMsgHeader h3 {
  display: block;
  margin-bottom: 50px;
  font-size: 20px;
  font-weight: normal;
  color: #585858;
}

.goodsDetailsMsgFooter,
.goodsDetailsMsgBody {
  height: 74px;
  border-bottom: 1px solid #ddd;
}

.goodsDetailsMsgNumber {
  border-bottom: 1px solid #ddd;
}

.buyNumber span {
  position: relative;
  height: 35px;
  display: inline-block;
  line-height: 35px;
}

.buyNumber input {
  width: 50px;
  text-align: center;
  height: 30px;
  font-size: 20px;
}

.buyNumber span > i {
  text-align: center;
  font-size: 10px;
  font-weight: bold;
  position: absolute;
  width: 13px;
  height: 13px;
  display: block;
  line-height: 10px;
  border: 1px solid #aaa;
}

.buyNumber span i:nth-child(1) {
  position: absolute;
  top: 13px;
  left: 0px;
}

.buyNumber span i:nth-child(2) {
  position: absolute;
  top: 30px;
  left: 0px;
}
.buyNumber span i:hover {
  background: #ccc;
  color: #fff;
  cursor: pointer;
}
.stockNumber {
  margin-top: 20px;
}

.goodsDetailsMsgButton {
  margin-top: 20px;
  height: 42px;
}

.goodsDetailsMsgButton a {
  display: inline-block;
  height: 40px;
  width: 160px;
  text-align: center;
  line-height: 40px;
  border: 1px solid #076ce0;
  margin-right: 50px;
  border-radius: 5px;
  color: #076ce0;
}
.goodsDetailsMsgButton a:hover{
  cursor: pointer;
  border: 1px solid #969696;
  color:#fff;
  background:#076ce0;
}
</style>
