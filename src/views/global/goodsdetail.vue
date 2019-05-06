<template>
    <div class="warpper">
        <my-details></my-details>
        <my-comment></my-comment>
    </div>
</template>
<script>
import MyDetails from "../../components/global/goodsdetail";
import MyComment from "../../components/global/comment";
export default {
  name: "GoodsDetail",
  data() {
    return {
      
    };
  },
  components: {
    MyDetails,
    MyComment
  }
};
</script>
<style scoped>
</style>

