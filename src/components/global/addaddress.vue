<template>
        <div class="addaddressbox">
                 <ul>
                    <li>
                        <label for="name">收件人姓名：</label>
                        <input type="text" name="name" placeholder="输入姓名" v-model="addressee">
                    </li>
                     <li>
                        <label for="address">收件人地址：</label>
                         <v-distpicker :placeholders="placeholders" @selected="onSelected"></v-distpicker>
                         <label for="address">详细地址：</label>
                         <input type="text" name="address" placeholder="请输入详细地址" v-model="street">
                    </li>
                   <li>
                        <label for="postcode">邮政编码：</label>
                         <input type="text" name="postcode" placeholder="邮政编码" v-model="zip_code">
                    </li>
                    <li>
                        <label for="suppliertel">联系电话：</label>
                        <input name="suppliertel" placeholder="商家电话"  v-model="tel">
                    </li>
                     <li>
                        <label for="suppliertel">备用电话：</label>
                        <input name="suppliertel" placeholder="商家电话"  v-model="tel2">
                    </li>
                </ul>
            <button @click="addaddress">添加</button>
            <Tips v-if="showtips" :tips='tips'></Tips>
        </div>
</template>
<script>
import VDistpicker from 'v-distpicker'
import Tips from "@/components/Communal/tips"
import {mapGetters} from "vuex"
import axios from 'axios'
export default {
    props:{
        id:''
    },
    data() {
        return {
            selected:'请选择类别',
            showtips:false,
            tips:'',
            addressee:'',
            zip_code:'',
            tel:'',
            tel2:'',
            street:'',
            province:'',
            city:'',
            area:'',
            placeholders: {
              province: '------- 省 --------',
              city: '--- 市 ---',
              area: '--- 区 ---',
          }
        }
    },
    created() {
    },
    computed: {
        
    },
    methods: {
        onSelected(data){
           this.province=data.province.value;
           this.city= data.city.value;
           this.area= data.area.value;
        },
        addaddress(){
            console.log(this.id)
            var data={
                user_id:this.id,
                addressee:this.addressee,
                tel:this.tel,
                tel2:this.tel2,
                country:'中国',
                province:this.province,
                city:this.city,
                area:this.area,
                street:this.street,
                zip_code:this.zip_code
            }
            axios.post('http://localhost:3333/main/addaddress',data).then(response=>{
                if(response.data.code==0){
                    this.$emit('closeadd')
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
.iconfont {
  font-family: "iconfont" !important;
  font-size: 24px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.addaddressbox{
    padding: 20px;
    border: 1px solid #ccc;
}

.addaddressbox li{
    line-height: 50px;
    width: 100%;
    min-height: 50px;
}
.addaddressbox li input{
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
.addaddressbox>button{
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 100px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
.close{
    position: relative;
    left: 180px;
    cursor: pointer;
}
.somebtn{
    position: relative;
    top: -50px;
    left: 200px;
    width: 150px;
    height: 50px;
}
.somebtn button{
    margin-left: 10px;
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 100px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
</style>