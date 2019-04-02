<template>
    <div class="add">
        <div class="addbox">
            <p>
                <span>添加商品</span>
                <i  @click="close" class="iconfont close">&#xe711;</i>
            </p>
            <slot>没有东西</slot>
        </div>
    </div>
</template>
<script>
export default {
    methods: {
        close(){
            this.$emit('closeadd')
        },
    },
}
</script>
<style scoped>
.add{
    position: fixed;
    width: 500px;
    height: 800px;
    top: 50%;
    left: 50%;
    margin-top: -350px;
    margin-left: -250px;
    background: #fff;
    z-index: 9999;
}
p{
    width: 100%;
    height: 50px;
    line-height: 50px;
    font-weight: bold;
    text-align: center;
    background: #efefef;
}
.addbox>button{
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
</style>
