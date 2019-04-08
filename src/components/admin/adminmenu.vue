<template>
    <div class="menu">
        <div class="switch_style">
            <i class="iconfont icon-ren window">&#xe639;</i>
        </div>
        <div class="skin_select">
            <ul>
                <li style="background-color:#222a2d"></li>
                <li style="background-color:#438EB9"></li>
                <li style="background-color:#72B63F"></li>
                <li style="background-color:#41a2ff"></li>
                <li style="background-color:#FF6868"></li>
                <li style="background-color:#6F036B"></li>
            </ul>
        </div>
        <div class="column_list">
            <ul>
                <li v-for="(list,index) of lists" :key="index">
                    <a :title=list.title class="titleUl" @click="showbox(index,lists)">
                        <i class="iconfont icon-ren icon" v-html="list.icon"></i>
                        <span>{{list.title}}</span>
                        <i class="iconfont icon-ren fadown" v-html="list.faup"></i>
                    </a>
                    <ul class="sublist" :class="{'show':index!=nowindex}">
                        <li v-for="(sublist,index) of list.sublists" :key="index">
                            <router-link :title=sublist.title class="subtitleUl" :to="{path:sublist.url}">
                                <i class="box"></i>
                                <i class="iconfont icon-ren subicon" v-html="sublist.icon"></i>
                                <span>{{sublist.title}}</span>
                            </router-link>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</template>
