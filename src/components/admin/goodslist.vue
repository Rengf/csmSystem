<template>
  <div class="goodsbox">
    <div class="goodslistbox">
      <div class="somebtn">
        <button @click="showaddbox">添加商品</button>
        <search-box @searchmsg="searchgoods"></search-box>
      </div>
      <div class="goodslist">
        <table>
          <thead>
            <tr>
              <th width="30">#</th>
              <th width="100">商品名称</th>
              <th width="70">商品图片</th>
              <th width="100">
                商品价格
                <svg class="icon" @click="sortgoods('goods_price','theicon1')">
                  <use :xlink:href="theicon1" />
                </svg>
              </th>
              <th width="100">
                <select name="eidtadmin" v-model="selected" @change="searchgoods(selected)">
                  <option value="商品类别" selected="selected">商品类别</option>
                  <option
                    :value="category.goods_type_name"
                    v-for="(category,index) in categorylist"
                    :key="index"
                  >{{category.goods_type_name}}</option>
                </select>
              </th>
              <th width="300">商品描述</th>
              <th width="200">
                添加时间
                <svg class="icon" @click="sortgoods('addgoods_time','theicon2')">
                  <use :xlink:href="theicon2" />
                </svg>
              </th>
              <th width="80">商品库存</th>
              <th width="300">操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(goods,index) in goodslist" :key="index">
              <td>{{index+1}}</td>
              <td>{{goods.goods_name}}</td>
              <td>
                <img :src="goods.goods_picture" />
              </td>
              <td>{{goods.goods_price}}</td>
              <td>{{goods.goods_type_name}}</td>
              <td>{{goods.goods_description}}</td>
              <td>{{goods.addgoods_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
              <td>{{goods.stock}}</td>
              <td>
                <button @click="deletegoods(goods.goods_id)">删除</button>
                <button>修改</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <Tips v-if="showtips" :tips="tips"></Tips>
      <add-box @closeadd="showaddbox" v-if="showaddgoods">
        <add-goods></add-goods>
      </add-box>
      <Background v-if="showaddgoods"></Background>
    </div>
  </div>
</template>
<script>
import SearchBox from "@/components/Communal/searchbox";
import Tips from "@/components/Communal/tips";
import AddBox from "@/components/Communal/addbox";
import AddGoods from "@/components/admin/addgoods";
import Background from "@/components/Communal/background";
import axios from "axios";
import { mapGetters } from "vuex";
import { RECEIVE_GOODS_LIST } from "@/store/mutations-types";
export default {
  data() {
    return {
      showaddgoods: false,
      showtips: false,
      tips: "",
      condition: "",
      selected: "商品类别",
      theicon1: "#icon-shangxiajiantou",
      theicon2: "#icon-shangxiajiantou"
    };
  },
  created() {
    this.condition = this.$route.query;
    this.$store.dispatch("getGoodsList", [, this.condition]);
    this.$store.dispatch("getCategoryList");
  },
  computed: {
    ...mapGetters(["categorylist", "goodslist"])
  },
  methods: {
    compare(prop) {
      return function(obj1, obj2) {
        var val1 = parseInt(obj1[prop]);
        var val2 = parseInt(obj2[prop]);
        if (val1 < val2) {
          return -1;
        } else if (val1 > val2) {
          return 1;
        } else {
          return 0;
        }
      };
    },
    sortgoods(mode, theicon) {
      if (theicon == "theicon1") {
        if (this.theicon1 == "#icon-shengxu") {
          this.theicon1 = "#icon-jiangxu";
          this.goodslist.reverse(this.goodslist.sort(this.compare(mode)));
        } else if (this.theicon1 == "#icon-shangxiajiantou") {
          this.theicon1 = "#icon-shengxu";
          this.goodslist.sort(this.compare(mode));
        } else {
          this.theicon1 = "#icon-shangxiajiantou";
          this.$store.dispatch("getGoodsList", [, this.condition]);
        }
      } else {
        if (this.theicon2 == "#icon-shengxu") {
          this.theicon2 = "#icon-jiangxu";
          this.goodslist.reverse(this.goodslist.sort(this.compare(mode)));
        } else if (this.theicon2 == "#icon-shangxiajiantou") {
          this.theicon2 = "#icon-shengxu";
          this.goodslist.sort(this.compare(mode));
        } else {
          this.theicon2 = "#icon-shangxiajiantou";
          this.$store.dispatch("getGoodsList", [, this.condition]);
        }
      }
    },
    showaddbox() {
      this.showaddgoods = !this.showaddgoods;
    },
    close() {
      this.showaddgoods = false;
    },
    deletegoods(id) {
      axios
        .post("http://localhost:3333/admin/deletegoods", {
          goods_id: id
        })
        .then(
          response => {
            if (response.data.code == 0) {
              this.$store.dispatch("getGoodsList", [, this.condition]);
              this.tips = response.data.message;
              this.showtips = true;
              setTimeout(() => {
                this.showtips = false;
              }, 2000);
            } else {
              console.log("删除失败");
            }
          },
          response => {
            console.log("error:" + response);
          }
        );
    },
    searchgoods(searchmsg) {
      if (searchmsg == "商品类别") {
        this.$store.dispatch("getGoodsList", [, this.condition]);
      } else {
        axios
          .post("http://localhost:3333/admin/searchgoods", {
            searchmsg: searchmsg
          })
          .then(
            response => {
              if (response.data.code == 0) {
                this.$store.commit(RECEIVE_GOODS_LIST, response.data.goodslist);
                this.tips = response.data.message;
                this.showtips = true;
                setTimeout(() => {
                  this.showtips = false;
                }, 2000);
              } else {
                console.log("查询失败");
              }
            },
            response => {
              console.log("error:" + response);
            }
          );
      }
    }
  },
  components: {
    Tips,
    AddGoods,
    AddBox,
    Background,
    SearchBox
  }
};
</script>
<style scoped>
.icon {
  width: 1em;
  height: 1em;
  vertical-align: -0.15em;
  fill: currentColor;
  overflow: hidden;
}
.goodslistbox {
  padding: 20px;
  border: 1px solid #ccc;
}

.goodslist {
  margin-top: 30px;
  border: 1px solid #ccc;
  padding: 30px;
}

.somebtn {
  width: 100%;
  height: 50px;
  border: 1px solid #ccc;
}
.somebtn button {
  margin-top: 7px;
  margin-left: 10px;
  color: #fff;
  background: #438eb9 !important;
  border: none;
  width: 100px;
  height: 36px;
  border-radius: 3px;
  cursor: pointer;
}

.goodslist thead > tr {
  color: #707070;
  font-weight: normal;
  background: #f2f2f2;
  background-image: -webkit-gradient(
    linear,
    left 0,
    left 100%,
    from(#f8f8f8),
    to(#ececec)
  );
  background-image: -webkit-linear-gradient(top, #f8f8f8, 0%, #ececec, 100%);
  background-image: -moz-linear-gradient(top, #f8f8f8 0, #ececec 100%);
  background-image: linear-gradient(to bottom, #f8f8f8 0, #ececec 100%);
  background-repeat: repeat-x;
}
.goodslist th {
  height: 29px;
  line-height: 29px;
  padding: 5px 10px;
  vertical-align: middle;
  border: 1px solid #ddd;
  font-size: 14px;
  color: #666;
  text-align: center;
}
.goodslist th select {
  border: none;
  background: #f2f2f2;
  outline: none;
}
.goodslist td {
  padding: 5px 30px;
  line-height: 30px;
  vertical-align: middle;
  border: 1px solid #ddd;
  color: #666;
  text-align: center;
  font-size: 12px;
}
.goodslist td img {
  width: 50px;
  height: 50px;
}
tr:hover {
  background: rgb(174, 241, 253);
}
button {
  margin: 0 5px;
  width: 70px;
  outline: 0;
  background: #3a8ee6;
  border: 0px;
  color: #fff;
  cursor: pointer;
}
</style>
