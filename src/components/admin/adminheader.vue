<template>
    <div class="header">
        <div class="left_box box">
            <span class="logo">商品销售后台管理系统{{userinfo}}</span>
            <i class="edition">1.0</i>
        </div>
        <div class="right_box box">
            <div class="search_box">
                <input type="text" value="" class="search">
                <span class="search_btn">
                    <a><i class="iconfont icon-ren">&#xe60b;</i></a>
                </span>
            </div>
            <div class="message_box">
                <a @click="showNews" :style="{'color':red,'background':white}">
                    <i class="iconfont icon-ren">&#xe8c0;</i>
                    <em class="message_num">5</em>
                </a>
            </div>
            <div class="admin_box">
                <a @click="showAdmin">
                    <img :src="userinfo.user_avatar" alt="portrait" class="portrait">
                    <span>欢迎您，普通管理员</span>
                    <i class="iconfont icon-ren" v-html=other>&#xe665;</i>
                </a>
                <ul class="admin_other" v-show="showadmin">
                        <li @click="close">
                            <router-link :to="{'path':'/admin/userinfo'}">
                                <i class="iconfont icon-ren">&#xe72b;</i>
                                <span>个人信息</span>
                            </router-link>
                        </li>
                        <li>
                            <a>
                                <i class="iconfont icon-ren">&#xe667;</i>
                                <span>系统设置</span>
                            </a>
                        </li>
                        <li>
                            <a>
                                <i class="iconfont icon-ren">&#xe6a1;</i>
                                <span>退出</span>
                            </a>
                        </li>
                    </ul>
            </div>
        </div>
       <transition name="newsbox">
            <div class="news_box" v-show="shownews">
                <div class="news_header">通知消息</div>
                <ul class="news_body">
                    <li>
                        <h5>消息种类</h5>
                        <a class="news_detail">
                            <i class="iconfont icon-ren">&#xe615;</i>
                            <span>你有订单没有处理，请及时处理，点击查看详情。</span>
                        </a>
                    </li>
                    <li>
                        <h5>消息种类</h5>
                        <a class="news_detail">
                            <i class="iconfont icon-ren">&#xe615;</i>
                            <span>你有订单没有处理，请及时处理，点击查看详情。</span>
                        </a>
                    </li>
                    <li>
                        <h5>消息种类</h5>
                        <a class="news_detail">
                            <i class="iconfont icon-ren">&#xe615;</i>
                            <span>你有订单没有处理，请及时处理，点击查看详情。</span>
                        </a>
                    </li>
                    <li>
                        <h5>消息种类</h5>
                        <a class="news_detail">
                            <i class="iconfont icon-ren">&#xe615;</i>
                            <span>你有订单没有处理，请及时处理，点击查看详情。</span>
                        </a>
                    </li>
                </ul>
            </div>
       </transition>
    </div>
</template>
<script>
import {mapGetters} from 'vuex'
export default {
    name:'AdminHeader',
    props:{
        user:{}
    },
    data(){
        return {
            shownews:false,
            showadmin:false,
            other:'&#xe665;',
            red:"#fff",
            white:"#666",
        }
    },
    created() {
        this.$store.dispatch('getUserInfo')
    },
    computed: {
        ...mapGetters(['userinfo'])
    },
    methods: {
        showNews(){
            this.shownews=!this.shownews;
            if(this.red=='#fff'&&this.white=='#666'){
            this.red='red';
            this.white='#fff'
            }else{
                this.red='#fff'
                this.white='#666'
            }
        },
        showAdmin(){
            this.showadmin=!this.showadmin;
            if(this.other=='&#xe666'){
                this.other='&#xe665'
            }else{
                this.other='&#xe666'
            }
        },
        close(){
             this.showadmin=false;
            this.other='&#xe665'
        }
    },
}
</script>
<style scoped>
.newsbox-enter,
.newsbox-leave-to{
    transform: translateX(300px);
    opacity: 0;
}
.newsbox-enter-active {
  transition: all .3s ease;
}
.newsbox-leave-active {
  transition: all .8s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}
