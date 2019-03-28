<template>
    <div class="home">
         <div class="homebox">
             <div id="main" style="width: 600px;height: 400px;"></div>
        </div>
    </div>
</template>
<script>
import echarts from 'echarts'
export default {
     data () {
            return {
                charts: '',
            }
        },
        methods:{
            drawPie(id){
               this.charts = echarts.init(document.getElementById(id))
               this.charts.setOption({
                aria: {
                    show: true
                },
                title: {
                    text: '一周商品（类型）销量',
                    x: 'center'
                },
                series: [
                    {
                        name: '商品类型',
                        type: 'pie',
                        data: [
                            { value: 335, name: '直接访问' },
                            { value: 310, name: '邮件营销' },
                            { value: 234, name: '联盟广告' },
                            { value: 135, name: '视频广告' },
                            { value: 1548, name: '搜索引擎' },
                            { value: 456, name: '购物收拾' }
                        ]
                    }
                ]
               })
            }
        },
      //调用
        mounted(){
            this.$nextTick(function() {
                this.drawPie('main')
            })
        }
}
</script>
<style scoped>
.home{
    box-sizing: border-box;
    border: 1px solid #ddd;
    position: relative;
    left: 11%;
    width: 89%;
    background: #fff;
    padding: 10px 10px;
}

.ohomebox{
    padding: 20px;
    border: 1px solid #ccc;
}
</style>
