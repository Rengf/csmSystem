<template>
    <div class="addwarehousing">
        <div class="addwarehousingbox">
                <ul>
                    <li>
                        <label for="orderid">订单号：</label>
                        <input type="text" name="orderid" placeholder="订单号" v-model="warehousing_order_id">
                    </li>
                    <li>
                        <label for="time">入库时间：</label>
                        <input type="datetime-local" name="time" v-model="warehousing_time">
                    </li>
                    <li>
                        <label for="goodsname">商品名称：</label>
                        <select name="goodsname" v-model="goods_id">
                            <option value="请选择商品名" disabled selected="selected">请选择商品名</option>
                            <option :value="goods.goods_id" v-for="(goods,index) in goodslist" :key="index">{{goods.goods_name}}</option>
                        </select>
                        <div class="somebtn">
                            <button @click="showaddbox">添加新商品</button>
                        </div>
                    </li>
                    <li>
                        <label for="goods_count">进货数量：</label>
                        <input name="goods_count" placeholder="输入进货数量"  v-model="warehousing_count">
                    </li>
                    <li>
                        <label for="totalprice">进货支出：</label>
                        <input type="text" name="totalprice" placeholder="输入总价" v-model="total_price">
                    </li>
                     <li>
                        <label for="warehousingstaff">进货负责人：</label>
                        <input type="text" name="warehousingstaff" placeholder="输入负责人姓名" v-model="warehousing_staff">
                    </li>
                     <li>
                        <label for="supplier">供应商：</label>
                        <select name="supplier" v-model="supplier">
                            <option value="请选择供应商" disabled selected="selected">请选择供应商</option>
                            <option :value="supplier.supplier_id" v-for="(supplier,index) in supplierlist" :key="index">{{supplier.supplier_name}}</option>
                        </select>
                        <div class="somebtn">
                            <button @click="showaddsupplier">添加新供货商家</button>
                        </div>
                    </li>
                </ul>
                <button @click="addwarehousing">添加</button>
        </div>
        <Tips v-if="showtips" :tips='tips'></Tips>
        <add-box @closeadd='showaddbox' v-if="showaddgoods">
            <add-goods></add-goods>
        </add-box>
        <add-box @closeadd='showaddsupplier' v-if="showaddsuppliser">
            <add-supplier></add-supplier>
        </add-box>
        <Background v-if="showbackground"></Background>
    </div>
</template>
<script>
import Tips from "@/components/Communal/tips"
import AddBox from "@/components/Communal/addbox"
import AddGoods from "@/components/admin/addgoods"
import AddSupplier from "@/components/admin/addsupplier"
import Background from "@/components/Communal/background"
import axios from "axios";
import {mapGetters} from "vuex"
export default {
    data(){
        return {
            warehousing_order_id:'',
            warehousing_time:'',
            goods_id:'请选择商品名',
            warehousing_count:'',
            total_price:'',
            warehousing_staff:'',
            supplier:'请选择供应商',
            showtips:false,
            tips:'',
            showaddgoods:false,
            showaddsuppliser:false,
            showbackground:false
        }
    },
    created() {
        this.$store.dispatch('getSupplierList');
        this.$store.dispatch('getGoodsList');
    },
    computed: {
        ...mapGetters(['goodslist','supplierlist'])
    },
    methods:{
         showaddbox(){
            this.showaddgoods=!this.showaddgoods;
            this.showbackground=!this.showbackground;
        },
        showaddsupplier(){
            this.showaddsuppliser=!this.showaddsuppliser;
            this.showbackground=!this.showbackground;
        },
        addwarehousing(){
            var data={
                 warehousing_order_id:this.warehousing_order_id,
                warehousing_time:this.warehousing_time,
                goods_id:this.goods_id,
                warehousing_count:this.warehousing_count,
                total_price:this.total_price,
                warehousing_staff:this.warehousing_staff,
                supplier:this.supplier,
            }
            console.log(data)
            axios.post('http://localhost:3333/admin/addwarehousing',data).then(response=>{
                if(response.data.code==0){
                     this.$store.dispatch('getWarehousingList');
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
        AddGoods,
        Background,
        AddBox,
        AddSupplier
    }
}
</script>
<style scoped>
.addwarehousingbox{
    padding: 20px;
    border: 1px solid #ccc;
}
.addwarehousingbox li{
    line-height: 50px;
    width: 100%;
    min-height: 50px;
}
.addwarehousingbox li select,
.addwarehousingbox li input{
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
.addwarehousingbox>button{
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 100px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
.somebtn{
    position: relative;
    top: -50px;
    left: 310px;
    width: 150px;
    height: 50px;
}
.somebtn button{
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 100px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
</style>
