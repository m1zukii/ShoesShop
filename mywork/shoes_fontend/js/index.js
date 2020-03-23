//页面加载完成，异步请求服务器端动态数据
$(window).load(function() {
    $.ajax({
        xhrFields:{withCredentials:true},
        crossDomain: true,
        method: 'GET',
        url: 'http://127.0.0.1:5050/index',
        success: function(data) {



            //console.log('成功获取到服务器端异步返回的数据：')
            //1.处理轮播广告的动态数据
            let html1='' //即将要放到轮播广告内的动态内容
            for(let i in data.carouselItems){   //根据动态数据创建HTML字符串
                html1+=
                `
                    <div class="item ${i==0?'active':''}">
                        <a href="
                `
                html1+=data.carouselItems[i].href
                html1+=
                `
                        "><img src="${data.carouselItems[i].img}"></a>
                    </div>
                `
            }
            $('.carousel .carousel-inner').html(html1)



            //2.处理一楼的动态数据
            let data1=data.recommendedItems //一楼的动态数据
            $('#f1 #shoes-item1 img').attr('src',data1[0].pic)
            $('#f1 #shoes-item1 h2').html(data1[0].title)
            $('#f1 #shoes-item1 p').html(data1[0].details)
            $('#f1 #shoes-item1 h4').html('￥'+data1[0].price)
            $('#f1 #shoes-item1 button').attr('onclick','window.location.href="'+data1[0].href+'"')

            $('#f1 #shoes-item2 img').attr('src',data1[1].pic)
            $('#f1 #shoes-item2 h2').html(data1[1].title)
            $('#f1 #shoes-item2 p').html(data1[1].details)
            $('#f1 #shoes-item2 h4').html('￥'+data1[1].price)
            $('#f1 #shoes-item2 button').attr('onclick','window.location.href="'+data1[1].href+'"')

            $('#f1 #shoes-item3 img').attr('src',data1[2].pic)
            $('#f1 #shoes-item3 h3').html(data1[2].title)
            $('#f1 #shoes-item3 p').html(data1[2].details)
            $('#f1 #shoes-item3 button').attr('onclick','window.location.href="'+data1[2].href+'"')

            $('#f1 #shoes-item4 img').attr('src',data1[3].pic)
            $('#f1 #shoes-item4 p').html(data1[3].title)
            $('#f1 #shoes-item4 h4').html('￥'+data1[3].price)
            $('#f1 #shoes-item4 button').attr('onclick','window.location.href="'+data1[3].href+'"')

            $('#f1 #shoes-item5 img').attr('src',data1[4].pic)
            $('#f1 #shoes-item5 p').html(data1[4].title)
            $('#f1 #shoes-item5 h4').html('￥'+data1[4].price)
            $('#f1 #shoes-item5 button').attr('onclick','window.location.href="'+data1[4].href+'"')

            $('#f1 #shoes-item6 img').attr('src',data1[5].pic)
            $('#f1 #shoes-item6 p').html(data1[5].title)
            $('#f1 #shoes-item6 h4').html('￥'+data1[5].price)
            $('#f1 #shoes-item6 button').attr('onclick','window.location.href="'+data1[5].href+'"')

            //3.处理二楼的动态数据
            let data2=data.newArrialItems
            //4.处理三楼的动态数据
        }
    })
})