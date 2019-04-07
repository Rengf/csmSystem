<template>
    <div class="editorBox">
        <div class="title">
          <p>
              <label for="title">文章标题：</label>
              <input type="text" name="title" placeholder="输入文章标题" v-model="title">
          </p>
          <p>
              <label for="author">文章作者：</label>
              <input type="text" name="author" placeholder="输入作者" v-model="author">
          </p>
        </div>
        <div :id=id></div>
        <div class="buttonBox" v-if="addarticle">
           <button @click="addArticle">发布</button>
           <button @click="addArticleDraft">保存草稿</button>
        </div>
        <div class="buttonBox" v-else>
           <button @click="updateArticle(articleid)">修改</button>
        </div>
    </div>
</template>
<script>
import axios from "axios"
import {mapGetters} from 'vuex'
  export default {
    name: 'addarticle',
    components:{
    },
    data () {
      return {
        editor: null,
        defaultMsg: "",
        image: "",
        config: {
            initialFrameHeight: 500
        },
        id: "uel",
        articleid:'',
        title:"",
        author:"",
        addarticle:true,
        content:""
        }
    },
    created() {
       this.$store.dispatch('getUserInfo');
    },
    computed: {
        ...mapGetters(['userinfo'])
    },
     mounted() {
      const _this = this;
      this.editor = UE.getEditor(this.id, this.config); // 初始化UE
      this.editor.addListener("ready", function () {
        _this.editor.setContent(_this.defaultMsg); // 确保UE加载完成后，放入内容。
      });
       this.articleid=this.$route.query.id;
      if(this.articleid){
        this.addarticle=false;
        this.getArticleById();
      }
    },
    destroyed() {
      this.editor.destroy();
    },
    methods:{
      getArticleById(){
        console.log("editor:"+this.editor)
            axios.post("http://localhost:3000/admin/articlebyid", {
                    id:this.articleid,
                })
                .then(response => {
                    if (response.data.code == 0) {
                       this.title=response.data.article.title;
                       this.author=response.data.article.author;
                       this.selected=response.data.article.category;
                       this.defaultMsg=response.data.article.content;
                    } else {
                        alert(response.data.message)
                    }
                },response=>{
                    console.log("失败");
                console.log('error:'+response.data.message);
                });
      },
        addArticle() { 
            var data=this.editor.getContent()
            axios.post("http://localhost:3333/admin/addarticle", {
                    content:data,
                    title:this.title,
                    author:this.author,
                    user_id:this.userinfo.user_id,
                    status:1
                })
                .then(response => {
                    if (response.data.code == 0) {
                       console.log('成功')
                    } else {
                        console.log('发布失败')
                    }
                },response=>{
                console.log('error:'+response);
                });
      },
        addArticleDraft(){
          var data=this.editor.getContent()
            axios.post("http://localhost:3000/admin/addarticle", {
                    contetn:data,
                    title:this.title,
                    author:this.author,
                    status:0
                })
                .then(response => {
                    if (response.data.code == 0) {
                       alert("chenggong")
                    } else {
                        alert(response.data.message)
                    }
                },response=>{
                    console.log("失败")
                console.log('error:'+response.data.message);
                });
        },
        updateArticle(id){
          var data=this.editor.getContent()
          var article={
                content:data,
                id:id,
                title:this.title,
                author:this.author,
                category:this.selected,
                status:1,
          }
           axios.post("http://localhost:3000/admin/updatearticle",article).then(
                 response => {
                        if (response.data.code == 0) {
                            alert('修改成功')
                        } else {
                            console.log(response.data.message)
                        }
                    },
                response=>{
                        console.log("失败")
                        console.log('error:'+response);
                })
        }
    }
  }
</script>
<style scoped>
.editorBox{
    box-sizing: border-box;
    border: 1px solid #ddd;
    position: relative;
    width: 100%;
    background: #fff;
    padding: 10px 10px;
}
.title{
    width: 100%;
    border: 1px solid #ccc;
    
}
.title p{
    line-height: 50px;
    width: 100%;
    min-height: 50px;
    text-indent: 30px;
    margin-bottom: 20px;
}
.title p input{
    width: 220px;
    border-radius: 0!important;
    color: #666666;
    background-color: #fff;
    border: 1px solid #c6c6c6;
    line-height: 1.2;
    font-size: 14px;
    height: 35px;
    font-family: inherit;
    -webkit-box-shadow: none!important;
    box-shadow: none!important;
    -webkit-transition-duration: .1s;
    transition-duration: .1s;
}
.buttonBox>button{
    color: #fff;
    background: #438EB9!important;
    border:none;
    width: 100px;
    height: 36px;
    border-radius:3px; 
    cursor: pointer;
}
</style>
