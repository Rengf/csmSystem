<template>
    <div class="home">
         <div class="homebox">
             <div class="homeboxheader">
                 <ul>
                     <li>
                         <a href="#">
                             <div class="leftbox">
                                 <i class="iconfont">&#xe711;</i>
                                 <span>成交金额</span>
                             </div>
                             <div class="rightbox">
                                 <span>165465.5元</span>
                             </div>
                         </a>
                     </li>
                     <li>
                         <a href="#">
                             <div class="leftbox">
                                 <i class="iconfont">&#xe606;</i>
                                 <span>留言</span>
                             </div>
                             <div class="rightbox">
                                 <span>165465条</span>
                             </div>
                         </a>
                     </li>
                     <li>
                         <a href="#">
                             <div class="leftbox">
                                 <i class="iconfont">&#xe711;</i>
                                 <span>订单</span>
                             </div>
                             <div class="rightbox">
                                 <span>165465笔</span>
                             </div>
                         </a>
                     </li>
                     <li>
                         <a href="#">
                             <div class="leftbox">
                                 <i class="iconfont">&#xe615;</i>
                                 <span>通知</span>
                             </div>
                             <div class="rightbox">
                                 <span>16546条</span>
                             </div>
                         </a>
                     </li>
                     <li>
                         <a href="#">
                             <div class="leftbox">
                                 <i class="iconfont">&#xe711;</i>
                                 <span>待处理</span>
                             </div>
                             <div class="rightbox">
                                 <span>16546条</span>
                             </div>
                         </a>
                     </li>
                     <li>
                         <a href="#">
                             <div class="leftbox">
                                 <i class="iconfont">&#xe711;</i>
                                 <span>紧急通知</span>
                             </div>
                             <div class="rightbox">
                                 <span>165465条</span>
                             </div>
                         </a>
                     </li>
                 </ul>
             </div>
             <div class="homeboxbody">
                 <div class="nowtime">
                     <div class="time">
                         <span>{{hours}}</span>
                         <i>:</i>
                          <span>{{minutes}}</span>
                         <i>:</i>
                          <span>{{seconds}}</span>
                     </div>
                     <div class="date">
                         <div class="dateheader">
                             <span>{{year}}年{{month}}月</span>
                         </div>
                         <div class="datebody">
                             <span>{{date}}</span>
                             <span>星期{{xingqi}}</span>
                         </div>
                     </div>
                 </div>
                 <div class="shopmsg">
                     <div class="shoplogo">
                         <img src="../../assets/images/login.jpg" alt="">
                     </div>
                 </div>
                 <div class="loginrecord">
                     <ul>
                         <li>
                             <span>登录记录</span>
                             <span></span>
                             <span><router-link to="/admin/adminlist">+更多</router-link></span>
                         </li>
                         <li v-for="(admin,index) in adminlist" :key="index" >
                             <span>{{admin.user_name}}</span>
                             <span>{{admin.isadmin=='1'?'普通管理员':'超级管理员'}}</span>
                             <span>{{admin.last_login_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</span>
                         </li>
                         <li v-if="adminlist.length<5">
                            <span></span>
                            <span>没有更多了</span>
                            <span></span>
                        </li>
                     </ul>
                 </div>
             </div>
             <div class="ordergoodsbox">
                 <div class="orderstate">
                     <div class="orderstateheader">
                         <span>订单状态提示</span>
                     </div>
                     <div class="orderstatebody">
                         <div class="orderstatebox">
                             <div>
                                 <span>线上订单</span>
                             </div>
                             <ul>
                                 <li>
                                     <span>待发货订单</span>
                                     <router-link to="/admin/orderlist?order_status=1">(02)</router-link>
                                 </li>
                                 <li>
                                     <span>已发货订单</span>
                                     <router-link to="/admin/orderlist?order_status=2">(05)</router-link>
                                 </li>
                                 <li>
                                     <span>未完成订单</span>
                                     <a href="#">(15)</a>
                                 </li>
                             </ul>
                         </div>
                         <div class="orderstatebox">
                             <div>
                                 <span>线下订单</span>
                             </div>
                             <ul>
                                 <li>
                                     <span>待发货订单</span>
                                     <a href="#">(02)</a>
                                 </li>
                                 <li>
                                     <span>已发货订单</span>
                                     <a href="#">(05)</a>
                                 </li>
                                 <li>
                                     <span>未完成订单</span>
                                     <a href="#">(15)</a>
                                 </li>
                             </ul>
                         </div>
                         <div class="orderstatebox">
                             <div>
                                 <span>售后</span>
                             </div>
                             <ul>
                                 <li>
                                     <span>待发货订单</span>
                                     <a href="#">(02)</a>
                                 </li>
                                 <li>
                                     <span>已完成订单</span>
                                     <a href="#">(05)</a>
                                 </li>
                                 <li>
                                     <span>未完成订单</span>
                                     <a href="#">(15)</a>
                                 </li>
                             </ul>
                         </div>
                         <div class="orderstatebox">
                             <div>
                                 <span>结算</span>
                             </div>
                             <ul>
                                 <li>
                                     <span>未付款订单</span>
                                     <router-link to="/admin/orderlist?order_status=0">(05)</router-link>
                                 </li>
                                 <li>
                                     <span>已完成订单</span>
                                     <a href="#">(05)</a>
                                 </li>
                                 <li>
                                     <span>未完成订单</span>
                                     <a href="#">(15)</a>
                                 </li>
                             </ul>
                         </div>
                     </div>
                     <div class="ordercharts">
                         <div id="chart"></div>
                     </div>
                 </div>
                 <div class="goodsstate">
                      <div class="goodstateheader">
                         <span>商品销售排行</span>
                     </div>
                     <div class="goodsstatebody">
                         <table>
                             <thead>
                                 <tr>
                                     <th width="50">排名</th>
                                     <th width="150">商品类别</th>
                                     <th width="500">商品名</th>
                                     <th width="100">销售数量</th>
                                 </tr>
                             </thead>
                             <tbody>
                                 <tr v-for="(goods,index) in goodslist" :key="index">
                                     <td><span>{{index+1}}</span></td>
                                     <td>{{goods.goods_type_name}}</td>
                                     <td>{{goods.goods_name}}</td>
                                     <td>{{goods.sales}}</td>
                                 </tr>
                             </tbody>
                         </table>
                     </div>
                 </div>
             </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
import echarts from 'echarts'
import {mapGetters} from 'vuex'
export default {
     data () {
            return {
                charts: '',
                year:'',
                month:'',
                date:'',
                hours:'',
                minutes:'',
                seconds:'',
                day:'',
                goodslist:'',
                sales:[],
                salesonline:[],
                condition:{}
            }
        },
        created() {
            this.$store.dispatch('getAdminlist',this.condition);
            axios.get("http://localhost:3333/admin/getgoodslistbysales").then(
                response=>{
                    if(response.data.code==0){
                        this.goodslist=response.data.goodslist
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
        this.searchsales();
        this.searchsalesonline();
           
        },
        computed: {
            ...mapGetters(['adminlist']),
            xingqi(){
                switch(this.day){
                    case 0:
                        return '日'
                        break
                    case 1:
                        return '一'
                        break
                    case 2:
                        return '二'
                        break
                    case 3:
                        return '三'
                        break
                    case 4:
                        return '四'
                        break
                    case 5:
                        return '五'
                        break
                    case 6:
                        return '六'
                        break
                }
            },
            xiaoliang(){
                 var date = new Date(),dateArr=[],series=[];
                 for(var i =0;i<7;i++){
                     dateArr.push(this.$moment(date).subtract(i,'days').format('YYYY-MM-DD'))
                 }
                 dateArr.reverse();
                 dateArr.map(v=>{
                     var sum = 0;
                     this.sales.map(val=>{
                         val.addorder_time.includes(v)?sum=sum+parseInt(val.product_count):''
                     })
                     series.push(sum)
                 })
                 return {
                     xAxis:dateArr,
                     series:series
                 }
            },
            xiaoliangonline(){
                 var date = new Date(),dateArr=[],series=[];
                 for(var i =0;i<7;i++){
                     dateArr.push(this.$moment(date).subtract(i,'days').format('YYYY-MM-DD'))
                 }
                 dateArr.reverse();
                 dateArr.map(v=>{
                     var sum = 0;
                     this.salesonline.map(val=>{
                         val.addorder_time.includes(v)?sum=sum+parseInt(val.product_count):''
                     })
                     series.push(sum)
                 })
                 return {
                     xAxis:dateArr,
                     series:series
                 }
            },
        },
        methods:{
            searchsales(){
                 axios.get("http://localhost:3333/admin/searchsales").then(
                response=>{
                    if(response.data.code==0){
                        this.sales=response.data.result;
                       this.drawPie('chart')
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
            },
            searchsalesonline(){
                 axios.get("http://localhost:3333/admin/searchsalesonline").then(
                response=>{
                    if(response.data.code==0){
                        this.salesonline=response.data.result;
                       this.drawPie('chart')
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
            },
            datetime(){
                var date=new Date();
                this.year=date.getFullYear();
                this.month=date.getMonth();
                this.date=date.getDate();
                this.hours=date.getHours();
                this.minutes=date.getMinutes();
                this.seconds=date.getSeconds();
                this.day=date.getDay();
            },
            drawPie(id){
               this.charts = echarts.init(document.getElementById(id))
               this.charts.setOption({
                   title: {
                        text: '最近七天销售变化',
                    },
                 tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['总销售量','线上销量']
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            dataZoom: {
                                yAxisIndex: 'none'
                            },
                            dataView: {readOnly: false},
                            magicType: {type: ['line', 'bar','pie']},
                            restore: {},
                            saveAsImage: {}
                        }
                    },
                    xAxis:  {
                        type: 'category',
                        boundaryGap: false,
                        data: this.xiaoliang.xAxis
                    },
                    yAxis: {
                        type: 'value',
                        axisLabel: {
                            formatter: '{value} '
                        }
                    },
                    series: [
                    {
                        name:'总销售量',
                        type:'line',
                        data:this.xiaoliang.series,
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                         markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }       
                    },
                    {
                        name:'线上销量',
                        type:'line',
                        data:this.xiaoliangonline.series,
                        markPoint: {
                            data: [
                                {type: 'max', name: '最大值'},
                                {type: 'min', name: '最小值'}
                            ]
                        },
                         markLine: {
                            data: [
                                {type: 'average', name: '平均值'}
                            ]
                        }       
                    },
                ]
               })
            }
        },
      //调用
        mounted(){
            setInterval(()=>{
                this.datetime()
            },1000)
        }
}
</script>
<style scoped>
 .iconfont {
  font-family: "iconfont" !important;
  font-size: 16px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.homebox{
    padding: 20px;
    border: 1px solid #ccc;
    overflow: hidden;
}
.homeboxheader{
    width: 1630px;
    height: 100px;
}
.homeboxheader ul{
    display: flex;
}
.homeboxheader ul li{
    width: 250px;
    height: 100px;
    margin-right: 19px;
    flex-grow:1;
}
.homeboxheader ul li:nth-child(1) .leftbox{
    background: #60A7D0
}
.homeboxheader ul li:nth-child(1) .rightbox{
    background: #438EB9
}
.homeboxheader ul li:nth-child(2) .leftbox{
    background: #9CD159;
}
.homeboxheader ul li:nth-child(2) .rightbox{
    background: #72B63F
}
.homeboxheader ul li:nth-child(3) .leftbox{
    background: #FF7171;
}
.homeboxheader ul li:nth-child(3) .rightbox{
    background: #ff5757
}
.homeboxheader ul li:nth-child(4) .leftbox{
    background: #FF8E68;
}
.homeboxheader ul li:nth-child(4) .rightbox{
    background: #FF6633
}
.homeboxheader ul li:nth-child(5) .leftbox{
    background: #AD96D6;
}
.homeboxheader ul li:nth-child(5) .rightbox{
    background: #8775a7
}
.homeboxheader ul li:nth-child(6) .leftbox{
    background: #FDDF39;
}
.homeboxheader ul li:nth-child(6) .rightbox{
    background: #F5C23D
}
.leftbox{
    float: left;
    width: 100px;
    height: 100px;
    background: #bbb;
    text-align: center
}
.rightbox{
    float: left;
    width: 150px;
    height: 100px;
    text-align: center;
    background: #c89;
}
.leftbox i{
    display: block;
    line-height: 70px;
    font-size: 36px;
    font-weight: bold;
    font-family: "Microsoft YaHei";
    color: #fff;
}
.leftbox span{
    display: block;
    font-weight: bold;
    font-size: 15px;
    font-family: "Microsoft YaHei";
    color: #fff;
}
.rightbox span{
    line-height: 100px;
    font-size: 20px;
    font-weight: bold;
    color:#fff;
}
.homeboxbody{
    overflow: hidden;
    margin-top: 20px;
    height: 260px;
}
.nowtime{
    float: left;
    width: 400px;
    height: 250px;
}
.time{
    text-align: center;
    width: 250px;
    height: 70px;
    margin: auto;
    font-size: 34px;
    font-weight: bold;
}
.time span{
    display: inline-block;
    width: 60px;
    height: 45px;
    line-height: 45px;
    border-radius: 3px;
    vertical-align: middle;
    border: 1px solid #ccc
}
.date{
    width: 250px;
    height: 170px;
    margin: auto;
    border: 1px solid #ccc;
}
.dateheader{
    text-align: center;
    font-size: 25px;
    height: 40px;
    line-height: 40px;
    border-bottom: 1px solid #ccc;
    background: #eee
}
.datebody span:nth-child(1){
    display: block;
    font-size: 40px;
    line-height: 80px;
    color: #438EB9; 
    font-weight: bold;
    text-align: center;
}
.datebody span:nth-child(2){
    display: block;
    font-size: 25px;
    line-height: 30px;
    color: #555; 
    font-weight: bold;
    text-align: center;
}
.shopmsg{
    float: left;
    width: 600px;
    height: 250px;
    margin-right: 10px;
    border: 1px solid #ccc;
}
.shoplogo{
    width: 600px;
    height: 250px;
}
.shoplogo img{
    width: 600px;
    height: 250px;
}
.loginrecord{
    float: left;
    width: 600px;
    height: 250px;
    border:1px solid #ccc;
    overflow: hidden;
}
.loginrecord li{
    box-sizing: border-box;
    height: 42px;
    line-height: 42px;
    font-size: 12px;
    color: #999;
    display: flex;
    text-align: center;
    border-bottom: 1px solid #ccc
}
.loginrecord li span{
    flex-direction:  column;
    flex-wrap: nowrap;
    justify-content:space-between;
    flex-grow:1;
}
.ordergoodsbox{
    margin-top: 20px;
}
.orderstate,
.goodsstate{
    float: left;
    width: 800px;
    height: 500px;
    border: 1px solid #ccc;
    margin-right: 10px;
}
.goodstateheader,
.orderstateheader{
    width: 100%;
    height: 50px;
    font-size: 20px;
    font-weight: bold;
    color: #333;
    line-height: 50px;
    border-bottom: 1px solid #ccc;
}
.goodstateheader span,
.orderstateheader span{
    margin-left: 30px;
}
.orderstatebody{
    display: flex;
}
.orderstatebox{
    flex-direction:  column;
    flex-wrap: nowrap;
    justify-content:space-between;
    flex-grow:1;
}
.orderstatebox div{
    height: 50px;
    line-height: 50px;
    font-size: 16px;
    font-weight: bold;
    color: #333;
    margin-left: 40px;
}
.orderstatebox ul li{
    height: 40px;
    line-height: 40px;
    font-size: 14px;
    text-align: center;
    color: #444;
}

.orderstatebox ul a{
    margin-left: 30px;
    color: #2C9CEF;
    font-weight: bold
}
.goodsstatebody thead tr{
    height: 40px;
    line-height: 40px;
    font-size: 13px;
    color: #000;
    border-bottom: 1px solid #ccc;
    background:#ededed
}
.goodsstatebody tbody tr{
    height: 40px;
    line-height: 40px;
    font-size: 13px;
    color: #000;
    border-bottom: 1px solid #ccc;
}
.goodsstatebody tbody tr td{
    text-align: center;
}
.goodsstatebody tbody tr span{
    padding: 4px 7px;
    width: 20px;
    height: 20px;
    background: #ff5757;
    border-radius: 3px;
    color: #fff;
}
.ordercharts{
    height: 278px;
}.ordercharts>div{
    height: 278px;
}
</style>
