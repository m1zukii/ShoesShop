$(window).load(function(){
    $.ajax({
        xhrFields:{withCredentials:true},
        crossDomain: true,
        method:'post',
        url:'http://127.0.0.1:5050/user/update',
        data:`username=${username}&userrealname=${userrealname}&userprovince=${userprovince}&usercity=${usercity}&usercounty=${usercounty}&useraddress=${useraddress}&userphone=${userphone}&usertelphone=${usertelphone}&useremailid=${useremailid}&userlabel=${userlabel}`,
        success:function(data,msg,xhr){
            console.log('1234567')
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
    let userprovince=$('#userprovince').val()
    let usercity=$('#usercity').val()
    let usercounty=$('#usercounty').val()
    let useraddress=$('#useraddress').val()
    let userphone=$('#userphone').val()
    let usertelphone=$('#usertelphone').val()
    let useremailid=$('#useremailid').val()
    let userlabel=$('#userlabel').val()
    $.ajax({
        xhrFields:{withCredentials:true},
        crossDomain: true,
        method:'post',
        url:'http://127.0.0.1:5050/user/update',
        data:`username=${username}&userrealname=${userrealname}&userprovince=${userprovince}&usercity=${usercity}&usercounty=${usercounty}&useraddress=${useraddress}&userphone=${userphone}&usertelphone=${usertelphone}&useremailid=${useremailid}&userlabel=${userlabel}`,
        success:function(data,msg,xhr){
            console.log('1234567')
        },
        error:function(xhr,err){
            console.log(xhr)
            console.log(err)
        }
    })
})