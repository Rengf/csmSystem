<template>
    <div class="warpper">
        <order-List></order-List>
    </div>
</template>
<script>
import OrderList from "@/components/global/orderlist";
export default {
  data(){
    return {
      user_id:{},
    }
  },
  methods:{
    
  },
  components: {
    OrderList
  }
};
</script>

<style scoped>
</style>