<template>
    <div class="placeorderbox">
        <div class="addressmsg">
            <div class="addressheader">
                <span>收货人信息</span>
            </div>
            <div class="addressbody">
                <div class="address">
                    <div class="setup">
                        <ul>
                            <li><span>设为默认</span></li>
                            <li><i class="iconfont icon-ren subicon">&#xe622;</i></li>
                            <li><i class="iconfont icon-ren subicon">&#xe617;</i></li>
                        </ul>
                    </div>
                    <ul>
                        <li>
                            <p>
                                <i class="iconfont icon-ren subicon">&#xe63c;</i>
                                <span>{{user_name}}</span>
                            </p>
                        </li>
                        <li>
                             <p>
                                <i class="iconfont icon-ren subicon">&#xe63c;</i>
                                <span>{{tel}}</span>
                            </p>
                        </li>
                        <li class="lastli">
                            <p>
                                <i class="iconfont icon-ren subicon">&#xe63c;</i>
                                <span>{{address}}</span>
                            </p>
                        </li>
                    </ul>
                </div>
                <div class="address"></div>
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
                        <li class="like buyNumber">{{goods.goods_count}}</li>
                        <li class="like">{{goods.goods_price*goods.goods_count}}</li>
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
                    <span class="totalnumber">￥{{goods.goods_price*goods.goods_count}}</span>
                </div>
                <div class="checktotal">
                    <span>运费：</span>
                    <span class="totalnumber">￥{{logistics_fee}}</span>
                </div>
                <div class="checktotal">
                    <span>应付总金额：</span>
                    <span class="totalnumber">￥{{goods.goods_price*goods.goods_count+logistics_fee}}</span>
                </div>
                <div class="surebtn">
                    <button @click="placeorder">提交订单</button>
                </div>
           </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
import { mapState, mapGetters } from "vuex";
import { reqShopCar } from "../../api";
export default {
    data(){
        return{
            goods:{},
            address:'',
            tel:'',
            user_name:'',
            goods_id:this.$route.query.goods_id,
            user_id:'',
            peisong:'',
            zhihu:'',
            address_id:'',
            user_remarks:'',
            logistics:''
        }
    },
    computed: {
        ...mapGetters(['counter','userinfo']),
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
         axios.get("http://localhost:3333/api").then(response=>{
                    if(response.data.code=='0'){
                        this.user_id=response.data.user.user_id
                        this.getaddress();
                        this.getcart();
                        }
                },response=>{
                    console.log("error:"+response)
                })
    },
    methods:{
        placeorder(){
            localStorage.setItem('zhihu',this.zhihu);
            axios.post('http://localhost:3333/main/addorder',{
                goods_id:this.goods_id,
                user_id:this.user_id,
                address_id:this.address_id,
                product_count:this.goods.goods_count,
                product_amount_total:this.goods.goods_count*this.goods.goods_price,
                order_amount_total:this.goods.goods_count*this.goods.goods_price+this.logistics_fee,
                pay_channel:this.zhihu,
                user_remarks:this.user_remarks,
                logistics:this.peisong,
                logistics_fee:this.logistics_fee,
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
                    this.address=response.data.address[0].province+response.data.address[0].city+response.data.address[0].area+response.data.address[0].street;
                    this.tel=response.data.address[0].tel;
                    this.user_name=response.data.address[0].user_name;
                    this.address_id=response.data.address[0].address_id;
                }else{
                    console.log("获取失败")
                }
            },response=>{
                console.log("error:"+response)
            })
        },
        getcart(){
             axios.post('http://localhost:3333/main/getcart',{
                user_id:this.user_id,
                }).then(response=>{
                    if(response.data.code==0){
                        this.goods=response.data.cart[0];
                    console.log(this.goods)
                    }else{
                        console.log("获取失败")
                    }
                },response=>{
                    console.log("error:"+response)
            })
        }
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
.listbody li {
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

