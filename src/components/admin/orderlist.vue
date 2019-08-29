<template>
  <div class="order">
    <div class="orderlistbox">
      <div class="somebtn">
        <button @click="getallorder()">全部订单</button>
        <button @click="getorder('sales_way',1)">线下订单</button>
        <button @click="getorder('sales_way',0)">线上订单</button>
        <button @click="getorder">退货订单</button>
        <search-box @searchmsg="searchorder"></search-box>
      </div>
      <div class="orderlist">
        <table>
          <thead>
            <tr>
              <th width="30">#</th>
              <th width="100">订单号</th>
              <th width="100">客户</th>
              <th width="80">订单状态</th>
              <th width="80">销售途径</th>
              <th width="100">商品</th>
              <th width="30">数量</th>
              <th width="60">产品总价</th>
              <th width="60">支付金额</th>
              <th width="100">快递</th>
              <th width="30">运费</th>
              <th width="30">发票</th>
              <th width="180">收货地址</th>
              <th width="80">支付渠道</th>
              <th width="160">下单时间</th>
              <th width="150">备注</th>
              <th width="200">操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(order,index) in orderlists" :key="index">
              <td>{{index+1}}</td>
              <td>{{order.order_no}}</td>
              <td>{{order.user_name || '线下客户'}}</td>
              <td>{{order.order_status=='0'?'未付款':(order.order_status=='1'?'已付款':(order.order_status==2?'已发货':'其他'))}}</td>
              <td>{{order.sales_way=='0'?'线上购买':'线下购买'}}</td>
              <td>{{order.goods_name}}</td>
              <td>{{order.product_count}}</td>
              <td>{{order.product_amount_total}}</td>
              <td>{{order.order_amount_total}}</td>
              <td>{{order.logistics || '自取'}}</td>
              <td>{{order.logistics_fee||0}}</td>
              <td>{{order.invoice || '否'}}</td>
              <td>{{order.province+order.city+order.area+order.street}}</td>
              <td>{{order.pay_channel}}</td>
              <td>{{order.addorder_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
              <td>{{order.user_remarks}}</td>
              <td>
                <button
                  @click="delivergoods(order.order_id,index)"
                  :disabled="order.order_status==1?false:((order.pay_channel=='货到付款'||order.pay_channel=='线下支付')&&order.order_status==0?false:true)"
                >发货</button>
                <button @click="orderdetail(order.order_id)">详细</button>
                <button @click="deleteorder(order.order_id)">删除</button>
              </td>
            </tr>
          </tbody>
        </table>
        <Pages :total="orderlists.length" @pagechange="pagechange"></Pages>
      </div>
    </div>
    <Tips v-if="showtips" :tips="tips"></Tips>
  </div>
</template>
<script>
import Pages from "@/components/Communal/pages";
import SearchBox from "@/components/Communal/searchbox";
import axios from "axios";
import Tips from "@/components/Communal/tips";
import { mapActions, mapGetters } from "vuex";
import { RECEIVE_ORDER_LIST } from "@/store/mutations-types";
export default {
  name: "orderlist",
  data() {
    return {
      showtips: false,
      tips: "",
      condition: "",
      total: 0
    };
  },
  created() {
    this.condition = this.$route.query;
    this.$store.dispatch("getOrderList", this.condition);
  },
  computed: {
    ...mapGetters({ orderlists: "orderlist" })
  },
  methods: {
    getallorder() {
      this.$router.push("/admin/orderlist");
      this.condition = this.$route.query;
      this.$store.dispatch("getOrderList", this.condition);
    },
    delivergoods(id, i) {
      axios
        .post("http://localhost:3333/admin/delivergoods", {
          order_id: id,
          logistics: this.orderlists[i].logistics,
          logistics_fee: this.orderlists[i].logistics_fee
        })
        .then(
          response => {
            if (response.data.code == 0) {
              this.condition = this.$route.query;
              this.$store.dispatch("getOrderList", this.condition);
              this.tips = response.data.message;
              this.showtips = true;
              setTimeout(() => {
                this.showtips = false;
              }, 2000);
            } else {
              console.log("失败");
            }
          },
          response => {
            console.log("error:" + response);
          }
        );
    },
    deleteorder(id) {
      axios
        .post("http://localhost:3333/admin/deleteorder", {
          order_id: id
        })
        .then(
          response => {
            if (response.data.code == 0) {
              this.$store.dispatch("getOrderList");
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
    orderdetail(id) {
      this.$router.push("/admin/orderdetail?order_id=" + id);
    },
    getorder(way, data) {
      this.$router.push("/admin/orderlist?" + way + "=" + data);
      this.condition = this.$route.query;
      console.log(this.condition)
      this.$store.dispatch("getOrderList", this.condition);
    },
    searchorder(searchmsg) {
      axios
        .post("http://localhost:3333/admin/searchorder", {
          searchmsg: searchmsg
        })
        .then(
          response => {
            if (response.data.code == 0) {
              this.$store.commit(RECEIVE_ORDER_LIST, response.data.orderlist);
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
  },
  components: {
    Tips,
    SearchBox,
    Pages
  }
};
</script>
<style scoped>
.orderlist table {
  display: block;
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
.orderlistbox {
  padding: 20px;
  border: 1px solid #ccc;
}
.orderlist {
  margin-top: 30px;
  border: 1px solid #ccc;
  padding: 30px;
}
.orderlist thead > tr {
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
.orderlist th {
  padding: 5px 5px;
  height: 29px;
  line-height: 29px;
  padding: 5px 0px;
  vertical-align: middle;
  border: 1px solid #ddd;
  font-size: 14px;
  color: #666;
  text-align: center;
}
.orderlist td {
  padding: 5px 5px;
  line-height: 30px;
  vertical-align: middle;
  border: 1px solid #ddd;
  color: #666;
  text-align: center;
  font-size: 12px;
}
tr:hover {
  background: rgb(174, 241, 253);
}
button {
  display: inline-block;
  width: 50px;
  height: 25px;
  outline: 0;
  border: 0px;
  color: #fff;
  border-radius: 5px;
}
button:nth-child(1) {
  background: #21a237;
}
button:nth-child(2) {
  background: #3a8ee6;
}
button:nth-child(3) {
  background: #d15b47;
}
button:hover {
  cursor: pointer;
}
</style>
