$(window).load(function(){
    $.ajax({
        xhrFields:{withCredentials:true},
        crossDomain: true,
        method: 'GET',
        url: 'http://127.0.0.1:5050/user/sessiondata',
        success: function(data){
            let loginid=data.loginid
            if(loginid!=-1){
                $('#mylogin').html('您好，'+data.loginname)
                $('#mylogin').attr('href','user.html')
                $('#myloginspan').html('')
                $('#myregister').html('')
                $('#mycart').attr('href','cart.html')
            }else{
                $('#mylogin').html('登录')
                $('#mylogin').attr('href','login.html')
                $('#myloginspan').html('|')
                $('#myregister').html('注册')
                $('#mycart').attr('href','login.html')
            }
        }
    })
})