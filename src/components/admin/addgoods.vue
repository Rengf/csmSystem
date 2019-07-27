<template>
  <div class="addgoodsbox">
    <ul>
      <li>
        <label for="goodsname">商品名称：</label>
        <input type="text" name="goodsname" placeholder="输入商品名" v-model="goods_name" />
      </li>
      <li>
        <label for="goodspicture">商品图片：</label>
        <input type="file" name="goodspicture" value="商品图片" @change="getFile" />
        <img :src="this.goodspicture" alt />
      </li>
      <li>
        <label for="goodsprice">商品价格：</label>
        <input type="text" placeholder="商品价格" v-model="goods_price" />
      </li>
      <li>
        <label for="goodstype">商品类别：</label>
        <select name="eidtadmin" v-model="selected">
          <option value="请选择类别" disabled selected="selected">请选择类别</option>
          <option
            :value="category.goods_type_id"
            v-for="(category,index) in categorylist"
            :key="index"
          >{{category.goods_type_name}}</option>
        </select>
        <div class="somebtn">
          <button @click="showaddbox">添加分类</button>
          <add-category v-if="showaddcategory" @closeaddcategory="showaddbox()"></add-category>
        </div>
      </li>
      <li>
        <label for="goodsdescription">商品描述：</label>
        <textarea name="goodsdescription" cols="30" rows="10" v-model="goods_description"></textarea>
      </li>
      <li>
        <label for="stock">商品库存：</label>
        <input type="text" placeholder="输入商品库存" v-model="stock" />
      </li>
    </ul>
    <button @click="addgoods">添加</button>
    <Tips v-if="showtips" :tips="tips"></Tips>
  </div>
</template>
<script>
import Tips from "@/components/Communal/tips";
import AddCategory from "@/components/admin/addcategory";
import { mapGetters } from "vuex";
import axios from "axios";
export default {
  data() {
    return {
      goods_name: "",
      goods_price: "",
      selected: "请选择类别",
      goods_description: "",
      stock: "",
      files: [],
      goodspicture: "",
      showtips: false,
      showaddcategory: false,
      tips: ""
    };
  },
  created() {
    this.$store.dispatch("getCategoryList");
  },
  computed: {
    ...mapGetters(["categorylist"])
  },
  methods: {
    showaddbox() {
      this.showaddcategory = !this.showaddcategory;
    },
    getFile(e) {
      this.files = e.target.files[0];
      var file = e.target.files[0];
      var reader = new FileReader();
      var that = this;
      reader.readAsDataURL(file);
      reader.onload = function(e) {
        that.goodspicture = this.result;
      };
    },
    addgoods() {
      var formData = new FormData();
      formData.append("files", this.files);
      formData.append("goods_name", this.goods_name);
      formData.append("goods_price", this.goods_price);
      formData.append("goods_type_id", this.selected);
      formData.append("goods_description", this.goods_description);
      formData.append("stock", this.stock);
      axios.post("http://localhost:3333/admin/addgoods", formData).then(
        response => {
          if (response.data.code == 0) {
            this.$store.dispatch("getGoodsList");
            this.$emit("closeaddgoods");
            this.tips = response.data.message;
            this.showtips = true;
            setTimeout(() => {
              this.showtips = false;
            }, 2000);
          } else {
            console.log("添加失败");
          }
        },
        response => {
          console.log("error:" + response);
        }
      );
    }
  },
  components: {
    Tips,
    AddCategory
  }
};
</script>
<style scoped>
.iconfont {
  font-family: "iconfont" !important;
  font-size: 24px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.addgoods {
  margin-top: 70px;
  box-sizing: border-box;
  border: 1px solid #ddd;
  position: relative;
  left: 11%;
  width: 89%;
  background: #fff;
  padding: 10px 10px;
}
.addgoodsbox {
  padding: 20px;
  border: 1px solid #ccc;
}

.addgoodsbox li {
  line-height: 50px;
  width: 100%;
  min-height: 50px;
}
.addgoodsbox li input {
  width: 220px;
  border-radius: 0 !important;
  color: #666666;
  background-color: #fff;
  border: 1px solid #c6c6c6;
  line-height: 1.2;
  font-size: 14px;
  height: 35px;
  font-family: inherit;
  -webkit-box-shadow: none !important;
  box-shadow: none !important;
  -webkit-transition-duration: 0.1s;
  transition-duration: 0.1s;
}
.addgoodsbox img {
  display: block;
  width: 100px;
  height: 100px;
}
.addgoodsbox > button {
  color: #fff;
  background: #438eb9 !important;
  border: none;
  width: 100px;
  height: 36px;
  border-radius: 3px;
  cursor: pointer;
}
.close {
  position: relative;
  left: 180px;
  cursor: pointer;
}
.somebtn {
  position: relative;
  top: -50px;
  left: 200px;
  width: 150px;
  height: 50px;
}
.somebtn button {
  margin-left: 10px;
  color: #fff;
  background: #438eb9 !important;
  border: none;
  width: 100px;
  height: 36px;
  border-radius: 3px;
  cursor: pointer;
}
</style>
