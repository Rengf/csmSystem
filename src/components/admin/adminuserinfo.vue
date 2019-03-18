<template>
    <div class="infoModify">
       <div class="messagebox">
           <div class="leftBox">
            <ul class="userMsg">
                <li>
                    <label for="nickname">用户名:</label>
                    <input type="text" :disabled="disabled" v-model="newuser_name" :placeholder="admininfo.user_name" :class="{'showborder':noshow}">
                </li>
                <li>
                    <label for="gender">真实姓名：</label>
                    <input :class="{'showborder':noshow}" v-model="newreal_name" type="text" :disabled="disabled" :placeholder="admininfo.real_name==null?'未实名':admininfo.real_name">
                </li>
                <li>
                    <label for="tel">电话号码：</label>
                    <input :class="{'showborder':noshow}" v-model="newuser_tel" type="text" :disabled="disabled" :placeholder="admininfo.user_tel">
                </li>
                <li>
                    <label for="email">邮箱地址：</label>
                    <input :class="{'showborder':noshow}" v-model="newuser_email" type="text" :disabled="disabled" :placeholder="admininfo.user_email">
                </li>
                <li>
                    <label for="time">注册时间：</label>
                    <input type="text" disabled :value="admininfo.created_time">
                </li>
                <li>
                    <label for="user_type">管理员级别：</label>
                    <input type="text" disabled :value="admininfo.isadmin==0?'普通管理员':'超级管理员'">
                </li>
                <li>
                    <label for="status">上次登录：</label>
                    <input type="text" disabled :value="admininfo.last_login_time">
                </li>
            </ul>
            <div class="btn">
                <span @click="showEdit">修改信息</span>
                <span @click="showeditpwd">修改密码</span>
                <span v-if="noshow" @click="suremodify">保存修改</span>
            </div>
       </div>
       <div class="rightBox">
           <div class="avatar">
               <img :src="admininfo.user_avatar" alt="头像" v-if="editavatar">
               <img :src="newavatar" alt="新头像" v-else>
           </div>
           <div class="editavatar" v-if="noshow">
               <input type="file" name="avatar" value="修改头像" @change="getFile">
           </div>
       </div>
       </div>
       <div class="editpwd" v-if="showpwd">
           <div class="editpwdheader">
               <span>修改密码</span>
               <span class="close" @click="close">C</span>
           </div>
           <div class="editpwdbody">
               <ul>
                    <li>
                        <label for="oldpassword">原密码:</label>
                        <input name="oldpassword" type="password" v-model="oldpassword" >
                    </li>
                     <li>
                        <label for="newpassword">新密码:</label>
                        <input name="newpassword" type="password" v-model="newpassword" >
                    </li>
                     <li>
                        <label for="surepassword">确认密码:</label>
                        <input  name="surepassword" type="password" v-model="surepassword" >
                    </li>
               </ul>
           </div>
           <div class="eidtpwdbtn">
               <span @click="editsurepwd">确认修改</span>
           </div>
       </div>
       <Tips v-if="showtips" :tips='tips'></Tips>
       <Background v-show="showpwd"></Background>
    </div>
