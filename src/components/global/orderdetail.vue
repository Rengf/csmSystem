<template>
    <div class="warpper">
        <div class="logistmsg">
            <ul>
                <li><span>订单编号</span><span>{{order.order_no}}</span></li>
                <li><span>订单状态</span><span>{{order.order_status=='0'?'未付款':(order.order_status=='1'?'已付款':(order.order_status==2?'已发货':'其他'))}}</span></li>
                <li><span>收货人信息</span><span>{{order.addressee+" 、 "+order.province+order.city+order.area+order.street+" 、 "+order.tel}}</span></li>
                <li><span>支付方式</span><span>{{order.pay_channel}}</span></li>
                <li><span>配送方式</span><span>{{order.logistics}}</span></li>
                <li><span>给卖家留言</span><span>{{order.user_remarks}}</span></li>
            </ul>
        </div>
        <div class="goodslist">
            <div class="goodsheader">
                <span>购物清单</span>
            </div>
            <div class="goodsbody">
               <div class="listheader">
                    <ul>
                        <li class="name">名称</li>
                        <li class="like">价格</li>
                        <li class="like">数量</li>
                        <li class="like">小计</li>
                    </ul>
                </div>
                <div class="listbody">
                    <ul>
                          <li class="name">
                              <div class="shopimg">
                                  <img :src="order.goods_picture" alt="">
                              </div>
                              <div class="shopname">
                                  <router-link :to="{path:'/index/goodsdetail',query:{order:order.goods_id}}"> {{order.goods_name}} </router-link>
                              </div>
                          </li>
                          <li class="like">{{order.goods_price}}</li>
                          <li class="like buyNumber">{{order.product_count}}</li>
                          <li class="like">{{order.goods_price*order.product_count}}</li>
                    </ul>
                </div>
            </div> 
        </div>
    </div>
</template>
<script>
import axios from "axios"
import {mapGetters} from 'vuex'
export default {
    data(){
        return {
            order_id:this.$route.query.order_id,
            user_id:'',
            order:{}
        }
    },
    created() {
         axios.get("http://localhost:3333/api").then(response=>{
            if(response.data.code==0){
                this.user_id=response.data.user.user_id;
                this.getorder();
                }else{
                    console.log('获取失败')
                }
        },response=>{
            console.log("error:"+response)
        })
    },
    computed: {
        
    },
    methods: {
        getorder(){
          axios.post("http://localhost:3333/main/getorderdetail",{
            user_id:this.user_id,
            order_id:this.order_id,
          }).then(
            response=>{
              if(response.data.code==0){
                console.log(response.data)
                 this.order=response.data.order;
                  }else{
                      console.log('获取失败')
                  }
          },response=>{
              console.log("error:"+response)
          }
          )
        }
    },
}
</script>
<style scoped>
.warpper{
    width: 1200px;
    margin: auto;
}
.logistmsg{
    width: 100%;
    height: 320px;
    border: 1px solid #ccc;
    padding: 10px 30px;
}
.logistmsg li{
    border-bottom: 1px dashed #ccc
}
.logistmsg ul li span:nth-child(1){
    display: inline-block;
    width: 100px;
    height: 50px;
    line-height: 50px;
    text-align: right;
    font-size: 16px;
    color:#333;
    vertical-align: middle;
}
.logistmsg ul li span:nth-child(2){
    display: inline-block;
    margin-left: 50px;
    height: 50px;
    line-height: 50px;
    text-align: right;
    font-size: 14px;
    color:#666;
    vertical-align: middle;
}
.goodslist{
    width: 100%;
}
.goodsheader{
  width: 100%;
  height: 50px;
  line-height: 50px;
  font-size: 18px;
  color: #333;
}
.goodsbody{
  width: 100%;
}
.listheader,
.listbody{
  width: 100%;
  height: 35px;
}
.listheader li{
  display: inline-block;
  vertical-align: middle;
  width: 24%;
  height: 35px;
  line-height: 35px;
  text-align: center;
}
.listbody li{
  display: inline-block;
  vertical-align: middle;
  width: 24%;
  height: 50px;
  line-height: 50px;
  text-align: center;
}
.name div{
  display: inline-block;
  margin: auto;
  vertical-align: top
}
.shopimg img{
  width: 50px;
  height: 50px;
}
</style>
