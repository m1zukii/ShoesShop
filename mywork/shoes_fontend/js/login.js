$('#btLogin').click(function(){
    $('#unameMsg').html('用户名不能为空').addClass('alert-danger')
    let uname=$('#uname').val()
    let upwd=$('#upwd').val()

    $.ajax({
        xhrFields:{withCredentials:true},
        crossDomain: true,
        method:'post',
        url:'http://127.0.0.1:5050/user/login',
        data:`uname=${uname}&upwd=${upwd}`,
        headers:{
            ContentType: 'application/x-www-form-urlencoded'
        },
        success:function(data,msg,xhr){
            if(data.code===403){
                $('#Msg').html('用户名或密码错误').addClass('alert-danger')
            }else{
                $('#Msg').html('').removeClass('alert-danger')
            }
            if(data.code===401){
                $('#unameMsg').html('用户名不能为空').addClass('alert-danger')
            }else{
                $('#unameMsg').html('').removeClass('alert-danger')
            }
            if(data.code===402){
                $('#upwdMsg').html('密码不能为空').addClass('alert-danger')
            }else{
                $('upwd#Msg').html('').removeClass('alert-danger')
            }
            if(data.code===200){
                window.location.href = 'index.html';
            }
        }
    
    })        
 })