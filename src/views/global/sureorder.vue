<template>
    <div class="placeorderbox">
        <div class="addressmsg">
            <div class="addressheader">
                <span>收货人信息</span>
            </div>
            <div class="addressbody">
                <div class="address" v-for="(address,index) in addresslist" :key="index">
                    <div class="setup">
                        <ul>
                            <li><span @click="setdefault(address.address_id)" v-if="address.is_default_address==0">设为默认</span></li>
                            <li><i class="iconfont icon-ren subicon" @click="editaddress(address.address_id)">&#xe622;</i></li>
                            <li><i class="iconfont icon-ren subicon" @click="deleteaddress(address.address_id)">&#xe617;</i></li>
                        </ul>
                    </div>
                    <ul>
                        <li>
                            <p>
                                <i class="iconfont icon-ren subicon">&#xe63c;</i>
                                <span>{{address.addressee}}</span>
                            </p>
                        </li>
                        <li>
                             <p>
                                <i class="iconfont icon-ren subicon">&#xe61a;</i>
                                <span>{{address.tel}}</span>
                            </p>
                        </li>
                        <li class="lastli">
                            <p>
                                <i class="iconfont icon-ren subicon">&#xe6fe;</i>
                                <span>{{address.province+address.city+address.area+address.street}}</span>
                            </p>
                        </li>
                    </ul>
                </div>
                <div class="addaddress">
                    <span @click="addaddress">添加新地址</span>
                </div>
            </div>
        </div>
        <div class="peisong">
            <div class="peisongheader">
                <span>配送方式</span>
            </div>
            <div class="peisongbody">
                <div class="choosepeisong">
                    <select name="peisong" v-model="peisong">
                        <option value="EMS">EMS</option>
                        <option value="顺丰">顺丰</option>
                        <option value="中通">中通</option>
                        <option value="圆通">圆通</option>
                        <option value="韵达">韵达</option>
                        <option value="其他">其他</option>
                    </select>
                </div>
                 <div class="checktotal">
                    <span>运费：</span>
                    <span class="totalnumber">￥{{logistics_fee||0}}</span>
                </div>
            </div>
        </div>
        <div class="peisong">
            <div class="peisongheader">
                <span>支付方式</span>
            </div>
            <div class="peisongbody">
               <select name="peisong" v-model="zhihu">
                        <option value="支付宝">支付宝</option>
                        <option value="微信">微信</option>
                        <option value="信用卡">信用卡</option>
                        <option value="货到付款">货到付款</option>
                </select>
            </div> 
        </div>
        <div class="peisong">
            <div class="peisongheader">
                <span>发票</span>
            </div>
            <div class="peisongbody">
                是否需要发票：<input type="radio" name="radio" value="1" v-model="isinvoice">是
                        <input type="radio" name="radio" value="0" checked="checked" v-model="isinvoice">否
            </div> 
        </div>
        <div class="peisong">
            <div class="peisongheader">
                <span>购物清单</span>
            </div>
            <div class="peisongbody">
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
                        <li v-for="(goods,index) in goodslist" :key="index">
                            <ul class="shoplist">
                                <li class="name">
                                    <div class="shopimg">
                                        <img :src="goods.goods_picture" alt="">
                                    </div>
                                    <div class="shopname">
                                        <router-link :to="{path:'/goodsdetail',query:{}}"> {{goods.goods_name}} </router-link>
                                    </div>
                                </li>
                                <li class="like">{{goods.goods_price}}</li>
                                <li class="like buyNumber">{{counter}}</li>
                                <li class="like">{{goods.goods_price*counter}}</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div> 
        </div>
        <div class="peisong">
            <label for="marks">备注</label>
            <textarea name="marks" v-model="user_remarks" cols="30" rows="10"></textarea>
        </div>
        <div class="peisong">
           <div class="footerbox">
                <div class="checktotal">
                    <span>商品金额：</span>
                    <span class="totalnumber">￥</span>
                </div>
                <div class="checktotal">
                    <span>运费：</span>
                    <span class="totalnumber">￥{{logistics_fee}}</span>
                </div>
                <div class="checktotal">
                    <span>应付总金额：</span>
                    <span class="totalnumber">￥{{logistics_fee}}</span>
                </div>
                <div class="surebtn">
                    <button @click="placeorder">提交订单</button>
                </div>
           </div>
        </div>
        <add-box @closeadd='showaddbox' v-if="showadd">
            <add-address :id="user_id"></add-address>
        </add-box>
        <Background v-if="showbackground"></Background>
    </div>
