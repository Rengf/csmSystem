<template>
    <div class="warehousing">
        <div class="warehousingbox">
            <div class="somebtn">
                <button @click="getallwarehousing">全部进货</button>
                <search-box @searchmsg="searchwarehousing"></search-box>
            </div>
            <div class="warehousinglist">
                <table>
                    <thead>
                        <tr>
                            <th width="30">#</th>
                            <th width="150">进货订单号</th>
                            <th width="170">入库时间</th>
                            <th width="150">商品名称</th>
                            <th width="50">入库数量</th>
                            <th width="50">商品总价格</th>
                            <th width="80">入库负责人</th>
                            <th width="150">供货商家</th>
                            <th width="300">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(warehousing,index) in warehousinglist" :key="index">
                            <td>{{index+1}}</td>
                            <td>{{warehousing.warehousing_order_id}}</td>
                            <td>{{warehousing.warehousing_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
                            <td>{{warehousing.goods_name}}</td>
                            <td>{{warehousing.warehousing_count}}</td>
                            <td>{{warehousing.total_price}}</td>
                            <td>{{warehousing.warehousing_staff}}</td>
                            <td>{{warehousing.supplier_name}}</td>
                            <td><button @click="deletewarehousing(warehousing.warehousing_id)">删除</button><button>修改</button></td>
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
            warehousing_order_id:'',
            warehousing_time:'',
            goods_id:'请选择商品名',
            warehousing_count:'',
            total_price:'',
            warehousing_staff:'',
            supplier:'请选择供应商',
            showtips:false,
            tips:''
        }
    },
    created() {
         this.$store.dispatch('getWarehousingList');
    },
    computed: {
        ...mapGetters(['warehousinglist'])
    },
    methods:{
        deletewarehousing(id){
            axios.post('http://localhost:3333/admin/deletewarehousing',{
                warehousing_id:id
            }).then(response=>{
                if(response.data.code==0){
                     this.$store.dispatch('getWarehousingList');
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
        searchwarehousing(){

        },
        getallwarehousing(){

        }
    },
    components:{
        Tips,
        SearchBox
    }
}
</script>
<style scoped>
.addwarehousing,
.warehousingbox{
    padding: 20px;
    border: 1px solid #ccc;
}

.warehousinglist{
    margin-top: 30px;
    border: 1px solid #ccc;
    padding: 30px;
}

.warehousinglist table{
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

.warehousinglist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.warehousinglist th{
    height: 29px;
    line-height: 29px;
    padding: 5px 10px;
    vertical-align: middle;
    border: 1px solid #ddd;
    font-size: 14px;
    color: #666;
    text-align: center;
}
.warehousinglist td{
    padding: 5px 30px;
    line-height: 30px;
    vertical-align: middle;
    border: 1px solid #ddd;
    color: #666;
    text-align: center;
    font-size: 12px;
}
.warehousinglist td img{
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
