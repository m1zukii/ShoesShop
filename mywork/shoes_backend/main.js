//Node中无需指定包名package com.tedu.xuezi
//导入其他的包
let mysql=require('mysql')
//使用第三方包提供的函数和对象
//创建数据库连接池
let pool=mysql.createPool({
    host:'127.0.0.1',
    port:'3306',
    user:'root',
    password:'',
    database:'shoes',
    multipleStatements: true,
    connectionLimit:10      //连接池大小限制
})
let cookieParser=require('cookie-parser')
let session=require('express-session')
//导入第三方模块：express，创建基于Node.js的Web服务器
let express=require('express')
//调用第三方模块提供的功能
let server=express()
//运行Web服务器监听特定的端口
let port=5050
server.listen(port,function(){
    console.log('服务器启动成功，正在监听端口：',port)
})
//使用Express提供的中间件：处理POST请求中的主体数据，保存在req.body属性中
server.use(express.urlencoded({
    extended: false     //是否使用扩展工具解析请求主体
}))

//自定义中间件：允许指定客户端的跨域访问
server.use(function(req,res,next){
    // res.set('Access-Control-Allow-Origin','http://127.0.0.1:5500')
    res.set('Access-Control-Allow-Origin','http://127.0.0.1:5500')  //当前服务器允许来自任何客户端的跨域访问
    res.header('Access-Control-Allow-Credentials', true)
    next()  //放行，让后续的请求处理方法继续处理
})

let cors=require('cors')
server.use(cors({
    origin:["http://127.0.0.1:5500","*","http://127.0.0.1:8080","http://localhost:8080"],
    credentials:true
}));

server.use(cookieParser('12345'))
server.use(session({
    secret:'12345',
    cookie: {maxAge:  5*60*1000},
    resave: true,
    saveUninitialized: true
}))


/*************************************************************** */
/***************************后台API***************************** */
/*************************************************************** */



/*
 * API 1.1、商品列表 
*/
server.get('/product/list',function(req,res){
    //接收客户端提交的请求数据
    let pno = parseInt(req.query.pno)
    let pageSize = parseInt(req.query.pageSize)
    if (!pno || pno == NaN || pno < 1) {
        pno = 1
    }
    if (!pageSize || pageSize == NaN || pageSize < 1) {
        pageSize = 9
    }
    let output = {
        recordCount: 0,
        pageSize: pageSize,
        pageCount: 1,
        pno: pno,
        data: []
    }
    let sql = 'SELECT COUNT(*) as "recordCount" FROM shoes_product'
    pool.query(sql, function (err, result) {
        if (err) throw err
        output.recordCount = result[0].recordCount
        if (output.recordCount == 0) {
            res.json(output)
            return
        }
        output.pageCount = Math.ceil(output.recordCount / output.pageSize)
        let sql = 'SELECT pid,title,price,sold_count,is_onsale,pro_img FROM shoes_product limit ?,?'
        let param1 = (output.pno - 1) * output.pageSize
        let param2 = output.pageSize
        pool.query(sql, [param1, param2], function (err, result) {
            if (err) throw err
            if (result.length > 0) {
                output.data = result
                res.json(output)
            } else {
                res.json(output)
            }
        })
    })
})



/*
 * API 1.2、商品详情
*/
server.get('/product/detail',function(req,res){
    //接收客户端提交的请求数据
    let pid=req.query.pid
    if(!pid){
        res.json({})
        return
    }
    let productDetail = {}
    if(req.session.loginUser){
        let mylogin=req.session.loginUser
        productDetail.loginname=mylogin.uname
        productDetail.loginid=mylogin.uid
    }
    let loadedcount = 0
    //查询具体信息
    let select1 = 'select * from shoes_product where pid = ?'
    pool.query(select1, [pid], function (err, result) {
        if (err) throw err
        productDetail.product = result[0]
        loadedcount++
        let bid = result[0].brand_id
        //查询品牌名
        let select2 = 'select * from shoes_brand where bid = ?'
        pool.query(select2, [bid], function (err, result) {
            productDetail.bname = result[0].bname
            loadedcount++
            if (loadedcount == 4) {
                res.json(productDetail)
                return
            }
        })
    })
    //查询图片
    let select3 = 'select * from shoes_pic where product_id = ?'
    pool.query(select3, [pid], function (err, result) {
        if (err) throw err
        productDetail.pic = result
        loadedcount++
        if (loadedcount == 4) {
            res.json(productDetail)
            return
        }
    })
    //查询规格
    let select4 = 'select * from shoes_spec where product_id = ?'
    pool.query(select4, [pid], function (err, result) {
        if (err) throw err
        productDetail.spec = result
        loadedcount++
        if (loadedcount == 4) {
            res.json(productDetail)
            return
        }
    })
})



