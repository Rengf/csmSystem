<template>
    <div class="addgoods">
        <div class="addgoodsbox">
            <div class="addaddgoods">
                <ul>
                    <li>
                        <label for="goodsname">商品名称：</label>
                        <input type="text" name="goodsname" placeholder="输入商品名" v-model="goods_name">
                    </li>
                    <li>
                        <label for="goodspicture">商品图片：</label>
                        <input type="file" name="goodspicture" value="商品图片" @change="getFile">
                        <img :src="this.goodspicture" alt="">
                    </li>
                    <li>
                        <label for="goodsprice">商品价格：</label>
                        <input type="text" placeholder="商品价格" v-model="goods_price">
                    </li>
                    <li>
                        <label for="goodstype">商品类别：</label>
                        <select name="eidtadmin" v-model="selected">
                            <option value="请选择类别" disabled selected="selected">请选择类别</option>
                            <option :value="category.goods_type_id" v-for="(category,index) in categorylist" :key="index">{{category.goods_type_name}}</option>
                        </select>
                    </li>
                    <li>
                        <label for="goodsdescription">商品描述：</label>
                        <textarea name="goodsdescription"  cols="30" rows="10" v-model="goods_description"></textarea>
                    </li>
                    <li>
                        <label for="stock">商品库存：</label>
                        <input type="text" placeholder="输入商品库存" v-model="stock">
                    </li>
                </ul>
                <button @click="addgoods">添加</button>
            </div>
            <div class="addgoodslist">
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
            goods_name:'',
            goods_price:'',
            selected:'请选择类别',
            goods_description:'',
            stock:'',
            files:[],
            goodspicture:'',
            showtips:false
        }
    },
    created() {
        this.$store.dispatch('getCategoryList');
        this.$store.dispatch('getGoodsList');
    },
    computed: {
        ...mapGetters(['categorylist','goodslist'])
    },
    methods:{
         getFile(e){
           this.files=e.target.files[0]
            var file = e.target.files[0]
		    var reader = new FileReader()
		    var that = this
			reader.readAsDataURL(file)
			reader.onload = function(e) {
				that.goodspicture = this.result
			}
      },
        addgoods(){
            var formData=new FormData();
            formData.append('files',this.files);
            formData.append('goods_name',this.goods_name);
            formData.append('goods_price',this.goods_price);
            formData.append('goods_type_id',this.selected);
            formData.append('goods_description',this.goods_description);
            formData.append('stock',this.stock);
            axios.post('http://localhost:3333/admin/addgoods',formData).then(response=>{
                if(response.data.code==0){
                     this.$store.dispatch('getGoodsList');
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
        Tips
    }
}
</script>
<style scoped>
.addgoods{
    position: relative;
    width: 89%;
    left: 11%;
}
.addaddgoods,
.addgoodsbox{
    padding: 20px;
    border: 1px solid #ccc;
}

.addgoodslist{
    margin-top: 30px;
    border: 1px solid #ccc;
    padding: 30px;
}

.addgoodslist table{
    display: block;
    margin-left: 50px;
}


.addgoodslist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.addgoodslist th{
    height: 29px;
    line-height: 29px;
    padding: 5px 10px;
    vertical-align: middle;
    border: 1px solid #ddd;
    font-size: 14px;
    color: #666;
    text-align: center;
}
.addgoodslist td{
    padding: 5px 30px;
    line-height: 30px;
    vertical-align: middle;
    border: 1px solid #ddd;
    color: #666;
    text-align: center;
    font-size: 12px;
}
.addgoodslist td img{
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
