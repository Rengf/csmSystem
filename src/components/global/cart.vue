<template>
  <div class="cartlist">
    <div class="listheader">
      <ul>
        <li class="name">名称</li>
        <li class="like">价格</li>
        <li class="like">数量</li>
        <li class="like">小计</li>
        <li class="like">操作</li>
      </ul>
    </div>
    <div class="listbody">
      <ul class="shoplist" v-for="(cartlist,index) in cartlist" :key="index">
        <li class="name">
          <div class="choose">
            <input type="checkbox" v-model="checked[index]" @click="handleChecked(index)">
          </div>
          <div class="shopimg">
            <img :src="cartlist.goods_picture" alt="">
          </div>
          <div class="shopname">
            <router-link :to="{path:'/index/goodsdetail',query:{}}"> {{cartlist.goods_name}} </router-link>
          </div>
        </li>
        <li class="like">{{cartlist.goods_price}}</li>
        <li class="like buyNumber">
          <input v-model="cartlist.goods_count" type="text" @change="changecount(index,cartlist.cart_id)">
          <span>
            <i @click='add(index,cartlist.cart_id)'>+</i>
            <i @click='reduce(index,cartlist.cart_id)'>-</i>
          </span>
        </li>
        <li class="like">{{cartlist.goods_price*cartlist.goods_count}}</li>
        <li class="like">
          <a @click="handleremove(cartlist.cart_id)">删除</a>
        </li>
      </ul>
    </div>
    <div class="listfooter">
      <div class="allchoose">
        <input type="checkbox" @click="handleAllChecked()" v-model="allChecked">
        <span>全选</span>
      </div>
      <div class="checktotal">
        <span>支付金额：</span>
        <span class="totalnumber">￥{{pricetotal}}</span>
      </div>
    </div>
    <div class="somebtn">
      <div>
         <router-link to="/">继续购物</router-link>
         <router-link @click="placeorder" to="/placeorder">结算订单</router-link>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import { mapGetters } from "vuex";