/*
 * API 1.3、删除商品
*/
server.get('/product/delete',function(req,res){
    let pid = req.query.pid
    if (!pid) {
        res.json({})
        return
    }
    let delete1 = 'delete from shoes_product where pid = ? ;'
    let delete2 = ' delete from shoes_spec where product_id = ? ;'
    let delete3 = ' delete from shoes_pic where product_id = ?; '
    pool.getConnection(function (err, connection) {
        connection.beginTransaction(function (err) {
            if (err) {
                connection.rollback(function () { connection.release() })
            } else {
                connection.query(delete1 + delete2 + delete3, [pid, pid, pid], function (err, result) {
                    if (err) {
                        connection.rollback(function () { connection.release() })
                    }
                    else {
                        if ((result[0].affectedRows == 1) &&
                            (result[1].affectedRows > 0) &&
                            (result[2].affectedRows > 0)) {
                            connection.commit()
                            connection.release()
                            res.json({ code: 200, msg: 'delete success' })
                        }
                        else {
                            connection.rollback(function () { connection.release() })
                            res.json({ code: 201, msg: 'delete fail' })
                        }
                    }
                })
            }
        })
    })
})



/*
 * API 1.4、商品添加 
*/
server.post('/product/add',function(req,res){
    let brand_id = req.body.brand_id
    let title = req.body.title
    let subtitle = req.body.subtitle
    let price = req.body.price
    let promise = req.body.promise
    let pro_img = req.body.pro_img
    let pname = req.body.pname
    let style = req.body.style
    let funct = req.body.funct
    let material_f = req.body.material_f
    let material_h = req.body.material_h
    let element = req.body.element
    let pro_address = req.body.pro_address
    let pro_num = req.body.pro_num
    let target = req.body.target
    let details = req.body.details
    let shelf_time = req.body.shelf_time
    let sold_count = req.body.sold_count
    let is_onsale = req.body.is_onsale
    let insert = 'insert into shoes_product values (NULL,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
    pool.query(insert, [brand_id, title, subtitle, price, promise
        , pro_img, pname, style, funct, material_f, material_h, element, pro_address
        , pro_num, target, details, shelf_time, sold_count, is_onsale], function (err, result) {
            if (err) throw err
            if (result.affectedRows == 1) {
                res.json({ code: 200, msg: 'add success' })
            }
            else {
                res.json({ code: 201, msg: 'add fail' })
            }
    })
})



/*
 * API 1.5、首页数据 
*/
server.get('/index',function(req,res){
    let output={
        carouselItems:[],
        recommendedItems:[],
        newArrialItems:[],
        topSaleItems:[],
        loginname:'',
        loginid:-1
    }
    if(req.session.loginUser){
        let mylogin=req.session.loginUser
        output.loginname=mylogin.uname
        output.loginid=mylogin.uid
    }
    let loadedCount=0   //有几类数据已经加载完成——如果等于4说明四类数据全部加载完成
    //执行数据库查询1：轮播广告条目
    let sql1='SELECT * FROM shoes_index_carousel'
    pool.query(sql1,function(err,result){
        if(err) throw err
        output.carouselItems=result
        loadedCount++
        if(loadedCount===4){    //所有的四类数据全部加载完成
            res.json(output)
        }
    })
    //执行数据库查询2：首页推荐条目
    //let sql2='SELECT pid,title,details,pic,href FROM xz_index_product WHERE seq_recommended BETWEEN 1 AND 6'
    let sql2='SELECT pid,title,details,pic,price,href FROM shoes_index_product WHERE seq_recommended>0 ORDER BY seq_recommended LIMIT 6'
    pool.query(sql2,function(err,result){
        if(err) throw err
        output.recommendedItems=result
        loadedCount++
        if(loadedCount===4){
            res.json(output)
        }
    })
    //执行数据库查询3：热销单品条目
    //let sql3='SELECT pid,title,details,pic,href FROM xz_index_product WHERE seq_top_sale BETWEEN 1 AND 6'
    let sql3='SELECT pid,title,details,pic,href FROM shoes_index_product WHERE seq_top_sale>0 ORDER BY seq_top_sale LIMIT 6'
    pool.query(sql3,function(err,result){
        if(err) throw err
        output.topSaleItems=result
        loadedCount++
        if(loadedCount===4){
            res.json(output)
        }
    })
    //执行数据库查询4：最新上架条目
    //let sql4='SELECT pid,title,details,pic,href FROM xz_index_product WHERE seq_new_arrival BETWEEN 1 AND 6'
    let sql4='SELECT pid,title,details,pic,href FROM shoes_index_product WHERE seq_new_arrival>0 ORDER BY seq_new_arrival LIMIT 6'
    pool.query(sql4,function(err,result){
        if(err) throw err
        output.newArrialItems=result
        loadedCount++
        if(loadedCount===4){
            res.json(output)
        }
    })
})



