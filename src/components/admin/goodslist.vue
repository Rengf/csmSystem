<template>
    <div class="goodsbox">
        <div class="goodslistbox">
            <div class="somebtn">
                <button @click="showaddbox">添加商品</button>
            </div>
            <div class="goodslist">
                <table>
                    <thead>
                        <tr>
                            <th width="30">#</th>
                            <th width="100">商品名称</th>
                            <th width="70">商品图片</th>
                            <th width="100">商品价格</th>
                            <th width="100">商品类别</th>
                            <th width="300">商品描述</th>
                            <th width="200">添加时间</th>
                            <th width="80">商品库存</th>
                            <th width="300">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(goods,index) in goodslist" :key="index">
                            <td>{{index+1}}</td>
                            <td>{{goods.goods_name}}</td>
                            <td><img :src="goods.goods_picture"/></td>
                            <td>{{goods.goods_price}}</td>
                            <td>{{goods.goods_type_name}}</td>
                            <td>{{goods.goods_description}}</td>
                            <td>{{goods.addgoods_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
                            <td>{{goods.stock}}</td>
                            <td><button @click="deletegoods(goods.goods_id)">删除</button><button>修改</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <Tips v-if="showtips" :tips='tips'></Tips>
            <add-goods v-if="showaddgoods" @closeaddgoods='close'></add-goods>
            <Background v-if="showaddgoods"></Background>
        </div>
    </div>
</template>
<script>
import Tips from "@/components/Communal/tips"
import AddGoods from "@/components/admin/addgoods"
import Background from "@/components/Communal/background"
import axios from "axios";
import {mapGetters} from "vuex"
export default {
    data(){
        return{
            showaddgoods:false,
            showtips:false,
            tips:''
        }
    },
    created() {
        this.$store.dispatch('getGoodsList');
    },
    computed: {
        ...mapGetters(['categorylist','goodslist'])
    },
    methods:{
         showaddbox(){
            this.showaddgoods=!this.showaddgoods;
        },
        close(){
            this.showaddgoods=false;
        },
        deletegoods(id){
            axios.post('http://localhost:3333/admin/deletegoods',{
                goods_id:id
            }).then(response=>{
                if(response.data.code==0){
                     this.$store.dispatch('getGoodsList');
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
        Tips,
        AddGoods,
        Background
    }
}
</script>
<style scoped>
.goodslistbox{
    padding: 20px;
    border: 1px solid #ccc;
}

.goodslist{
    margin-top: 30px;
    border: 1px solid #ccc;
    padding: 30px;
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

.goodslist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.goodslist th{
    height: 29px;
    line-height: 29px;
    padding: 5px 10px;
    vertical-align: middle;
    border: 1px solid #ddd;
    font-size: 14px;
    color: #666;
    text-align: center;
}
.goodslist td{
    padding: 5px 30px;
    line-height: 30px;
    vertical-align: middle;
    border: 1px solid #ddd;
    color: #666;
    text-align: center;
    font-size: 12px;
}
.goodslist td img{
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