export default {
  name: "CarList",
  data() {
    return {
      allChecked:false,
      checked:[],
      subtotal:"",
      checktotal:'0.00',
      user_id:''
    };
  },
  created() {
    axios.get("http://localhost:3333/api").then(response=>{
            if(response.data.code==0){
                this.user_id=response.data.user.user_id;
                this.$store.dispatch('getCartList',this.user_id);
                }else{
                    console.log('获取失败')
                }
        },response=>{
            console.log("error:"+response)
        })
  },
  computed: {
    ...mapGetters(['cartlist']),
    pricetotal() {
      var total = 0;
      for (var i = 0; i < this.cartlist.length; i++) {
        if(this.checked[i]==true){
          total += parseInt(this.cartlist[i].goods_count*this.cartlist[i].goods_price);
        }
      }
      return total;
    },
  },
  mounted() {
  
  },
  methods: {
    changecount(index,id){
      this.updatecart(index,id)
    },
    add(index,id) {
      this.cartlist[index].goods_count++;
      this.updatecart(index,id)
    },
    reduce(index,id) {
      if (this.cartlist[index].goods_count > 1) {
        this.cartlist[index].goods_count--;
        this.updatecart(index,id)
      }
    },
    handleremove(id) {
      axios.post("http://localhost:3333/main/deletecart",{
         cart_id:id
      }).then(
        response=>{
          if(response.data.code==0){
            console.log("删除成功");
            this.$store.dispatch('getCartList',this.user_id);
          }
        },
        response=>{
            console.log("error:")
        },
      )
    },
    handleChecked(index){
      var count=0
      this.checked[index]=!this.checked[index];
      for(var i = 0; i < this.cartlist.length; i++) {
					if(this.checked[i]==true){
            count++
          }
          if(count==this.cartlist.length){
            this.allChecked=true;
          }else{
            this.allChecked=false;
          }
			}
    },
    handleAllChecked() {
				//全选
				if(this.allChecked==false) {
					for(var i = 0; i < this.cartlist.length; i++) {
            this.checked[i]= true;
					}
				} else {  //取消全选
					for(var i = 0; i < this.cartlist.length; i++) {
            this.checked[i] = false;
					}
        }
         this.checked=JSON.parse(JSON.stringify(this.checked));
        this.allChecked = !this.allChecked;
        this.pricetotal;
      },
      updatecart(index,id){
        axios.post("http://localhost:3333/main/updatecart",{
            cart_id:id,
            goods_count:this.cartlist[index].goods_count,
          }).then(
            response=>{
              if(response.data.code==0){
                console.log("更新成功");
              }
            },
            response=>{
                console.log("error:")
            },
          )
      },
      placeorder(){
        //  axios.post("http://localhost:3000/placeorder",{
        //   shop_car_id:id
        // }).then(
        //   response=>{
        //     console.log(response)
        //     if(response.data.code==1){
        //       console.log("删除成功");
        //       this.$emit('getcartlist');
        //     }
        //   },
        //   response=>{
        //       console.log("error:")
        //   },
        // )
      } 
  },
};
</script>
<style scoped>
.cartlist {
  width: 60%;
  margin: 30px auto;
}
.listheader {
  width: 100%;
  height: 29px;
  font-size: 15px;
}
.listheader li {
  display: block;
  float: left;
  line-height: 29px;
}
.name {
  width: 58%;
}
.like {
  width: 10%;
  text-align: center;
}
.shoplist {
  height: 90px;
  width: 100%;
  border-bottom: 1px dashed #969696;
}
.shoplist:hover,
.shoplist:hover a {
  color: #076ce0;
}
.shoplist:hover a {
  cursor: pointer;
}
.listbody li {
  display: block;
  float: left;
  height: 90px;
  line-height: 90px;
}
.name div {
  float: left;
  margin: 0 5px;
  line-height: 90px;
}
.shopimg img {
  width: 60px;
  height: 60px;
  display: block;
  margin-top: 25%;
}
.shopname a {
  color: #333;
}
.buyNumber span {
  position: relative;
  height: 35px;
  display: inline-block;
  line-height: 35px;
}

.buyNumber input {
  width: 20px;
  text-align: center;
  height: 15px;
  font-size: 12px;
}

.buyNumber span > i {
  text-align: center;
  font-size: 10px;
  font-weight: bold;
  position: absolute;
  width: 13px;
  height: 13px;
  display: block;
  line-height: 10px;
  border: 1px solid #aaa;
}

.buyNumber span i:nth-child(1) {
  position: absolute;
  top: 13px;
  left: 0px;
}

.buyNumber span i:nth-child(2) {
  position: absolute;
  top: 30px;
  left: 0px;
}
.buyNumber span i:hover {
  background: #ccc;
  color: #fff;
  cursor: pointer;
}
.listfooter{
  overflow: hidden;
}
.allchoose{
  float: left;
  height: 30px;
  font-size: 13px;
  color: #333;
  font-weight: bold;
  line-height: 30px;
}
.checktotal{
  float: right;
  margin-right:100px;
  height: 30px;
  font-size: 20px;
  color: #333;
  font-weight: bold;
  line-height: 30px;
}
.totalnumber{
  color: #076ce0;
}
.somebtn{
  position: relative;
  width: 100%;
}
.somebtn>div{
  position: absolute;
  width: 200px;
  right: 0;
}
.somebtn a{
  font-size: 14px;
  color: #666;
}
.somebtn a:nth-child(2){
  display:inline-block;
  width: 120px;
  font-weight: bold;
  height: 40px;
  line-height: 40px;
  text-align: center;
  outline: 0;
  font-size: 20px;
  background: #3a8ee6;
  border: 0px;
  color: #fff;
  border-radius: 3px;
}
.somebtn a:hover{
  cursor: pointer;
}
</style>