/*
 * API 2.1、用户注册 
*/
server.post('/user/register',function(req,res){
    //读取客户端提交的请求数据
    let uname=req.body.uname
    let upwd=req.body.upwd
    let email=req.body.email
    let phone=req.body.phone
    if(!uname){
        res.json({code:401,msg:'uname required'})
        return
    }
    if(!upwd){
        res.json({code:402,msg:'upwd required'})
        return
    }
    if(!email){
        res.json({code:403,msg:'email required'})
        return
    }
    if(!phone){
        res.json({code:404,msg:'phone required'})
        return
    }
    //执行数据库操作——SELECT
    let sql1='SELECT uid FROM shoes_user WHERE uname=? OR email=? OR phone=?'
    pool.query(sql1,[uname,email,phone],function(err,result){
        if(err) throw err
        if(result.length>0){
            res.json({code:500,msg:'user already exists'})
            return 
        }
        //执行数据库操作——INSERT
        let sql='INSERT INTO shoes_user(uname,upwd,email,phone) VALUES(?,?,?,?)'
        pool.query(sql,[uname,upwd,email,phone],function(err,result){
            if(err) throw err
            //向客户端输出响应消息——返回数据中附加了新增的用户自增编号
            res.json({code:200,msg:'register successful',uid:result.insertId})
        })
    })
})



/*
 * API 2.2、用户登录
*/
server.post('/user/login',function(req,res){
    //读取客户端提交的请求数据
    let uname=req.body.uname
    let upwd=req.body.upwd
    if(!uname){
        res.json({code:401,msg:'uname required'})
        return
    }
    if(!upwd){
        res.json({code:402,msg:'upwd required'})
        return
    }
    let sql='SELECT * FROM shoes_user WHERE uname=? AND upwd=?'
    pool.query(sql,[uname,upwd],function(err,result){
        if(err) throw err
        if(result.length>0){
            let uid=result[0].uid
            req.session.loginUser={uid:uid,uname:uname,upwd:upwd}
            console.log(req.session.loginUser)
            res.json({code:200,msg:'login successfully'})
        }else{
            res.json({code:403,msg:'uname or upwd failed'})
        }
    })
})



/*
 * API 2.3、用户检索
*/
server.get('/user/detail',function(req,res){
    let uid = req.session.loginUser.uid
    if (!uid) {
        res.json({})
        return
    }
    let sql = 'SELECT uid,uname,email,phone,avatar,user_name,gender FROM shoes_user WHERE uid=?'
    pool.query(sql, [uid], function (err, result) {
        if (err) throw err;
        if (result.length > 0) {
            res.json(result[0])
        } else {
            res.json({})
        }
    })
})



/*
 * API 2.4、删除用户
*/
server.get('/user/delete',function(req,res){
    let uid = req.query.uid
    if (!uid) {
        res.json({ code: 401, msg: 'uid required' })
        return
    }
    let delete1 = 'delete from shoes_user where uid = ?;'
    let delete2 = 'delete from shoes_receiver_address where user_id = ?;'
    let delete3 = 'delete from shoes_shoppingcart_item where user_id = ?;'
    pool.getConnection(function (err, connection) {
        connection.beginTransaction(function (err) {
            if (err) {
                connection.rollback(function () { connection.release() })
            } else {
                connection.query(delete1 + delete2 + delete3, [uid, uid, uid], function (err, result) {
                    if (err) {
                        connection.rollback(function () { connection.release() })
                    }
                    else {
                        if ((result[0].affectedRows == 1)) {
                            connection.commit()
                            connection.release()
                            res.json({ code: 200, msg: 'delete success' })
                        }
                        else {
                            connection.rollback(function () { connection.release() })
                            res.json({ code: 201, msg: 'delete fail' })
                        }
                    }
                })
            }
        })
    })
})



