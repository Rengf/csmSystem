<template>
    <div class="supplier">
        <div class="supplierbox">
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
                        <input type="text" name="supplieraddress" placeholder="商家地址" v-model="supplier_address">
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
                        <select name="bank" v-model="selected">
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
            </div>
            <div class="supplierlist">
                <table>
                    <thead>
                        <tr>
                            <th width="30">#</th>
                            <th width="100">供应商家名</th>
                            <th width="70">联系人</th>
                            <th width="300">商家地址</th>
                            <th width="50">邮编</th>
                            <th width="80">商家电话</th>
                            <th width="150">商家邮箱</th>
                            <th width="80">商家银行</th>
                            <th width="200">银行账户</th>
                            <th width="200">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(supplier,index) in supplierlist" :key="index">
                            <td>{{index+1}}</td>
                            <td>{{supplier.supplier_name}}</td>
                            <td>{{supplier.supplier_contact}}</td>
                            <td>{{supplier.supplier_address}}</td>
                            <td>{{supplier.supplier_postcode}}</td>
                            <td>{{supplier.supplier_tel}}</td>
                            <td>{{supplier.supplier_email}}</td>
                            <td>{{supplier.supplier_bank}}</td>
                            <td>{{supplier.supplier_account}}</td>
                            <td><button @click="deletesupplier(supplier.supplier_id)">删除</button><button>修改</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <Tips v-if="showtips" :tips='tips'></Tips>
        </div>
    </div>
</template>
<script>
import Tips from "@/components/Communal/tips"
import axios from "axios";
import {mapGetters} from "vuex"
export default {
    data(){
        return{
            supplier_name:'',
            supplier_contact:'',
            supplier_address:'',
            supplier_postcode:'',
            supplier_tel:'',
            supplier_email:'',
            supplier_account:'',
            selected:'请选择开户行',
            showtips:false,
            tips:''
        }
    },
    created() {
        this.$store.dispatch('getSupplierList');
    },
    computed: {
        ...mapGetters(['supplierlist'])
    },
    methods:{
        addsupplier(){
           var data={
            supplier_name:this.supplier_name,
            supplier_contact:this.supplier_contact,
            supplier_address:this.supplier_address,
            supplier_postcode:this.supplier_postcode,
            supplier_tel:this.supplier_tel,
            supplier_email:this.supplier_email,
            supplier_bank:this.selected,
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
        deletesupplier(id){
            axios.post('http://localhost:3333/admin/deletesupplier',{
                supplier_id:id
            }).then(response=>{
                if(response.data.code==0){
                     this.$store.dispatch('getSupplierList');
                    this.tips=response.data.message;
                    this.showtips=true;
                    setTimeout(() => {
                        this.showtips=false
                    }, 2000);
                }else{
                    console.log("删除失败")
                }
            },
            response=>{
                console.log("error:"+response)
            }
            )
        }
    },
    components:{
        Tips
    }
}
</script>
<style scoped>
.supplier{
    position: relative;
    width: 89%;
    left: 11%;
}
.addsupplier,
.supplierbox{
    padding: 20px;
    border: 1px solid #ccc;
}

.supplierlist{
    margin-top: 30px;
    border: 1px solid #ccc;
    padding: 30px;
}

.supplierlist table{
    display: block;
    margin-left: 50px;
}


.supplierlist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.supplierlist th{
    height: 29px;
    line-height: 29px;
    padding: 5px 10px;
    vertical-align: middle;
    border: 1px solid #ddd;
    font-size: 14px;
    color: #666;
    text-align: center;
}
.supplierlist td{
    padding: 5px 10px;
    line-height: 30px;
    vertical-align: middle;
    border: 1px solid #ddd;
    color: #666;
    text-align: center;
    font-size: 12px;
}
.supplierlist td img{
    width: 50px;
    height: 50px;
}
tr:hover{
    background: rgb(174, 241, 253);
}
button{
    margin:0 5px;
    width: 70px;
    outline: 0;
    background: #3a8ee6;
    border: 0px;
    color: #fff;
}
button:hover{
    cursor: pointer;
}
</style>