</template>
<script>
import axios from 'axios'
import { mapState, mapGetters } from "vuex";
import { reqShopCar } from "../../api";
import CarList from "@/components/global/cart";
import BMap from "@/components/global/bmap"
import AddBox from "@/components/Communal/addbox"
import AddAddress from "@/components/global/addaddress"
import Background from "@/components/Communal/background"
export default {
    data(){
        return{
            goodslist:{},
            counter:'',
            addresslist:'',
            isinvoice:0,
            invoice_id:'',
            tel:'',
            user_name:'',
            user_id:'',
            peisong:'',
            zhihu:'',
            address_id:'',
            user_remarks:'',
            logistics:'',
            showadd:false,
            showbackground:false
        }
    },
    computed: {
        ...mapGetters(['buydata','userinfo']),
        logistics_fee(){
            if(this.peisong=="EMS"){
                return 0;
            }else if(this.peisong=="顺丰"){
                return 20;
            }else if(this.peisong=="圆通"){
                return 15;
            }else if(this.peisong=="中通"){
                return 16;
            }else if(this.peisong=="韵达"){
                return 12;
            }else{
                return 0;
            }
        }
    },
    created() {
        console.log(this.$router)
        var buydata=JSON.parse(sessionStorage.getItem('buydata'));
        this.counter=buydata.counter;
        this.goods_id=buydata.goods_id;
        axios.post('http://localhost:3333/main/getgoodsdetail',{
            goods_id:buydata.goods_id
            }).then(response=>{
                if(response.data.code==0){
                    this.goodslist=response.data.goods;
                }else{
                    console.log("获取失败")
                }
            },response=>{
                console.log("error:"+response)
        })
        axios.get("http://localhost:3333/api").then(response=>{
                    if(response.data.code=='0'){
                        this.user_id=response.data.user.user_id;
                        this.getaddress();
                        }
                },response=>{
                    console.log("error:"+response)
                })
    },
    watch: {
       $route: {
            handler(newValue, oldValue) {
                sessionStorage.removeItem("buydata")
            }
        }
    },
    methods:{
        showaddbox(){
            this.showadd=!this.showadd;
            this.showbackground=!this.showbackground;
        },
        addaddress(){
            this.showadd=!this.showadd;
            this.showbackground=!this.showbackground;
        },
        deleteaddress(id){
             axios.post('http://localhost:3333/main/deleteaddress',{
                address_id:id
                }).then(response=>{
                    if(response.data.code==0){
                        this.getaddress();
                    }else{
                        console.log("删除失败")
                    }
                },response=>{
                    console.log("error:"+response)
                })
        },
        setdefault(id){
            axios.post('http://localhost:3333/main/setdefault',{
                user_id:this.user_id,
                address_id:id
            }).then(response=>{
                if(response.data.code==0){
                    this.getaddress();
                }else{
                    console.log("设置失败")
                }
            },response=>{
                console.log("error:"+response)
            })
        },
        editaddress(id){

        },
        placeorder(){
            axios.post('http://localhost:3333/main/addorder',{
                            goods_id:this.goods_id,
                            user_id:this.user_id,
                            address_id:this.addresslist[0].address_id,
                            product_count:this.counter,
                            product_amount_total:this.counter*this.goodslist[0].goods_price,
                            order_amount_total:this.counter*this.goodslist[0].goods_price+this.logistics_fee,
                            pay_channel:this.zhihu,
                            user_remarks:this.user_remarks,
                            logistics:this.peisong,
                            logistics_fee:this.logistics_fee,
                            isinvoice:this.isinvoice,
                        }).then(response=>{
                            if(response.data.code==0){
                            this.$router.push('/payfor?order_id='+response.data.order_id)
                            }else{
                                console.log("添加失败")
                            }
                        },response=>{
                            console.log("error:"+response)
                        })
        },
        getaddress(){
            axios.post('http://localhost:3333/main/getaddress',{
            user_id:this.user_id
            }).then(response=>{
                if(response.data.code==0){
                    this.addresslist=response.data.address;
                }else{
                    console.log("获取失败")
                }
            },response=>{
                console.log("error:"+response)
            })
        },
    },
    components:{
        BMap,
        AddAddress,
        AddBox,
        Background
    }
}
</script>
<style scoped>
.iconfont {
  font-family: "iconfont" !important;
  font-size: 24px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.placeorderbox{
    width: 1200px;
    margin: auto;
}
.peisong,
.addressmsg{
    width:100%;
}
.peisongheader,
.addressheader{
    width: 100%;
    height: 50px;
    font-size: 18px;
    font-family: "微软雅黑";
    color: #333;
    line-height: 50px;
    font-weight: bold;
}
.addressbody{
    width: 100%;
    overflow: hidden;
}
.addaddress,
.address{
    float: left;
    position: relative;
    width: 332px;
    height: 212px;
    border: 1px solid #ddd;
    border-radius: 8px;
    margin-right: 30px;
    margin-bottom: 20px;
    overflow: hidden;
    font-size: 14px;
    font-family: "微软雅黑";
    color: #333;
}
.addaddress span{
    display: block;
    width: 100%;
    height: 100%;
    line-height: 212px;
    font-size: 20px;
    text-align: center;
}
.address>ul>li{
    margin: auto;
    width: 90%;
}
.address>ul>li:not(.lastli){
    border-bottom: 1px dashed #ccc;
}
.address>ul>li p{
    width: 100%;
    margin: 15px 10px;
    font-size: 15px;
    font-family: "微软雅黑";
    color: #333;
    line-height: 20px;
}
.address:hover .setup{
    display: block;
}
.address:hover{
    border: 1px solid #076ce0;
}

.setup{
    position: absolute;
    right: 0px;
    display: none;
}
.setup ul li{
    display: inline-block;
    color: #076ce0;
    margin: 0px 5px;
    font-size: 15px;
    line-height: 30px; 
    vertical-align: top;
    
}
.setup ul li:hover{
    cursor: pointer;
}
.peisongbody{
    padding: 30px;
    border: 1px solid #eee;
    margin-top: 22px;
    overflow: hidden;
}
.choosepeisong{
    float: left;
}
.choosepeisong select{
    width: 248px;
    height: 28px;
    padding: 0;
    border: 1px solid #d3d3d3;
    margin: 0;
    color: #9a9a9a;
}
.peisongfei{
    margin-left: 50px;
    margin-top: 5px;
    float: left;
    font-size: 14px;
    color:#666;
}
.choosepay{
    width: 100px;
    height: 30px;
    border:1px solid #aaa;
    display: inline-block;
    margin: auto 10px;
}
.listheader {
  width: 100%;
  height: 29px;
  font-size: 15px;
}
.listheader li {
  display: block;
  float: left;
  line-height: 29px;
}
.name {
  width: 58%;
}
.like {
  width: 10%;
  text-align: center;
}
.shoplist {
  height: 90px;
  width: 100%;
  border-bottom: 1px dashed #969696;
}
.shoplist:hover,
.shoplist:hover a {
  color: #076ce0;
}
.shoplist:hover a {
  cursor: pointer;
}
.shoplist li {
  display: block;
  float: left;
  height: 90px;
  line-height: 90px;
}
.name div {
  float: left;
  margin: 0 5px;
  line-height: 90px;
}
.shopimg img {
  width: 60px;
  height: 60px;
  display: block;
  margin-top: 25%;
}
.shopname a {
  color: #333;
}
.buyNumber span {
  position: relative;
  height: 35px;
  display: inline-block;
  line-height: 35px;
}

.buyNumber input {
  width: 20px;
  text-align: center;
  height: 15px;
  font-size: 12px;
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
.checktotal{
  margin-right:100px;
  height: 30px;
  font-size: 20px;
  color: #333;
  font-weight: bold;
  line-height: 30px;
}
.totalnumber{
  color: #076ce0;
}
.surebtn button{
    width: 120px;
  font-weight: bold;
  height: 40px;
  outline: 0;
  font-size: 20px;
  background: #3a8ee6;
  border: 0px;
  color: #fff;
  border-radius: 3px;
}
.footerbox{
    width: 300px;
    float: right;
}
</style>