/*
 * API 2.5、修改用户信息
*/
server.post('/user/update', function (req, res) {
    if(!req.session.loginUser){
        res.json({ code: 401, msg: 'uid required' })
        return
    }
    let uid = req.session.loginUser.uid
    let email = req.body.email
    let phone = req.body.phone
    let gender = req.body.gender
    let user_name = req.body.user_name
    if (!uid) {
        res.json({ code: 401, msg: 'uid required' })
        return
    }
    if (!email) {
        res.json({ code: 402, msg: 'email required' })
        return
    }
    if (!phone) {
        res.json({ code: 403, msg: 'phone required' })
        return
    }
    if (!gender) {
        res.json({ code: 404, msg: 'gender required' })
        return
    }
    if (!user_name) {
        res.json({ code: 405, msg: 'user_name required' })
        return
    }
    let sql1 = 'SELECT uid FROM shoes_user WHERE email=? OR phone=?'
    pool.query(sql1, [email, phone], function (err, result) {
        if (err) throw err
        if (result.length > 0&&result[0].uid!=uid) {
            res.json({ code: 500, msg: 'user already exists' })
            return
        }
        let sql2 = 'UPDATE shoes_user SET email=?,phone=?,gender=?,user_name=? WHERE uid=?'
        pool.query(sql2, [email, phone, gender, user_name, uid], function (err, result) {
            if (err) throw err
            if (result.affectedRows == 1) {
                res.json({ code: 200, msg: 'update successfully' })
                console.log('aaaa')
            } else {
                res.json({ code: 501, msg: 'update failed' })
                console.log('bbbbb')
            }
        })
    })
})

server.post('/user/addressupdate',function(req,res){
    if(!req.session.loginUser){
        res.json({ code: 401, msg: 'uid required' })
        return
    }
    let uid = req.session.loginUser.uid
    let username = req.body.username
    let userrealname = req.body.userrealname
    let userprovince = req.body.userprovince
    let usercity = req.body.usercity 
    let usercounty = req.body.usercounty
    let useraddress = req.body.useraddress
    let userphone = req.body.userphone
    let usertelphone = req.body.usertelphone
    let useremailid = req.body.useremailid
    let userlabel = req.body.userlabel
    if (!uid) {
        res.json({ code: 401, msg: 'uid required' })
        return
    }
    let sql2 = 'UPDATE shoes_receiver_address SET username=?,userrealname=?,userprovince=?,usercity=?,usercounty=?,useraddress=?,userphone=?,usertelphone=?,useremailid=?,userlabel=? WHERE uid=?'
    pool.query(sql2, [username, userrealname, userprovince, usercity,usercounty,useraddress,userphone,usertelphone,useremailid,userlabel, uid], function (err, result) {
        if (err) throw err
        if (result.affectedRows == 1) {
            res.json({ code: 200, msg: 'update successfully' })
        } else {
            res.json({ code: 501, msg: 'update failed' })
        }
    })
})



/*
 * API 2.6、用户列表
*/
server.get('/user/list',function(req,res){
    let pno = parseInt(req.query.pno)
    let pageSize = parseInt(req.query.pageSize)
    if (!pno || pno == NaN || pno < 1) {
        pno = 1
    }
    if (!pageSize || pageSize == NaN || pageSize < 1) {
        pageSize = 10
    }
    let output = {
        recordCount: 0,
        pageSize: pageSize,
        pageCount: 1,
        pno: pno,
        data: []
    }
    let sql1 = 'SELECT COUNT(*) as "recordCount" FROM shoes_user'
    pool.query(sql1, function (err, result) {
        if (err) throw err
        output.recordCount = result[0].recordCount
        if (output.recordCount == 0) {
            res.json(output)
            return
        }
        output.pageCount = Math.ceil(output.recordCount / output.pageSize)
        let sql2 = 'SELECT uid,uname,email,phone,avatar,user_name,gender FROM shoes_user LIMIT ?,? '
        let param1 = (output.pno - 1) * output.pageSize
        let param2 = output.pageSize
        pool.query(sql2, [param1, param2], function (err, result) {
            if (err) throw err
            output.data = result
            res.json(output)
        })
    })
})



