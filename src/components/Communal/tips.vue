<template>
    <div class="tips">
        {{tips}}
    </div>
</template>
<script>
export default {
    name:'Tips',
    props:{
        tips:''
    }
}
</script>
<style scoped>
    .tips{
        position: fixed;
        width: 200px;
        height: 50px;
        line-height: 50px;
        top: 50%;
        left:50%;
        margin-top: -25px;
        margin-left: -100px;
        border: 1px solid #000;
        border-radius: 5px;
        background: rgba(155, 155, 155, 0.5);
        text-align: center;
        z-index: 99999;
    }
</style>