.iconfont {
  font-family: "iconfont" !important;
  font-size: 24px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.red{
    background-color:#fff;
    color: red;
}
.header{
    width: 100%;
    height: 70px;
    background-color: #000;
}
.box{
    width: 500px;
    height: 70px;
}
.left_box{
    float: left;
}
.right_box{
    float: right;
}
.edition,
.logo{
    margin-left: 30px;
    font-size: 30px;
    color: #fff;
    font-weight: 400;
    line-height: 70px;

}
.search_box{
    line-height: 70px;
    display: inline-block;
    width: 250px;
    height: 70px;
}
.search_btn{
    float: left;
    margin-top: 16px;
    display: block;
    border-left: 1px solid #dddddd;
    width: 35px;
    height: 38px;
    text-align: center;
    line-height: 38px;
    cursor: pointer;
    background: -moz-linear-gradient(top, #ffffff, #ededed);
    background: -o-linear-gradient(top,#ffffff, #ededed);
    background: -webkit-gradient(linear, 0% 0%, 0% 100%, from(#ffffff), to(#ededed));
}
.search{
    outline: none;
    margin-top: 16px;
    display:block;
    float: left;
    background-color: #ffffff;
    border: 1px solid transparent;
    height: 36px;
    line-height: 38px;
    padding: 0px 5px;
    -webkit-transition: all 0.3s ease-in-out;
    transition: all 0.3s ease-in-out;
    width: 183px;
}
.message_box{
    vertical-align: top;
    clear: both;
    display: inline-block;
    width: 38px;
    height: 70px;
}
.message_box a{
    position: relative;
    margin-top: 16px;
    display: block;
    color: #fff;
    font-size: 30px;
    width: 38px;
    height: 38px;
    text-align: center;
    background-color: #666;
}
.message_box a:hover{
    cursor: pointer;
}
.message_num{
    top: -5px;
    left: -5px;
    position:absolute;
    display: block;
    width: 15px;
    height: 15px;
    color: #fff;
    font-size: 8px;
    border-radius: 50%;
    background-color: red;
}
.admin_box{
    vertical-align: top;
    clear: both;
    display: inline-block;
    width: 190px;
    height: 70px;
}
.admin_box>a{
    display: block;
    margin-top: 16px;
    width: 190px;
    height: 38px;
     line-height: 38px;
    background-color: #666;
}
.admin_box>a:hover{
    cursor: pointer;
}
.portrait{
    display: inline-block;
    margin: 4px;
    width: 30px;
    height: 30px;
    border-radius: 3px;
}
.admin_box>a i,
.admin_box>a span{
    display:inline-block;
    vertical-align: top;
    font-size: 13px;
    font-weight: bold;
    color: #fff;
}
.admin_other{
    position: relative;
    top: 5px;
    width: 188px;
    height: 99px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 2px;
    z-index: 999;
}
.admin_other li a{
    line-height: 33px;
    display: block;
    width: 100%;
    height: 33px;
}
.admin_other li a:hover{
    background-color: #eee;
    cursor: pointer;
}
.admin_other li a i{
    margin-left: 20px;
    font-size: 18px
}
.admin_other li a span{
    font-size: 13px;
    color: #555;
}
.news_box{
    position: absolute;
    right: 0px;
    top: 70px;
    width: 300px;
    max-height: 500px;
    z-index: 99999;
    background: #fff;
    overflow: auto;
    overflow-x: hidden;
    box-shadow: -4px 0px 20px #888888;
}
.news_header{
    text-align: center;
    line-height: 40px;
    color: #ffffff;
    background: #373737;
    border-bottom: 1px solid #494949;
}
.news_body li{
    padding:10px;
    width: 100%;
    height: 71px;
    border-bottom: 1px solid #ccc;
}
.news_body h5{
    font-size: 14px;
    color: #000000;
    margin-bottom: 5px;
}
.news_detail{
    display: block;
    width: 100%;
    height: 51px
}
.news_body li:hover{
    cursor: pointer;
    background-color: #eee;
}
.news_detail i{
    margin-top: 8px;
    display: inline-block;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #5cb85c;
    line-height: 40px;
    text-align: center;
    color: #fff;
}
.news_detail span{
    vertical-align: top;
    display: inline-block;
    font-size: 13px;
    color: #333;
    width: 230px;
    line-height: 25px;
}
</style>
