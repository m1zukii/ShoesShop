$(window).load(function(){
    $.ajax({
        xhrFields:{withCredentials:true},
        crossDomain: true,
        method:'get',
        url:'http://127.0.0.1:5050/user/detail',
        success:function(data,msg,xhr){
            $('#username').attr('value',data.uname)
            $('#userrealname').attr('value',data.user_name)
            if(data.gender==0){
                $('#usergender').attr('value','女')
            }else{
                $('#usergender').attr('value','男')
            }
            $('#useremail').attr('value',data.email)
            $('#userphone').attr('value',data.phone)
            console.log(data.uname)
        },
        error:function(xhr,err){
            console.log(xhr)
            console.log(err)
        }
    })
})

$('#btuser').click(function(){
    let username=$('#username').val()
    let userrealname=$('#userrealname').val()
    let usergender=$('#usergender').val()
    let useremail=$('#useremail').val()
    let userphone=$('#userphone').val()
    $.ajax({
        xhrFields:{withCredentials:true},
        crossDomain: true,
        method:'post',
        url:'http://127.0.0.1:5050/user/update',
        data:`user_name=${userrealname}&gender=${usergender}&email=${useremail}&phone=${userphone}`,
        success:function(data,msg,xhr){
            window.location.href = 'user.html';
        },
        error:function(xhr,err){
            console.log(xhr)
            console.log(err)
        }
    })
})

$('#btloginout').click(function(){
    $.ajax({
        xhrFields:{withCredentials:true},
        crossDomain: true,
        method:'get',
        url:'http://127.0.0.1:5050/user/logout',
        success:function(data,msg,xhr){
            window.location.href = 'index.html';
        },
        error:function(xhr,err){
            console.log(xhr)
            console.log(err)
        }
    })
})