<template>
       <div class="addsupplier">
                <ul>
                    <li>
                        <label for="suppliername">供应商家名：</label>
                        <input type="text" name="suppliername" placeholder="输入商家名" v-model="supplier_name">
                    </li>
                    <li>
                        <label for="suppliercontact">联系人：</label>
                        <input type="text" name="suppliercontact" placeholder="输入联系人" v-model="supplier_contact">
                    </li>
                    <li>
                        <label for="supplieraddress">商家地址：</label>
                         <v-distpicker :placeholders="placeholders" @selected="onSelected"></v-distpicker>
                         <label for="supplieraddress">详细地址：</label>
                         <input type="text" name="supplieraddress" placeholder="请输入详细地址" v-model="supplier_address">
                    </li>
                    <li>
                        <label for="postcode">邮政编码：</label>
                         <input type="text" name="postcode" placeholder="邮政编码" v-model="supplier_postcode">
                    </li>
                    <li>
                        <label for="suppliertel">商家电话：</label>
                        <input name="suppliertel" placeholder="商家电话"  v-model="supplier_tel">
                    </li>
                     <li>
                        <label for="supplieremail">商家邮箱：</label>
                        <input name="supplieremail" placeholder="商家邮箱"  v-model="supplier_email">
                    </li>
                    <li>
                        <label for="bank">商家开户行：</label>
                        <select name="bank" v-model="bank">
                            <option value="请选择开户行" disabled selected="selected">请选择开户行</option>
                            <option value="建设银行" >建设银行</option>
                            <option value="中国邮政存储银行" >中国邮政存储银行</option>
                            <option value="中国工商银行" >中国工商银行</option>
                            <option value="中国人民银行" >中国人民银行</option>
                            <option value="中国农业银行" >中国农业银行</option>
                            <option value="其他银行" >其他银行</option>
                        </select>
                    </li>
                    <li>
                        <label for="account">银行账户：</label>
                        <input type="text" name="account" placeholder="输入银行账户" v-model="supplier_account">
                    </li>
                </ul>
                <button @click="addsupplier">添加</button>
                <Tips v-if="showtips" :tips='tips'></Tips>
            </div> 
</template>
<script>
import VDistpicker from 'v-distpicker'
import Tips from "@/components/Communal/tips"
import axios from "axios";
export default {
    data() {
        return {
            supplier_name:'',
            supplier_contact:'',
            supplier_address:'',
            supplier_postcode:'',
            supplier_tel:'',
            supplier_email:'',
            supplier_account:'',
            bank:'请选择开户行',
            showtips:false,
            tips:'',
            address:'',
             placeholders: {
              province: '------- 省 --------',
              city: '--- 市 ---',
              area: '--- 区 ---',
          }
        }
    },
    methods:{
        onSelected(data){
            this.address=data.province.value + data.city.value + data.area.value
        },
        addsupplier(){
           var data={
            supplier_name:this.supplier_name,
            supplier_contact:this.supplier_contact,
            supplier_address:this.address+this.supplier_address,
            supplier_postcode:this.supplier_postcode,
            supplier_tel:this.supplier_tel,
            supplier_email:this.supplier_email,
            supplier_bank:this.bank,
            supplier_account:this.supplier_account,
           }
            axios.post('http://localhost:3333/admin/addsupplier',data).then(response=>{
                if(response.data.code==0){
                    this.$store.dispatch('getSupplierList');
                    this.tips=response.data.message;
                    this.showtips=true;
                    setTimeout(() => {
                        this.showtips=false
                    }, 2000);
                }else{
                    console.log("添加失败")
                }
            },
            response=>{
                console.log("error:"+response)
            }
            )
        },
    },
    components:{
        Tips,
        VDistpicker
    }
}
</script>
<style scoped>
.addsupplier{
    padding: 20px;
    border: 1px solid #ccc;
}
.addsupplier li{
    line-height: 50px;
    width: 100%;
    min-height: 50px;
}
.addsupplier li select,
.addsupplier li input{
    width: 220px;
    border-radius: 0!important;
    color: #666666;
    background-color: #fff;
    border: 1px solid #c6c6c6;
    line-height: 1.2;
    font-size: 14px;
    height: 35px;
    font-family: inherit;
    -webkit-box-shadow: none!important;
    box-shadow: none!important;
    -webkit-transition-duration: .1s;
    transition-duration: .1s;
}
.addsupplier>button{
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 100px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
</style>
