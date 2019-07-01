<template>
    <div class="warpper">
        <order-detail></order-detail>
    </div>
</template>
<script>
import OrderDetail from "@/components/global/orderdetail";
export default {
  name: "Order",
  data(){
    return {
      user_id:{},
    }
  },
  methods:{
    
  },
  components: {
    OrderDetail
  }
};
</script>

<style scoped>
</style>