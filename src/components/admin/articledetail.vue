<template>
    <div class="articleDetail">
        <div class="detailMiddle">
            <div class="articleTitle">
                <p>{{article.title}}</p>
            </div>
            <div class="articlemsg">
                <p>
                    <span>作者：{{article.author}}</span>
                    <span>发布时间：{{article.release_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</span>
                </p>
            </div>
            <div class="articleContent">
                <article v-html="article.content">
                </article>
            </div>
        </div>
    </div>
</template>
<script>
import axios from 'axios'
export default {
    name:'articledetail',
    data(){
        return {
            article:{}
        }
    },
    created(){
        var id=this.$route.query.article_id;
        axios.get("http://localhost:3333/admin/getarticle?article_id="+id).then(response => {
                    if (response.data.code == 0) {
                       this.article=response.data.article;
                       console.log(this.article)
                       this.pagedata=response.data.page;
                    } else {
                        alert(response.data.message)
                    }
                },response=>{
                    console.log("失败")
                    console.log('error:'+response);
            });
    },
}
</script>
<style scoped>
.articleDetail{
     box-sizing: border-box;
    border: 1px solid #ddd;
    position: relative;
    width: 100%;
    background: #fff;
    padding: 10px 10px;
}
.detailTop span{
    float: right;
    font-size: 12px;
    color: #666;
    font-weight: normal;
}

.articleTitle{
    text-align: center;
    font-size: 24px;
    font-weight: bold;
    color: #000;
    line-height: 50px;
}
.detailMiddle{
    margin-bottom: 20px;
    padding-bottom: 20px;
}
.articlemsg{
    border-bottom:1px solid #ccc;
}
.articlemsg p{
    width: 100%;
    text-align: center;
}
.articlemsg p span{
    margin: 10px 10px;
    line-height: 50px;
}
</style>
