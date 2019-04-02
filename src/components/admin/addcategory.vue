<template>
    <div class="addcategory">
        <div class="addcategorybox">
            <input type="text" placeholder="输入类名" v-model="goods_type_name">
            <button @click="addcategory">添加</button>
        </div>
        <Tips v-if="showtips" :tips='tips'></Tips>
    </div>
</template>
<script>
import Tips from "@/components/Communal/tips"
import axios from 'axios'
export default {
    data() {
        return {
            goods_type_name:'',
            showtips:false,
            tips:''
        }
    },
    methods: {
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
                    this.$emit('closeaddcategory')
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
    },
    components:{
        Tips,
    }
}
</script>
<style scoped>
.addcategory{
    position: relative;
    width: 300px;
    padding: 10px;
    border: 1px solid #ccc;
    background: #fff;
    z-index: 999;
}
.addcategory input{
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
.addcategory button{
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 50px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
</style>
