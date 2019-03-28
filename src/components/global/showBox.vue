<template>
    <div class="siderBarRight">
        <div class="rightHeader">
            <div class="close" @click="handleClose">
                <span>》</span>
            </div>
            <slot name='header' class="title"></slot>
        </div>
    </div>
</template>
<script>
export default {
  name: "ShowBox",
  data() {
    return {
      
    };
  },
  computed:{
     
  },
  methods:{
      handleClose(){
        this.$emit('closeBox')
      }
  }
  
};
</script>
<style scoped>
.siderBarRight {
  width: 280px;
  height: 100%;
  float: left;
  background: #777;
}
.rightHeader {
  width: 100%;
  height: 40px;
  background: #303030;
  color: #ddd;
}
.close {
  margin-left: 10px;
  width: 40px;
  height: 40px;
  line-height: 40px;
  text-align: center;
}
</style>