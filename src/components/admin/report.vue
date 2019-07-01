<template>
    <div>
        <div class="somebtn">
            <button @click="getorderlist()">按天显示</button>
            <button @click="getorderlist(0)">按周显示</button>
            <button @click="getorderlist(1)">按月显示</button>
            <button @click="getorderlist(2)">按季度显示</button>
            <button @click="getorderlist(3)">按年显示</button>
        </div>
        <div class="ordercharts">
            <div id="chart" class="chart"></div>
        </div>
        <div class="ordercharts">
            <div class="selectgoods">
                <label for="goodsname">商品名称：</label>
                <select name="goodsname" v-model="goods" @change="getgoodssales">
                    <option :value="goods" v-for="(goods,index) in goodslist" :key="index" ref="newtext">{{goods.goods_name}}</option>
                </select>
            </div>
            <div id="chart1" class="chart"></div>
        </div>
        <div class="ordercharts">
            <div id="chart2" class="chart"></div>
        </div>
    </div>
</template>
<script>
import echarts from 'echarts'
import axios from 'axios'
import {mapGetters} from 'vuex'
export default {
    data() {
        return {
            sales:[],
            salesonline:[],
            salesoffline:[],
            salesgoods:[],
            salesonlinegoods:[],
            salesofflinegoods:[],
            charts:'',
            goods:{goods_id:13,goods_name:'脉动'},
            allsalesgoods:[]
        }
    },
    created() {
        this.condition=this.$route.query;
        this.$store.dispatch('getGoodsList',[,this.condition]);
        this.searchsales();
        this.searchsalesonline();
        this.searchsalesoffline();
        this.goodssales();
        this.allgoodssales();
        this.goodsonlinesales();
        this.goodsofflinesales();
    },
    computed: {
        ...mapGetters(['goodslist']),
        xiaoliang(){
                 var date = new Date(),dateArr=[],series=[],onlineseries=[],offlineseries=[],goodsseries=[],goodsonlineseries=[],goodsofflineseries=[];
                 for(var i =0;i<7;i++){
                     dateArr.push(this.$moment(date).subtract(i,'days').format('YYYY-MM-DD'))
                 }
                 dateArr.reverse();
                 dateArr.map(v=>{
                     var salessum=0,onlineselassum = 0,offlineselassum=0,goodssum=0,goodsonlinesum=0,goodsofflinesum=0;
                     this.sales.map(val=>{
                         if(v==val.days){
                            salessum=val.count;
                         }
                     })
                    series.push(salessum);
                    this.salesonline.map(val=>{
                            if(v==val.days){
                                onlineselassum=val.count;
                            }
                        })
                    onlineseries.push(onlineselassum);
                    this.salesoffline.map(val=>{
                            if(v==val.days){
                                offlineselassum=val.count;
                            }
                        })
                    offlineseries.push(offlineselassum);
                    this.salesgoods.map(val=>{
                            if(v==val.days){
                                goodssum=val.count;
                            }
                        })
                    goodsseries.push(goodssum);
                    this.salesonlinegoods.map(val=>{
                            if(v==val.days){
                                goodsonlinesum=val.count;
                            }
                        })
                    goodsonlineseries.push(goodsonlinesum);
                    this.salesofflinegoods.map(val=>{
                            if(v==val.days){
                                goodsofflinesum=val.count
                            }
                        })
                    goodsofflineseries.push(goodsofflinesum)
                 })
                 return {
                     xAxis:dateArr,
                     series:series,
                     onlineseries:onlineseries,
                     offlineseries:offlineseries,
                     goodsseries:goodsseries,
                     goodsonlineseries:goodsonlineseries,
                     goodsofflineseries:goodsofflineseries
                 }
            },
        goodsxiaoliang(){
            var seriesData=[],legendData=[],selected={};
            this.allsalesgoods.map(val=>{
                legendData.push(val.goods_name);
                seriesData.push({
                     name: val.goods_name,
                  value: val.count
                })
            }

            )
            var data={
                     legendData:legendData,
                     selected:selected,
                     seriesData:seriesData,
                 }
            return data
        }
    },
    methods:{
        getgoodssales(){
            console.log(this.goods.goods_id)
            this.goodssales();
            this.goodsonlinesales();
            this.goodsofflinesales();
        },
        searchsales(){
                 axios.get("http://localhost:3333/admin/searchsales").then(
                response=>{
                    if(response.data.code==0){
                        this.sales=response.data.result;
                       this.drawLine('chart')
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
            },
        searchsalesoffline(){
                 axios.get("http://localhost:3333/admin/searchsalesoffline").then(
                response=>{
                    if(response.data.code==0){
                        this.salesoffline=response.data.result;
                       this.drawLine('chart')
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
                        this.drawLine('chart')
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
            },
        goodssales(){
             axios.post("http://localhost:3333/admin/goodssales",{
                 goods_id:this.goods.goods_id
             }).then(
                response=>{
                    if(response.data.code==0){
                        this.salesgoods=response.data.result;
                        this.drawLine1('chart1')
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
        },
        goodsonlinesales(){
             axios.post("http://localhost:3333/admin/goodsonlinesales",{
                 goods_id:this.goods.goods_id
             }).then(
                response=>{
                    if(response.data.code==0){
                        this.salesonlinegoods=response.data.result;
                        this.drawLine1('chart1')
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
        },
        goodsofflinesales(){
             axios.post("http://localhost:3333/admin/goodsofflinesales",{
                 goods_id:this.goods.goods_id
             }).then(
                response=>{
                    if(response.data.code==0){
                        this.salesofflinegoods=response.data.result;
                        this.drawLine1('chart1')
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
        },
        allgoodssales(){
             axios.get("http://localhost:3333/admin/allgoodssales").then(
                response=>{
                    if(response.data.code==0){
                        this.allsalesgoods=response.data.result;
                        this.drawPie('chart2')
                    }else{
                        console.log('获取失败')
                    }
                },
                response=>{
                    console.log("error:"+response)
                }
            )
        },
        drawLine(id){
               this.charts = echarts.init(document.getElementById(id))
               this.charts.setOption({
                    title: {
                        text: '最近七天订单变化',
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['总订单量','线上订单','线下订单']
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
                        name:'总订单量',
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
                        name:'线上订单',
                        type:'line',
                        data:this.xiaoliang.onlineseries,
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
                    },{
                        name:'线下订单',
                        type:'line',
                        data:this.xiaoliang.offlineseries,
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
            },
            drawLine1(id){
               this.charts = echarts.init(document.getElementById(id))
               this.charts.setOption({
                   title: {
                        text: '最近七天'+this.goods.goods_name+'销量变化',
                    },
                 tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data:['总销售量','线上销售量','线下销售量']
                    },
                    toolbox: {
                        show: true,
                        feature: {
                            dataZoom: {
                                yAxisIndex: 'none'
                            },
                            dataView: {readOnly: false},
                            magicType: {type: ['line', 'bar']},
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
                        data:this.xiaoliang.goodsseries,
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
                        name:'线上销售量',
                        type:'line',
                        data:this.xiaoliang.goodsonlineseries,
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
                        name:'线下销售量',
                        type:'line',
                        data:this.xiaoliang.goodsofflineseries,
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
                    }
                ]
               })
            },
        drawPie(id){
            this.charts = echarts.init(document.getElementById(id))
            this.charts.setOption({
                title: {
                    text: '商品销量统计',
                    subtext: '',
                    x:'center'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    type: 'scroll',
                    orient: 'vertical',
                    right: 10,
                    top: 20,
                    bottom: 20,
                    data: this.goodsxiaoliang.legendData,
                    selected: this.goodsxiaoliang.selected
                },
                series : [
                    {
                        name: '商品名',
                        type: 'pie',
                        radius : '55%',
                        center: ['40%', '50%'],
                        data: this.goodsxiaoliang.seriesData,
                        itemStyle: {
                            emphasis: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            })
        }  
    }
}
</script>
<style scoped>
.ordercharts{
    height: 500px;
    border: 1px solid #ccc
}
.chart{
    height: 500px;
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
</style>
