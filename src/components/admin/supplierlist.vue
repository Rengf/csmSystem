<template>
    <div class="supplier">
        <div class="supplierbox">
            <div class="somebtn">
                <button @click="getallsupplier">全部商家</button>
                <search-box @searchmsg="searchsupplier"></search-box>
            </div>
            <div class="supplierlist">
                <table>
                    <thead>
                        <tr>
                            <th width="30">#</th>
                            <th width="100">供应商家名</th>
                            <th width="70">联系人</th>
                            <th width="350">商家地址</th>
                            <th width="50">邮编</th>
                            <th width="80">商家电话</th>
                            <th width="150">商家邮箱</th>
                            <th width="100">商家银行</th>
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
import SearchBox from "@/components/Communal/searchbox"
import Tips from "@/components/Communal/tips"
import axios from "axios";
import {mapGetters} from "vuex"
export default {
    data(){
        return{
            showtips:false,
            tips:'',
        }
    },
    created() {
        this.$store.dispatch('getSupplierList');
    },
    computed: {
        ...mapGetters(['supplierlist'])
    },
    methods:{
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
        },
        getallsupplier(){

        },
        searchsupplier(){

        }
    },
    components:{
        Tips,
        SearchBox
        
    }
}
</script>
<style scoped>
.supplierlist{
    margin-top: 30px;
    border: 1px solid #ccc;
    padding: 30px;
}

.supplierlist table{
    display: block;
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