<script>
export default {
    name:'AdminMenu',
    data(){
        return {
            lists:[ {title:'系统首页',icon:'&#xe6ac;',faup:'&#xe638;',sublists:[{title:'首页',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'报表管理',icon:'&#xe636;',faup:'&#xe638;',sublists:[{title:'访问统计',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'管理员',icon:'&#xe63c;',faup:'&#xe638;',sublists:[{title:'管理员列表',icon:'&#xeb0b;',url:'/admin/adminlist'},
                                                                              {title:'管理员设置',icon:'&#xeb0b;',url:'/admin/editadmin'},
                                                                              {title:'管理员信息',icon:'&#xeb0b',url:'/admin/userinfo'}]},
                    {title:'用户管理',icon:'&#xe625;',faup:'&#xe638;',sublists:[{title:'用户列表',icon:'&#xeb0b;',url:'/admin/userlist'},
                                                                                {title:'权限设置',icon:'&#xeb0b;',url:'/admin/editadmin'}]},
                    {title:'文章管理',icon:'&#xe6a7;',faup:'&#xe638;',sublists:[{title:'文章列表',icon:'&#xeb0b;',url:'/admin/articlelist'},
                                                                                {title:'添加文章',icon:'&#xeb0b;',url:'/admin/addarticle'},
                                                                                {title:'草稿列表',icon:'&#xeb0b;',url:'/admin/articlelist?status=0'}]}, 
                    {title:'商品分类',icon:'&#xe639;',faup:'&#xe638;',sublists:[{title:'添加分类',icon:'&#xeb0b;',url:'/admin/addcategory'},
                                                                                {title:'修改分类',icon:'&#xeb0b;',url:'/admin/categorylist'},
                                                                                {title:'删除分类',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'商品管理',icon:'&#xe639;',faup:'&#xe638;',sublists:[{title:'添加商品',icon:'&#xeb0b;',url:'/admin/addgoods'},
                                                                                {title:'修改商品',icon:'&#xeb0b;',url:'/admin/goodslist'},
                                                                                {title:'删除商品',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'进货管理',icon:'&#xe639;',faup:'&#xe638;',sublists:[{title:'进货列表',icon:'&#xeb0b;',url:'/admin/warehousinglist'},
                                                                                {title:'添加进货',icon:'&#xeb0b;',url:'/admin/addwarehousing'},
                                                                                {title:'删除商品',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'供货商家',icon:'&#xe639;',faup:'&#xe638;',sublists:[{title:'添加商家',icon:'&#xeb0b;',url:'/admin/addsupplier'},
                                                                                {title:'商家列表',icon:'&#xeb0b;',url:'/admin/supplierlist'},
                                                                                {title:'删除分类',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'订单管理',icon:'&#xe639;',faup:'&#xe638;',sublists:[{title:'添加订单',icon:'&#xeb0b;',url:'/admin/orderlist'},
                                                                                {title:'管理订单',icon:'&#xeb0b;',url:'/admin'},
                                                                                {title:'订单列表',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'物流管理',icon:'&#xe639;',faup:'&#xe638;',sublists:[{title:'添加物流',icon:'&#xeb0b;',url:'/admin/addgoods'},
                                                                               {title:'修改物流',icon:'&#xeb0b;',url:'/admin'},
                                                                               {title:'物流列表',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'退单管理',icon:'&#xe639;',faup:'&#xe638;',sublists:[{title:'添加退单',icon:'&#xeb0b;',url:'/admin/addgoods'},
                                                                               {title:'修改退单',icon:'&#xeb0b;',url:'/admin'},
                                                                               {title:'退单列表',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'留言管理',icon:'&#xe606;',faup:'&#xe638;',sublists:[{title:'留言反馈',icon:'&#xeb0b;',url:'/admin'},
                                                                                {title:'消息通知',icon:'&#xeb0b;',url:'/admin'}]},
                    {title:'评论管理',icon:'&#xe6ac;',faup:'&#xe638;',sublists:[{title:'评论列表',icon:'&#xeb0b;',url:'/admin/commentlist'},
                                                                                {title:'删除评论',icon:'&#xeb0b;',url:'/admin'}]},],
            nowindex:null,
        }
    },
    methods:{
        showbox(index,lists){
            if(this.nowindex==index){
                this.nowindex=null;
                lists[index].faup='&#xe638;'
            }else{
                this.nowindex = index;
                for(var i=0;i<lists.length;i++){
                    lists[i].faup='&#xe638;'
                }
               lists[index].faup='&#xe669;'
            }
           
        }
    }
}
</script>
<style scoped>
.iconfont {
  font-family: "iconfont" !important;
  font-size: 24px;
  font-style: normal;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.menu{
    position: fixed;
    width: 11%;
    min-height: 100%;
    left: 0;
    background-color: #000;
    margin-top: 70px;
}
.switch_style{
    height: 40px;
    width: 100%;
    background-color: #ddd;
    border-bottom: 1px solid #3E3E3E!important;
}
.window{
  color:#000;
  line-height: 41px;
  display: block;
  margin-left: 20px;
}
.skin_select{
    width: 100%;
    height: 40px;
    background-color: #000;
}
.skin_select ul {
    border-bottom: 1px solid #3E3E3E!important;
    width: 100%;
    height: 39px;
}
.skin_select ul li{
    margin:7px 2px;
    display: inline-block;
    width: 25px;
    height: 25px;
}
.column_list{
    background-color: #000;
}
.column_list>ul {
    width: 100%;
    height: auto;
}
.titleUl{
    position: relative;
    display: block;
    width: 100%;
    height: 45px;
    line-height: 45px;
    font-size: 13px;
    color:#ADADAD;
    border-bottom: 1px solid #3E3E3E!important;
}
.titleUl:hover{
    cursor: pointer;
    text-decoration: underline;
    color: #fff;
}
.icon{
    display: inline-block;
    width: 30px;
    height: 45px;
    font-size: 18px;
}
.fadown{
    position: absolute;
    font-size: 13px;
    display: inline-block;
    right:30px;
}
.show{
    display: none;
}
.subtitleUl{
    display: block;
    width: 100%;
    height: 45px;
    font-size: 13px;
    background-color: #888;
    color: #fff;
    line-height: 45px;
    border-top: 1px dashed#fff;  
}
.subtitleUl:hover{
    cursor: pointer;
    text-decoration: underline;
    background-color: #aaa
}
.sublist li:first-child a{
    border-top: none  
}
.box{
    display: block;
    float: left;
    width: 30px;
    height: 45px;
}
.subicon{
    font-size: 10px;
}
</style>
