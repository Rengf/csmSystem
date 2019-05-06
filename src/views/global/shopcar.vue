<template>
    <div class="warpper">
        <car-list></car-list>
    </div>
</template>
<script>
import CarList from "@/components/global/cart";
export default {
  name: "ShopCar",
  data(){
    return {
      user_id:{},
    }
  },
  methods:{
    
  },
  components: {
    CarList
  }
};
</script>

<style scoped>
</style>