/*
 * API 2.7、检测邮箱是否存在
*/
server.get('/user/check/email',function(req,res){
    let email = req.query.email
    if (!email) {
        res.json({ code: 401, msg: 'email required' })
        return
    }
    let sql1 = 'SELECT * FROM shoes_user WHERE email=?'
    pool.query(sql1, [email], function (err, result) {
        if (err) throw err
        if (result.length > 0) {
            res.json({ code: 201, msg: 'email exists' })
        } else {
            res.json({ code: 200, msg: 'email non-exists' })
        }
    })
})



/*
 * API 2.8、检测手机是否存在
*/
server.get('/user/check/phone',function(req,res){
    let phone = req.query.phone
    if (!phone) {
        res.json({ code: 401, msg: 'phone required' })
        return
    }
    let sql1 = 'SELECT * FROM shoes_user WHERE phone=?'
    pool.query(sql1, [phone], function (err, result) {
        if (err) throw err
        if (result.length > 0) {
            res.json({ code: 201, msg: 'phone exists' })
        } else {
            res.json({ code: 200, msg: 'phone non-exists' })
        }
    })
})



/*
 * API 2.9、检测用户名是否存在
*/
server.get('/user/check/uname',function(req,res){
    let uname = req.query.uname
    if (!uname) {
        res.json({ code: 401, msg: 'uname required' })
        return
    }
    let sql1 = 'SELECT * FROM shoes_user WHERE uname=?'
    pool.query(sql1, [uname], function (err, result) {
        if (err) throw err
        if (result.length > 0) {
            res.json({ code: 201, msg: 'uname exists' })
        } else {
            res.json({ code: 200, msg: 'uname non-exists' })
        }
    })
})



/*
 * API 2.10、退出登录
*/
server.get('/user/logout',function(req,res){
    req.session.destroy()
    if (typeof (req.session) == "undefined") {
        res.json({ code: 200, msg: 'logout successfully' })
    }
    else {
        res.json({ code: 201, msg: 'logout failed' })
    }
})



/*
 * API 2.11、获取当前用户会话信息
*/
server.get('/user/sessiondata',function(req,res){
    let output={loginid:-1}
    if(req.session.loginUser){
        let mylogin=req.session.loginUser
        output.loginname=mylogin.uname
        console.log('123')
        output.loginid=mylogin.uid
        console.log(output.loginid)
    }
    res.json(output)
})



/*
 * API 3.1、添加购物车购买项
*/
server.get('/cart/item/add', function (req, res) {
    if (typeof (req.session.loginUser) == "undefined") {
        console.log('未登录')
        res.json({})
        return
    }
    let uid = req.session.loginUser.uid
    let specid = parseInt(req.query.specid)
    let buyCount = parseInt(req.query.buyCount)
    let select = 'select * from shoes_shoppingcart_item where user_id = ? and spec_id = ?'
    pool.query(select, [uid, specid], function (err, result) {
        if (err) throw err
        //购物车里已经有 在原来基础上增加
        if (result.length == 1) {
            let beforecount = result[0].count
            let update = `update shoes_shoppingcart_item set
             count = ? where user_id = ? and spec_id = ?`
            pool.query(update, [beforecount + buyCount, uid, specid], function (err, result) {
                if (err) throw err
                if (result.affectedRows == 1) {
                    res.json({ code: 200, msg: 'add success' })
                }
                else {
                    console.log('123456')
                    res.json({ code: 201, msg: 'add fail' })
                }
            })
        }
        //购物车里没有 增加新的条目
        else {
            let insert = `insert into shoes_shoppingcart_item 
            (count,user_id,spec_id,is_checked) values (?,?,?,?)`
            pool.query(insert, [buyCount, uid, specid, 1], function (err, result) {
                if (err) throw err
                if (result.affectedRows == 1) {
                    res.json({ code: 200, msg: 'add success' })
                }
                else {
                    res.json({ code: 201, msg: 'add fail' })
                }
            })
        }
    })
})



/*
 * API 3.2、购物车项列表
*/
server.get('/cart/item/list', function (req, res) {
    if (typeof (req.session.loginUser) == "undefined") {
        console.log('未登录')
        res.json({})
        return
    }
    let uid = req.session.loginUser.uid
    let output = []
    let select = ` select it.spec_id,p.pname,p.price,p.pid,sp.color,sp.size,
    sp.sort_sm,it.count,it.is_checked
    from shoes_shoppingcart_item it,
    shoes_product p,
    shoes_spec sp
    where it.user_id = ?
    and sp.sid = it.spec_id
    and sp.product_id = p.pid `
    pool.query(select, [uid], function (err, result) {
        if (err) throw err
        output = result
        res.json(output)
        return
    })
})



