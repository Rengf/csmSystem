<template>
    <div class="category">
        <div class="categorybox">
            <div class="addcategory">
                <input type="text" placeholder="输入类名" v-model="goods_type_name">
                <button @click="addcategory">添加</button>
            </div>
            <div class="categorylist">
                <table>
                    <thead>
                        <tr>
                            <th width="30">#</th>
                            <th width="100">商品类名</th>
                            <th width="200">添加时间</th>
                            <th width="80">商品种量</th>
                            <th width="300">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(category,index) in categorylist" :key="index">
                            <td>{{index+1}}</td>
                            <td>{{category.goods_type_name}}</td>
                            <td>{{category.created_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
                            <td>{{category.goods_type_count}}</td>
                            <td><button @click="deletecategory(category.goods_type_id)">删除</button><button>修改</button></td>
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
            goods_type_name:'',
            showtips:false
        }
    },
    created() {
        this.$store.dispatch('getCategoryList');
    },
    computed: {
        ...mapGetters(['categorylist'])
    },
    methods:{
        addcategory(){
            if(this.goods_type_name==''){
                this.tips="商品类名不能为空";
                this.showtips=true;
                setTimeout(() => {
                    this.showtips=false
                }, 2000);
                return;
            }
            axios.post('http://localhost:3333/admin/addcategory',{
                goods_type_name:this.goods_type_name
            }).then(response=>{
                if(response.data.code==0){
                     this.$store.dispatch('getCategoryList');
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
        deletecategory(id){
            axios.post('http://localhost:3333/admin/deletecategory',{
                goods_type_id:id
            }).then(response=>{
                if(response.data.code==0){
                     this.$store.dispatch('getCategoryList');
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
.category{
    position: relative;
    width: 89%;
    left: 11%;
}
.addcategory,
.categorybox{
    padding: 20px;
    border: 1px solid #ccc;
}

.categorylist{
    margin-top: 30px;
    border: 1px solid #ccc;
    padding: 30px;
}

.categorylist table{
    display: block;
    margin-left: 50px;
}


.categorylist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.categorylist th{
    height: 29px;
    line-height: 29px;
    padding: 5px 10px;
    vertical-align: middle;
    border: 1px solid #ddd;
    font-size: 14px;
    color: #666;
    text-align: center;
}
.categorylist td{
    padding: 5px 30px;
    line-height: 30px;
    vertical-align: middle;
    border: 1px solid #ddd;
    color: #666;
    text-align: center;
    font-size: 12px;
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
