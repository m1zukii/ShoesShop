/**为btRegister按钮添加事件监听**/


      /**失去焦点时进行验证**/

      //验证用户名
      $('#uname').blur(function(){
        let uname=$(this).val()
        if(uname.length<3){
          $('#unameMsg').html('用户名长度太短了').removeClass('alert-info').addClass('alert-danger')
        }else if(uname.length>12){
          $('#unameMsg').html('用户名长度太长了').removeClass('alert-info').addClass('alert-danger')
        }else{
          $('#unameMsg').html('用户名长度合法').removeClass('alert-danger').addClass('alert-info')
        }
      })
      // //如果输入的用户名格式合法，则继续进行服务器端验证
      // $.adjx({
      //   method:'get',
      //   url:'http://127.0.0.1:5050/user/check.uname?uname'+xxx
      //   success:function(data){
      //     data.code====201提示“用户好名已被占用”
      //   }
      // })

      //验证密码
      $('#upwd').blur(function(){
        let upwd=$(this).val()
        if(upwd.length<3){
          $('#upwdMsg').html('密码长度太短了').addClass('alert-danger')
        }else if(uname.length>12){
          $('#upwdMsg').html('密码长度太长了').addClass('alert-danger')
        }else{
          $('#upwdMsg').html('密码长度合法').removeClass('alert-danger').addClass('alert-info')
        }
      })

      $('#btRegister').click(function(){
        //读取所有的表单输入
        let uname=$('#uname').val()
        let upwd=$('#upwd').val()
        let repwd=$('#repwd').val()
        let email=$('#email').val()
        let phone=$('#phone').val()
        //验证表单输入的合法性

        //验证密码的一致性
        if(upwd!=repwd){
          $('#checkpwd').html('两次输入的密码不一致').addClass('alert-danger')
        }else{
          $('#checkpwd').html('').removeClass('alert-danger')
        }
      
        //验证邮箱
        if(email.length==0){
          $('#emailMsg').html('请输入邮箱').addClass('alert-danger')
        }else{
          $('#emailMsg').html('').removeClass('alert-danger')
        }

        //验证手机
        if(phone.length==0){
          $('#phoneMsg').html('请输入电话号码').addClass('alert-danger')
        }else if(phone.length!=11){
          $('#phoneMsg').html('请输入正确的电话号码').addClass('alert-danger')
        }else{
          $('#phoneMsg').html('').removeClass('alert-danger')
        }

        //异步提交用户的输入给后台
        $.ajax({
          xhrFields:{withCredentials:true},
          crossDomain: true,
          method:'post',
          url:'http://127.0.0.1:5050/user/register',
          data:`uname=${uname}&upwd=${upwd}&email=${email}&phone=${phone}`,
          success:function(data,msg,xhr){
            if(data.code===200){
              $('#modalRegisterSucc').modal()
            }else{
              $('#serverErrMsg').html(data.msg)
              $('#modalRegisterErr').modal()
            }
          },
          error:function(xhr,err){
            console.log(xhr)
            console.log(err)
          }
        })
      })

      function registersucc(){
        window.location.href = 'login.html';
      }