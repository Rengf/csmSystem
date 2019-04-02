<template>
    <div class="orderdetail">
        <div class="orderdetailbox">
            <div class="orderheader">
                <span>订单编号：</span>
                <span>{{order.order_no}}</span>
            </div>
            <div class="personmsg">
                <div class="personmsgheader">
                    <span>收件人信息</span>
                </div>
                <div class="personmsgbody">
                    <ul>
                        <li>
                            <label for="name">收件人姓名：</label>
                            <span>{{order.addressee}}</span>
                        </li>
                        <li>
                            <label for="tel">收件人电话：</label>
                            <span>{{order.tel}}</span>
                        </li>
                        <li>
                            <label for="name">邮政编码：</label>
                            <span>{{order.zip_code}}</span>
                        </li>
                        <li>
                            <label for="address">收件地址：</label>
                            <span>{{order.province+order.city+order.area+order.street}}</span>
                        </li>
                        <li>
                            <label for="name">备注说明：</label>
                            <span>{{order.user_remarks}}</span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="goodsmsg">
                <div class="goodsmsgheader">
                    <span>产品信息</span>
                </div>
                <div class="goodsmsgbody">
                    <div class="msgbox">
                        <div class="goodsimg">
                            <img :src="order.goods_picture" alt="">
                        </div>
                        <div class="goods">
                            <ul>
                                <li>商品名称：{{order.goods_name}}</li>
                                <li>价格：{{order.goods_price}}</li>
                                <li>描述：{{order.goods_description}}</li>
                                <li>数量：{{order.product_count}}</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="othermsg">
                <div class="othermsgheader">
                    <ul>
                        <li>
                            <label for="name">支付方式：</label>
                            <span>{{order.pay_channel}}</span>
                        </li>
                        <li>
                            <label for="name">支付状态：</label>
                            <span>{{order.order_status=='0'?'未付款':(order.order_status=='1'?'已付款':'已发货')}}</span>
                        </li>
                        <li>
                            <label for="name">订单生成日期：</label>
                            <span>{{order.addorder_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</span>
                        </li>
                        <li>
                            <label for="name">快递名称：</label>
                            <span>{{order.logistics}}</span>
                        </li>
                        <li>
                            <label for="name">发货日期：</label>
                            <span>{{order.delivery_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</span>
                        </li>
                        <li>
                            <label for="name">快递单号：</label>
                            <span>{{order.express_no}}</span>
                        </li>
                    </ul>
                </div>
                <div class="othermsgbody">
                    <ul>
                        <li>
                            <label for="name">商品总额：</label>
                            <span>￥{{order.goods_price*order.product_count}}</span>
                        </li>
                        <li>
                            <label for="name">运费价格：</label>
                            <span>￥{{order.logistics_fee}}</span>
                        </li>
                        <li>
                            <label for="name">支付金额：</label>
                            <span>￥{{parseInt(order.goods_price*order.product_count)+parseInt(order.logistics_fee)}}</span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="logistics">
                <div class="logisticsheader">
                    <span>物流信息</span>
                </div>
            </div>
            <div class="orderbtn">
                <button @click="getorder">获取信息</button>
            </div>
        </div>
    </div>
</template>
<script>
import {mapGetters} from 'vuex'
export default {
    data(){
        return {
            order_id:this.$route.query.order_id
        }
    },
    created() {
        this.$store.dispatch('getOrder',this.order_id)
    },
    computed: {
        ...mapGetters(['order'])
    },
    methods: {
        getorder(){
            console.log(this.order)
        }
    },
}
</script>
<style scoped>
.orderdetail{
    margin-top: 70px;
    box-sizing: border-box;
    border: 1px solid #ddd;
    position: relative;
    left: 11%;
    width: 89%;
    background: #fff;
    padding: 10px 10px;
}



.orderheader{
    height: 40px;
    line-height: 40px;
    border-bottom: 1px dashed #ddd;
    margin-bottom: 15px;
}
.orderheader span:nth-child(1){
        color: #555;
        font-size: 14px;
}
.orderheader span:nth-child(2){
        color: #F60;
        font-size: 18px;
        font-weight: bold;
        margin-left: 5px;
}
.goodsmsg,
.othermsg,
.personmsg{
    border: 1px solid #dddddd;
    margin-bottom: 15px;
    overflow: hidden;
}
.logisticsheader,
.goodsmsgheader,
.personmsgheader{
    height: 40px;
    border-bottom: 1px solid #dddddd;
    line-height: 40px;
    font-size: 16px;
    padding: 0px 20px;
    background: #2a8bcc!important;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#ffffff),to(#ededed))!important;
    background-image: -webkit-linear-gradient(top,#ffffff,0%,#ededed,100%)!important;
    background-image: -moz-linear-gradient(top,#ffffff 0,#ededed 100%)!important;
    background-image: linear-gradient(to bottom,#ffffff 0,#ededed 100%)!important;
    background-repeat: repeat-x!important;
}
.othermsgheader li,
.personmsgbody li{
    height: 50px;
    margin: 0 100px;
    line-height: 50px;
    display: inline-block;
    font-size: 14px;
    vertical-align: top;
}
.msgbox{
    border: 1px solid #dddddd;
    height: 211px;
    width: 495px;
    padding: 0px 0px;
    margin: 10px 5px;
    line-height: 26px;
    float: left;
}
.goodsimg{
    box-sizing: content-box;
    width: 204px;
    height: 211px;
    border-right: 1px solid #dddddd;
    padding: 1px;
    float: left;
}
.goodsimg img{
    width: 204px;
    height: 209px;;
}
.goods{
    height: 211px;
    width: 278px;
    float:right;
    padding: 5px;
}
.goods li{
    display: block;
    height: 50px;
    line-height: 25px;
    font-size: 15px;
}
.othermsg{
    padding: 10px;
}
.othermsgheader{
    border-bottom: 1px dashed #ccc;
}
.othermsgbody ul{
    width: 550px;
    float: right;
}
.othermsgbody label{
    height: 50px;
    line-height: 50px;
    font-size: 15px;
    font-weight: bold;
}
.othermsgbody span{
     height: 50px;
    line-height: 50px;
    font-size: 18px;
    font-weight: bold;
    color: #f33;
}
.othermsgbody li{
    display: inline-block;
    vertical-align: top;
    margin: 10px 15px;
}
</style>
