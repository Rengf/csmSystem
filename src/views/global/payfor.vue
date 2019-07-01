<template>
    <div class="payfor">
        <div>
            <button @click="surepayfor">确定付款</button>
        </div>

    </div>
</template>
<script>
import axios  from 'axios'
export default {
    data() {
        return {
            order_id:this.$route.query.order_id,
            goods_id:'',
            user_id:'',
            goods_count:''
        }
    },
    created() {
         axios.get("http://localhost:3333/api").then(response=>{
            if(response.data.code==0){
                this.user_id=response.data.user.user_id;
                axios.post("http://localhost:3333/main/getorderdetail",{
                    user_id:this.user_id,
                    order_id:this.order_id,
                }).then(response=>{
                            if(response.data.code=='0'){
                                this.goods_id=response.data.order.goods_id;
                                this.goods_count=response.data.order.product_count
                                }
                        },response=>{
                            console.log("error:"+response)
                        })
                }else{
                    console.log('获取失败')
                }},
                response=>{
                    console.log("error:"+response)
                })
         
    },
    methods:{
        surepayfor(){ 
                 axios.post("http://localhost:3333/main/updateorder",{
                            order_id:this.order_id,
                            goods_id:this.goods_id,
                            goods_count:this.goods_count
                        }).then(response=>{
                            if(response.data.code==0){
                                console.log(response.data.message);
                                this.$router.push('/index/orderdetail?order_id='+this.order_id)
                            }else{
                                console.log("支付失败")
                            }
                        },response=>{
                            console.log("error:"+response)
                        })
            }
        }
}
</script>
<style scoped>

</style>
