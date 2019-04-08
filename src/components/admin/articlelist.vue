<template>
    <div class="article">
        <div class="articlelistbox">
            <div class="somebtn">
                <button @click="getallarticle()">全部文章</button>
                <button @click="getarticle('status',1)">已发布</button>
                <button @click="getarticle('status',0)">草稿</button>
            </div>
            <div class="articlelist">
                <table>
                    <thead>
                        <tr>
                            <th width="30">#</th>
                            <th width="200">文章标题</th>
                            <th width="500">文章内容</th>
                            <th width="100">作者</th>
                            <th width="100">发布者</th>
                            <th width="180">发布时间</th>
                            <th width="80">发布状态</th>
                            <th width="250">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(article,index) in articlelists" :key="index">
                            <td>{{index+1}}</td>
                            <td><router-link :to="{path:'/admin/articledetail',query:{article_id:article.article_id}}">{{article.title}}</router-link></td>
                            <td><p v-html="article.content.substring(0,1000)"></p></td>
                            <td>{{article.author}}</td>
                            <td>{{article.user_name}}</td>
                            <td>{{article.release_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
                            <td>{{article.status==1?'已发布':'未发布'}}</td>
                            <td>
                                <button @click="releasearticle(article.article_id)" :disabled="article.status==1?true:false">发布</button>
                                <button @click="articledetail(article.article_id)">详细</button>
                                <button @click="updatearticle(article.article_id)">修改</button>
                                <button @click="deletearticle(article.article_id)">删除</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <Tips v-if="showtips" :tips='tips'></Tips>
    </div>
</template>
<script>
import axios from 'axios'
import Tips from "@/components/Communal/tips"
import {mapGetters} from 'vuex'
export default {
    name:'articlelist',
    data(){
        return{
            showtips:false,
            tips:'',
            condition:this.$route.query||'',
        }
    },
    created() {
        this.condition=this.$route.query
        this.$store.dispatch('getArticleList',this.condition)
    },
    watch: {
       $route: {
            handler(newValue, oldValue) {
                this.condition=this.$route.query
                this.$store.dispatch('getArticleList',this.condition)
            }
        }
    },
    computed: {
        ...mapGetters({articlelists:'articlelist'}),
    },
    methods: {
        getallarticle(){
            this.$router.push('/admin/articlelist');
            this.condition=this.$route.query;
            this.$store.dispatch('getArticleList',this.condition);
        },
        releasearticle(id){
            axios.post('http://localhost:3333/admin/releasearticle',{
                article_id:id
            }).then(response=>{
                if(response.data.code==0){
                    this.$store.dispatch('getArticleList',this.condition)
                    this.tips=response.data.message;
                    this.showtips=true;
                    setTimeout(() => {
                        this.showtips=false
                    }, 2000);
                }else{
                    console.log("失败")
                }
            },
            response=>{
                console.log("error:"+response)
            })
        },
        deletearticle(id){
           axios.post('http://localhost:3333/admin/deletearticle',{
               article_id:id
           }).then(
               response=>{
                   if(response.data.code==0){
                       this.$store.dispatch('getArticleList',this.condition)
                        this.tips=response.data.message;
                        this.showtips=true;
                        setTimeout(() => {
                            this.showtips=false
                        }, 2000);
                   }else{
                       console.log("删除失败");
                   }
               },
               response=>{
                   console.log("error:"+response)
               }
           )
        },
        articledetail(id){
            this.$router.push('/admin/articledetail?article_id='+id)
        },
        updatearticle(id){
            this.$router.push('/admin/addarticle?article_id='+id)
        },
        getarticle(way,data){
            this.$router.push('/admin/articlelist?'+way+'='+data);
            this.condition=this.$route.query;
            this.$store.dispatch('getArticleList',this.condition);
        }
    },
    components:{
        Tips
    }
}
</script>
<style scoped>
.articlelist table{
    display: block;
}
.somebtn{
    width: 100%;
    height: 50px;
    border: 1px solid #ccc;
}
.somebtn button{
    margin-top: 7px;
    margin-left: 10px;
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 100px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
.articlelistbox{
    padding: 20px;
    border: 1px solid #ccc;
}
.articlelist{
    margin-top: 30px;
    border: 1px solid #ccc;
    padding: 30px;
}
.articlelist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.articlelist th{
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
.articlelist td{
    padding: 5px 5px;
    line-height: 30px;
    vertical-align: middle;
    border: 1px solid #ddd;
    color: #666;
    text-align: center;
    font-size: 12px;
}
tr:hover{
    background: rgb(174, 241, 253);
}
button{
    display: inline-block;
    width: 50px;
    height: 25px;
    outline: 0;
    border: 0px;
    color: #fff;
    border-radius: 5px;
}
button:nth-child(1){
 background: #21a237;
}
button:nth-child(2){
 background: #3a8ee6;
}
button:nth-child(3){
 background: #d15b47;
}
button:nth-child(4){
 background: #123456;
}
button:hover{
    cursor: pointer;
}
</style>
