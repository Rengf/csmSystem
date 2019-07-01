<template>
    <div class="warpper">
        <div class="ordercategory">
            <div class="somebtn">
                <button @click="getorderlist()">全部订单</button>
                <button @click="getorderlist(0)">待付款</button>
                <button @click="getorderlist(1)">待发货</button>
                <button @click="getorderlist(2)">待收货</button>
                <button @click="getorderlist(3)">待评价</button>
                <search-box @searchmsg="searchorder"></search-box>
            </div>
        </div>
        <div class="orderlist">
            <div class="orderheader">
                <ul>
                    <li>商品</li>
                    <li>单价</li>
                    <li>数量</li>
                    <li>实付款</li>
                    <li>交易状态</li>
                    <li>交易操作</li>
                </ul>
            </div>
            <div class="order" v-for="(order,index) in orderlist" :key="index">
                <div class="ordetime">
                    <span>下单时间：{{order.addorder_time|dateformat('YYYY-MM-DD')}}</span>
                    <span>订单号：{{order.order_no}}</span>
                </div>
                <div class="ordermsg">
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
                          <li class="like">{{order.order_status=='0'?'未付款':(order.order_status=='1'?'已付款':(order.order_status==2?'已发货':'其他'))}}</li>
                          <li class="button">
                              <button @click="showreturnbox(index)">申请退货</button>
                              <button @click="orderdetail(order.order_id)">订单详情</button>
                              <button @click="deleteorder(order.order_id)">修改信息</button>
                          </li>
                    </ul>
                    <div class="returnbox" v-show="showreturn==index">
                        <span>退货原因</span>
                        <textarea name="text" id="" cols="30" rows="10" v-model="return_reason"></textarea>
                        <button @click="returnorder(order.order_id)">确定</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import SearchBox from "@/components/Communal/searchbox"
import axios from "axios"
export default {
    data() {
        return {
            user_id:'',
            orderlist:'',
            showreturn:null,
            return_reason:''
        }
    },
    created() {
         axios.get("http://localhost:3333/api").then(response=>{
            if(response.data.code==0){
                this.user_id=response.data.user.user_id;
                this.getorderlist();
                }else{
                    console.log('获取失败')
                }
        },response=>{
            console.log("error:"+response)
        })
    },
    methods:{
        showreturnbox(index){
            this.showreturn=index;
        },
        getorderlist(status){
            axios.post("http://localhost:3333/main/getorderlist",{
                user_id:this.user_id,
                status:status,
            }).then(response=>{
                if(response.data.code==0){
                    this.orderlist=response.data.orderlist
                }else{
                    console.log("获取失败")
                }
            },
            response=>{
                console.log("error"+response)
            })
        },
        returnorder(id){
            axios.post("http://localhost:3333/main/returnorder",{
                order_id:id,
                return_reason:this.return_reason
            }).then(response=>{
                if(response.data.code==0){
                    alert("申请成功")
                }else{
                    console.log("获取失败")
                }
            },
            response=>{
                console.log("error"+response)
            })
        }
    },
    components:{
        SearchBox,
    }
}
</script>
<style scoped>
.warpper{
    width: 1200px;
    margin: auto;
}
.somebtn{
    width: 100%;
    height: 50px;
    border: 1px solid #ccc;
}
.somebtn button{
    margin-top: 7px;
    margin-left: 10px;
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 100px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
.orderheader{
    width: 100%;
    height: 50px;
}
.ordermsg ul li,
.orderheader ul li{
    display: inline-block;
    vertical-align: middle;
    text-align: center
}
.orderheader ul li{
    line-height: 50px;
    background: #f5f5f5;
    color:#3c3c3c
}
.orderheader ul li:nth-child(1),
.name{
    width: 400px;
}
.like,
.orderheader ul li:nth-child(2),
.orderheader ul li:nth-child(3),
.orderheader ul li:nth-child(4),
.orderheader ul li:nth-child(5){
    width: 100px;
}
.button,
.orderheader ul li:nth-child(6){
    width: 300px;
}
.order{
    border: 1px solid #f1f1f1;
    margin: 10px 0; 
}
.ordetime{
    width: 100%;
    height: 50px;
    line-height: 50px;
    color: #333;
    font-size: 14px;
    border: 1px solid #f1f1f1;
}
.ordetime span{
    margin-left: 50px;
}
.name div{
  float: left;
  line-height: 50px;
  margin: 0px 20px;
  vertical-align: middle
}
.shopimg img{
  width: 50px;
  height: 50px;
}
button{
    display: inline-block;
    width: 80px;
    height: 25px;
    outline: 0;
    border: 0px;
    color: #fff;
    border-radius: 5px;
    cursor: pointer;
}

.ordermsg li button:nth-child(1){
 background: #21a237;
}

.ordermsg li button:nth-child(2){
 background: #3a8ee6;
}
.ordermsg li button:nth-child(3){
 background: #d15b47;
}
.returnbox{
    position: absolute;
    right: 400px;
    width: 318px;
    height: 200px;
    border: 1px solid #ccc;
    background: #fff;
    color: #333;
    vertical-align: top
}
.returnbox span{
    display: block;
    width: 100%;
    height: 35px;
    line-height: 35px;
}
</style>
