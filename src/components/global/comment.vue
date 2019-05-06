<template>
    <div class="comment">
        <div class="editing" v-show="show">
            <input type="textarea" :autosize="{minrow:2}" placeholder="写下你的评论" v-model="commentContent">
            <button @click="onComment">发表评论</button>
        </div>
        <div class="commentList">
            <span>共{{commentlist.length}}条评论</span>
            <div class="commentItem" v-for="(comment,index) in commentlist" :key="index">
                <div class="commentTopbar" @click="showreply(index)">
                    <span class="postMan">{{comment.user_name}}：</span>
                    <span class="comentContent">{{comment.content}}</span>
                </div>
                <div>
                    <span class="postTime">{{comment.comment_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</span>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import axios from "axios";
export default {
    name: "comments",
    data() {
        return {
        commentContent: "",
        userName: "",
        commentlist:[],
        userId:'',
        nowindex:null,
        show:true,
        };
    },
    created() {
           this.getUser();
           this.getComment();
        },
    methods: {
        getUser(){
             axios.get('http://localhost:3333/api').then(
                response=>{
                    if(response.data.code==0){
                        this.userId=response.data.user.user_id;
                        this.userName=response.data.user.user_name;
                        console.log(response.data.message)
                    }
                },
                response=>{
                    console.log(response.message)
                })
        },
        getComment(){
            var goods_id=this.$route.query.goods_id
            axios.post('http://localhost:3333/main/getcommentlist',{
                goods_id:goods_id
            }).then(
                response=>{
                    if(response.data.code==0){
                         this.commentlist=response.data.commentlist;
                         console.log(this.commentlist)
                    }
                },
                response=>{
                    console.log(response.message)
                })
        },
        onComment() {
            var goods_id=this.$route.query.goods_id;
            if(this.userId==""||this.userId==null||this.userId==undefined){
                this.$router.push('/login');
                return;
            }
            axios.post('http://localhost:3333/main/goodscomment',{
                user_id:this.userId,
                goods_id:goods_id,
                content:this.commentContent
            }).then(
                response=>{
                    if(response.data.code==0){
                        console.log("评论成功")
                        this.getComment();
                        this.commentContent=""
                    }else{
                        console.log("评论失败")
                    }
                },
                response=>{
                    console.log("error:"+response.data.message);
                }
            )
        },
         onReply(nickname,commentid) {
            var to_user=nickname;
            var article_id=this.$route.query.id;
            console.log(to_user,"ertwertw"+article_id)
            axios.post('http://localhost:3000/main/comment',{
                commentid:commentid,
                to_user:to_user,
                commenter:this.userName,
                article:article_id,
                comment_content:this.commentContent
            }).then(
                response=>{
                    if(response.data.code==0){
                        console.log("回复成功");
                        this.getComment();
                        this.nowindex=null;
                        this.show=true;
                    }else{
                        console.log("回复失败")
                    }
                },
                response=>{
                    console.log("error:"+response.data.message);
                }
            )
        },
         showreply(index){
            if(this.nowindex==index){
                this.nowindex=null;
                this.show=true;
            }else{
                this.nowindex = index;
                this.show=false;
            }
           
        }
  }
};
</script>
<style scoped>
.show{
    display: none;
}
.comment {
  width: 1200px;
  margin: auto;
}
.warning {
  color: #999;
  font-weight: bold;
}
.editing input {
  width: 80%;
  height: 30px;
  border-radius: 5px;
  padding: 0 10px;
  font-weight: bold;
  color: #999;
}
.editing button {
  height: 30px;
  border-radius: 5px;
  background: #abc;
  font-weight: bold;
}
.editing input:focus,
.editing button:focus {
  outline: none;
}
.postTime,
.postMan {
  color: #8cc6ff;
}
.commentItem{
    margin-top:20px;
    padding-bottom: 20px;
    border-bottom:1px solid #ccc
}
.replyItem{
    margin-left:50px;
    margin-top:10px;
    padding-bottom: 10px;
    border-bottom:1px solid #ccc
}
</style>