/*
 * API 3.3、删除购物车项
*/
server.get('/cart/item/delete',function(req,res){
    if (typeof (req.session.loginUser) == "undefined") {
        console.log('未登录')
        res.json({})
        return
    }
    let uid = req.session.loginUser.uid
    let specid = parseInt(req.query.specid)
    let deleteSql = `delete from shoes_shoppingcart_item where spec_id = ? and user_id = ?`
    pool.query(deleteSql, [specid, uid], function (err, result) {
        if (err) throw err
        if (result.affectedRows == 1) {
            res.json({ code: 200, msg: 'delete success' })
        }
        else {
            res.json({ code: 201, msg: 'delete fail' })
        }
    })
})



/*
 * API 3.4、修改购物车条目中的购买数量
*/
server.get('/cart/item/updatecount',function(req,res){
    if (typeof (req.session.loginUser) == "undefined") {
        console.log('未登录')
        res.json({})
        return
    }
    let uid = req.session.loginUser.uid
    let specid = parseInt(req.query.specid)
    let buyCount = parseInt(req.query.buyCount)
    let update = 'update shoes_shoppingcart_item set count = ? where user_id = ? and spec_id = ?'
    pool.query(update, [buyCount, uid, specid], function (err, result) {
        if (err) throw err
        if (result.affectedRows == 1) {
            res.json({ code: 200, msg: 'update success' })
        }
        else {
            res.json({ code: 201, msg: 'update fail' })
            console.log('qsc')
        }
    })
})



/*
 * API 3.5、修改购物车条目中的是否勾选
*/
server.get('/cart/item/checked',function(req,res){
    if (typeof (req.session.loginUser) == "undefined") {
        console.log('未登录')
        res.json({})
        return
    }
    let uid = req.session.loginUser.uid
    let specid = parseInt(req.query.specid)
    let checked = parseInt(req.query.checked)
    let update = 'update shoes_shoppingcart_item set is_checked = ? where user_id = ? and spec_id = ?'
    pool.query(update, [checked, uid, specid], function (err, result) {
        if (err) throw err
        if (result.affectedRows == 1) {
            res.json({ code: 200, msg: 'update success' })
        }
        else {
            res.json({ code: 201, msg: 'update fail' })
        }
    })
})
/*
 * API 4.1、添加订单
*/
server.get('/order/add',function(req,res){
    if (typeof (req.session.loginUser) == "undefined") {
        console.log('未登录')
        res.json({})
        return
    }
    let uid = req.session.loginUser.uid
    let specid = req.query.specid
    let count = parseInt(req.query.count)
    let select = 'select  stock from shoes_spec where sid = ? for update'
    pool.getConnection(function (err, connection) {
        connection.beginTransaction(function (err) {
            if (err) {
                connection.rollback(function () { connection.release() })
            } else {
                connection.query(select, [specid], function (err, result) {
                    if (err) {
                        connection.rollback(function () { connection.release() })
                        res.json({ code: 201, msg: 'add order fail' })
                    }
                    let before = result[0].count
                    if(count<before){
                        connection.rollback(function () { connection.release() })
                        res.json({ code: 201, msg: 'add order fail' })
                    }
                    let insertOrder = 'insert into order (user_id,order_time) values (?,?)'
                    let time = new Date().getSeconds()
                    connection.query(insertOrder,[uid,time],function(err,result){
                        if (err) {
                            connection.rollback(function () { connection.release() })
                            res.json({ code: 201, msg: 'add order fail' })
                        }
                        let oid = result.insertId
                        let update = 'update shoes_spec set stock = ? where sid = ?;'
                        let insert = 'insert into order_detail (order_id,product_spec_id,count) values (?,?,?);'
                        connection.query(update+insert,[before-count,specid,oid,specid,count],function(err,result){
                            if(err){
                                connection.rollback(function () { connection.release() })
                            res.json({ code: 201, msg: 'add order fail' })
                            }
                            if ((result[0].affectedRows == 1) &&
                            (result[1].affectedRows == 1 )) {
                            connection.commit()
                            connection.release()
                            res.json({ code: 200, msg: 'add order success' })
                        }
                        else {
                            connection.rollback(function () { connection.release() })
                            res.json({ code: 201, msg: 'add order  fail' })
                        }
                        })

                    })
                })
                
            }
        })
    })
    
})
