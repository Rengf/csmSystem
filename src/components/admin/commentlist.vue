<template>
    <div class="comment">
        <div class="commentlistbox">
            <div class="somebtn">
                <button @click="getallcomment()">全部评论</button>
                <search-box @searchmsg="searchcomment"></search-box>
            </div>
            <div class="commentlist">
                <table>
                    <thead>
                        <tr>
                            <th width="30">#</th>
                            <th width="150">评论人</th>
                            <th width="150">评论商品</th>
                            <th width="500">评论内容</th>
                            <th width="300">评论时间</th>
                            <th width="200">操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(comment,index) in commentlist" :key="index">
                            <td>{{index+1}}</td>
                            <td>{{comment.user_name}}</td>
                            <td>{{comment.goods_name}}</td>
                            <td>{{comment.content}}</td>
                            <td>{{comment.comment_time|dateformat('YYYY-MM-DD HH:mm:ss')}}</td>
                            <td>
                                <button @click="delivergoods(comment.comment_id,index)" :disabled="comment.ishandle==1?true:false">处理</button>
                                <button @click="commentdetail(comment.comment_id)">详细</button>
                                <button @click="deletecomment(comment.comment_id)">删除</button>
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
import SearchBox from "@/components/Communal/searchbox"
import axios from 'axios'
import Tips from "@/components/Communal/tips"
export default {
    name:'commentlist',
    data(){
        return{
            showtips:false,
            tips:'',
            condition:'',
            commentlist:[],
        }
    },
    created() {
        axios.get('http://localhost:3333/admin/getcommentlist').then(response=>{
                if(response.data.code==0){
                    console.log(response.data.commentlist)
                    this.tips=response.data.message;
                    this.commentlist=response.data.commentlist;
                    this.showtips=true;
                    setTimeout(() => {
                        this.showtips=false
                    }, 2000);
                }else{
                    console.log("查询失败")
                }
            },
            response=>{
                console.log("error:"+response)
            }
            )
    },
    computed: {
       
    },
    methods: {
        getallcomment(){
            this.$router.push('/admin/commentlist');
            this.condition=this.$route.query;
            this.$store.dispatch('getOrderList',this.condition);
        },
        delivergoods(id,i){
            axios.post('http://localhost:3333/admin/delivergoods',{
                comment_id:id,
                logistics:this.commentlists[i].logistics,
                logistics_fee:this.commentlists[i].logistics_fee,
            }).then(response=>{
                if(response.data.code==0){
                    this.condition=this.$route.query;
                    this.$store.dispatch('getOrderList', this.condition)
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
        deletecomment(id){
           axios.post('http://localhost:3333/admin/deletecomment',{
               comment_id:id
           }).then(
               response=>{
                   if(response.data.code==0){
                       this.$store.dispatch('getOrderList')
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
        commentdetail(id){
            this.$router.push('/admin/commentdetail?comment_id='+id)
        },
        getcomment(way,data){
            this.$router.push('/admin/commentlist?'+way+'='+data);
            this.condition=this.$route.query;
            this.$store.dispatch('getOrderList',this.condition);
        },
         searchcomment(searchmsg){
            axios.post('http://localhost:3333/admin/searchcomment',{
                searchmsg:searchmsg
            }).then(response=>{
                if(response.data.code==0){
                    this.$store.commit(RECEIVE_ORDER_LIST,response.data.commentlist);
                    this.tips=response.data.message;
                    this.showtips=true;
                    setTimeout(() => {
                        this.showtips=false
                    }, 2000);
                }else{
                    console.log("查询失败")
                }
            },
            response=>{
                console.log("error:"+response)
            }
            )
        }
    },
    components:{
        Tips,
        SearchBox
    }
}
</script>
<style scoped>
.commentlist table{
    display: block;
}
.somebtn{
    width: 100%;
    height: 50px;
    bcomment: 1px solid #ccc;
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
.commentlistbox{
    padding: 20px;
    border: 1px solid #ccc;
}
.commentlist{
    margin-top: 30px;
    border: 1px solid #ccc;
    padding: 30px;
}
.commentlist thead>tr{
    color: #707070;
    font-weight: normal;
    background: #f2f2f2;
    background-image: -webkit-gradient(linear,left 0,left 100%,from(#f8f8f8),to(#ececec));
    background-image: -webkit-linear-gradient(top,#f8f8f8,0%,#ececec,100%);
    background-image: -moz-linear-gradient(top,#f8f8f8 0,#ececec 100%);
    background-image: linear-gradient(to bottom,#f8f8f8 0,#ececec 100%);
    background-repeat: repeat-x;
}
.commentlist th{
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
.commentlist td{
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
button:hover{
    cursor: pointer;
}
</style>
