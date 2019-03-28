<template>
    <div class="payfor">
        <div>
            是否需要发票：<input type="radio" name="radio" value="1" v-model="isinvoice">是
                        <input type="radio" name="radio" value="0" checked="checked" v-model="isinvoice">否
        </div>
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
            isinvoice:0,
            order_id:this.$route.query.order_id,
            invoice_id:'',
            cart_id:'',
            zhihu:''
        }
    },
    created() {
        this.zhihu=localStorage.getItem('zhihu')
         axios.get("http://localhost:3333/api").then(response=>{
                    if(response.data.code=='0'){
                        this.user_id=response.data.user.user_id
                        axios.post('http://localhost:3333/main/getcart',{
                            user_id:this.user_id,
                            }).then(response=>{
                                if(response.data.code==0){
                                    console.log(response.data)
                                    this.cart_id=response.data.cart[0].cart_id;
                                }else{
                                    console.log("获取失败")
                                }
                            },response=>{
                                console.log("error:"+response)
                        })
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
                            pay_channel:this.zhihu
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
                            pay_channel:this.zhihu
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
