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
        }
    },
    created() {
         axios.get("http://localhost:3333/api").then(response=>{
                    if(response.data.code=='0'){
                        this.user_id=response.data.user.user_id
                        }
                },response=>{
                    console.log("error:"+response)
                })
    },
    methods:{
        surepayfor(){
            if(this.isinvoice==1){
                axios.post("http://localhost:3333/main/addinvoice",{
                    order_id:this.order_id
                }).then(response=>{
                    if(response.data.code==0){
                        this.invoice_id=response.data.invoice_id;
                        axios.post("http://localhost:3333/main/updateorder",{
                            order_id:this.order_id,
                            invoice_id:this.invoice_id,
                            invoice:'是',
                            cart_id:this.cart_id,
                            pay_channel:this.zhihu,
                            goods_id:this.goods_id,
                            goods_count:this.goods_count
                        }).then(response=>{
                            if(response.data.code==0){
                                console.log(response.data.message)
                            }else{
                                console.log("失败")
                            }
                        },response=>{
                            console.log("error:"+response)
                        })
                    }else{
                        console.log("失败")
                    }
                },
                response=>{
                    console.log("error:"+response)
                })
            }else{
                 axios.post("http://localhost:3333/main/updateorder",{
                            order_id:this.order_id,
                            invoice_id:null,
                            invoice:'否',
                            cart_id:this.cart_id,
                            pay_channel:this.zhihu,
                            goods_count:this.goods_count,
                            goods_id:this.goods_id
                        }).then(response=>{
                            if(response.data.code==0){
                                console.log(response.data.message)
                            }else{
                                console.log("失败")
                            }
                        },response=>{
                            console.log("error:"+response)
                        })
            }
        }
    }
}
</script>
<style scoped>

</style>