</template>
<script>
import Tips from "@/components/Communal/tips"
import Background from "@/components/Communal/background"
import axios from 'axios'
import {mapGetters} from "vuex"
export default {
    name:'infomodify',
    data(){
        return {
            id:'',
            disabled:true,
            noshow:false,
            files:[],
            image:'',
            newavatar:'',
            editavatar:true,
            newuser_name:'',
            newreal_name:'',
            newuser_tel:'',
            newuser_email:'',
            showtips:false,
            tips:'',
            showpwd:false,
            oldpassword:'',
            newpassword:'',
            surepassword:''
        }
    },
    created(){
        axios.get("http://localhost:3333/api").then(response=>{
            if(response.data.code=='0'){
                this.id=response.data.user.user_id
                this.$store.dispatch('getAdminInfo',this.id)
                }
        },response=>{
            console.log("error:"+response)
        })
    },
    computed: {
        ...mapGetters(['admininfo'])
    },
    methods: {
        editsurepwd(){
            if(this.oldpassword==''){
                this.tips="原密码不能为空";
                return ;
            }
            if(this.newpassword!=this.surepassword){
                this.tips="密码不一致";
                return;
            }
            axios.post("http://localhost:3333/api/updatepassword",{
                oldpassword:this.oldpassword,
                user_password:this.newpassword,
                user_id:this.id
            }).then(response=>{
                if(response.data.code==0){
                     this.showtips=true;
                      this.tips=response.data.message;
                      setTimeout(()=>{
                         this.showtips=false;
                         this.noshow=false;
                         this.disabled=true;
                         this.showpwd=false
                      },3000)
                }else{
                      console.log("修改失败")
                  }
            },
              response=>{
                  console.log("error:"+response)
              })
        },
        close(){
            this.showpwd=false
        },
       showEdit(){
           this.disabled=false;
           this.noshow=true;
       },
       getFile(e){
           this.editavatar=false;
           this.files=e.target.files[0]
            var file = e.target.files[0]
		    var reader = new FileReader()
		    var that = this
			reader.readAsDataURL(file)
			reader.onload = function(e) {
				that.newavatar = this.result
			}
      },
      showeditpwd(){
           this.showpwd=true;
      },
      suremodify(){
          var newavatar=this.admininfo.user_avatar
          if(this.newuser_name==''){
              this.newuser_name=this.admininfo.user_name
          }
          if(this.newreal_name==''){
              this.newreal_name=this.admininfo.real_name
          }
          if(this.newuser_tel==''){
              this.newuser_tel=this.admininfo.user_tel
          }
          if(this.newuser_email==''){
              this.newuser_email=this.admininfo.user_email
          }
          var formData=new FormData();
           if(this.files.length!=0){
              formData.append('files',this.files);
          }else{
              formData.append('files',newavatar);
          }
          formData.append('user_id',this.id);
          formData.append('newuser_name',this.newuser_name);
          formData.append('newreal_name',this.newreal_name);
          formData.append('newuser_tel',this.newuser_tel);
          formData.append('newuser_email',this.newuser_email);
          axios.post("http://localhost:3333/main/updateuserinfo",formData).then(
              response=>{
                  if(response.data.code==0){
                      this.showtips=true;
                      this.tips=response.data.message;
                      setTimeout(()=>{
                         this.showtips=false;
                         this.noshow=false;
                         this.disabled=true;
                      },3000)
                  }else{
                      console.log("失败")
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
        Background
    }
}
</script>
<style scoped>
.infoModify{
    position: relative;
    left: 11%;
    width: 89%;
    background: #fff;
}
.messagebox{
    overflow: hidden;
}
.userMsg li{
    width: 300px;
    height: 50px;
    line-height: 50px;
    display: inline-block;
}
.userMsg li input{
    background-color: #FFF;
    border: 0px;
    border-radius: 0!important;
    color: #666666;
    padding: 5px 5px;
    line-height: 1.2;
    font-size: 14px;
    height: 35px;
    font-family: inherit;
    -webkit-box-shadow: none!important;
    box-shadow: none!important;
    -webkit-transition-duration: .1s;
    transition-duration: .1s;
}
.showborder{
    border: 1px solid #ccc!important;
}
.leftBox{
    height: 200px;
    float: left;
    width: 80%;
    box-sizing: border-box;
    border: 1px solid #ccc;
}
.rightBox{
    box-sizing: border-box;
    border: 1px solid #ccc;
    float: left;
    width: 20%;
    height: 200px;;
}
.avatar img{
    display: block;
    margin: 50px auto 0px;
    width: 100px;
    height: 100px;
    border: none;
}
.btn{
    width: 310px;
    margin: 32px auto;
}
.eidtpwdbtn{
    width: 100%;
}
.eidtpwdbtn span{
    margin: 30px 100px;;
    background: #3a8ee6;
}
.eidtpwdbtn span,
.btn span{
    display: inline-block;
    border-radius: 3px;
    height: 35px;
    width: 100px;
    text-align: center;
    font-size: 14px;
    line-height: 35px;
    outline: 0;
    border: 0px;
    color: #fff;
}
.eidtpwdbtn span:hover,
.btn span:hover{
    cursor: pointer
}
.btn span:nth-child(1){
    background: #e07360
}
.btn span:nth-child(2){
    background: #9cd159
}
.btn span:nth-child(3){
    background: #3a8ee6;
}
.editavatar{
    width: 100px;
    margin: 10px auto;
}

.editpwd{
    position: fixed;
    width: 300px;
    height: 300px;
    border: 1px solid #aaa;
    top: 50%;
    left: 50%;
    margin-top: -150px;
    margin-left: -150px;
    background: #fff;
    z-index: 9999;
}
.editpwdheader{
    width: 100%;
    height: 40px;
    background: #f8f8f8;
}
.editpwdheader span{
    margin-left: 20px;
    font-size: 14px;
    color: #333;
    line-height: 40px;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.close{
    position: relative;
    font-size: 20px;
    left: 170px;
}
.close:hover{
    cursor: pointer;
}

.editpwdbody ul{
    margin-top: 20px;
}
.editpwdbody ul li{
    height: 50px;
    line-height: 50px;
}
.editpwdbody ul label{
    position: relative;
    width: 80px;
    text-align: right;
    color: #666;
    float: left;
    vertical-align: middle;
}
.editpwdbody ul input{
    margin-left: 10px;
    border-radius: 0!important;
    color: #666666;
    background-color: #fff;
    border: 1px solid #c6c6c6;
    padding: 0px 5px;
    line-height: 1.2;
    font-size: 14px;
    height: 25px;
    font-family: inherit;
    -webkit-box-shadow: none!important;
    box-shadow: none!important;
    -webkit-transition-duration: .1s;
    transition-duration: .1s;
    outline: none;
}
</style>