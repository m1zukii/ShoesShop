// /**加载购物车内容**/

$.ajax({
  xhrFields:{withCredentials:true},
  crossDomain: true,
  method:'get',
  url:'http://127.0.0.1:5050/cart/item/list',
  success:function(result){

    
    let html=``
    for(let i=0;i<result.length;i++)
    {
    html+=`
    <div class="container">
    <div class="row imfor_1">
    <div class="col-xs-1 col-md-2 con_5 check">
        <div class="Each">
            <span class="normal">
                <img src="img/cart/product_normal.png" alt=""/>
            </span>
            <input type="hidden" name="" value="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </div>
    </div>
    <div class="pudc">
        <div class="col-xs-3 col-md-2" id="${result[i].spec_id}">
            <div class="row shoes-name" style="display:block;overflow:hidden;">
              <span>名称：</span>
              <a href="detail.html?pid=${result[i].pid}" >${result[i].pname}</a>
            </div>
            <div class="row shoes-color" >
                <span>颜色：</span>
                <img src="${result[i].sort_sm}" title="${result[i].color}">
                <span>${result[i].color}</span>
            </div>
            <div class="row shoes-size">
                <span>尺码：</span>
                <span>${result[i].size}</span>
            </div>
        </div>
    </div>
    <div class="col-xs-2 price">
        <div class="line con_5">
            <b>￥</b>
            <span>${result[i].price}</span>
        </div>
    </div>
    <div class="col-xs-2 num">
        <div class="line con_5 line_span">
            <span class="reduc">&nbsp;-&nbsp;</span>
            <input type="text" value="${result[i].count}" disabled="disabled" style="width: 30px;height: 20px;background-color: white;border-radius:5px 5px 5px 5px">
            <span class="add">&nbsp;+&nbsp;</span>
        </div>
    </div>
    <div class="col-xs-2 total_imfor">
        <div class="line con_5">
            <b>￥</b>
            <span class="total">${result[i].count*result[i].price}</span>
        </div>
    </div>
    <div class="col-xs-2">
        <div class="line con_5">
            <a href="javascript:;" class="del_d shoes_del">删除</a>
        </div>
    </div>
</div></div>
    `
  }
    $('#cart_body').html(html);
  }
})

function adddel(){

    //加
    $("#cart_body").on('click', '.add', (function () {    
        let num=$(this).prev().val();
        num++;
        $(this).prev().val(num);
        let total =num*$(this).parent().parent().prev().children().children().eq(1).text();
        $(this).parent().parent().next().children().children().eq(1).text(total.toFixed(2));
        amountadd();
        let id=$(this).parent().parent().siblings('.pudc').children().attr('id');
        $.ajax({
          xhrFields: {
            withCredentials: true
          },
          crossDomain: true,
            method: "get",
            url: "http://127.0.0.1:5050/cart/item/updatecount",
            data: `specid=${id}&buyCount=${num}`,
            success:function(data,msg,xhr){
  
            }
        });
    }));

    //减
    $("#cart_body").on('click', '.reduc', (function () {    
        let num=$(this).next().val();
        if(num>1){
            num--;
            $(this).next().val(num);
            let total=num*$(this).parent().parent().prev().children().children().eq(1).text();
            $(this).parent().parent().next().children().children().eq(1).text(total.toFixed(2));
        }
        amountadd();
        let id=$(this).parent().parent().siblings('.pudc').children().attr('id');
        $.ajax({
          xhrFields: {
            withCredentials: true
          },
          crossDomain: true,
            method: "get",
            url: "http://127.0.0.1:5050/cart/item/updatecount",
            data: `specid=${id}&buyCount=${num}`,
            success:function(data,msg,xhr){
  
            }
        });
    }));

}

$(function(){

   if($('.imfor_1')){
     $('.none').hide();
   }

  adddel();
  $('.imfor_1').each(function () {
    let price = parseFloat($(this).children('.price').children().children('span').html());
    let amount = parseFloat($(this).children('.num').children().children('input').val());
    let amountPrice = price * amount;
    $(this).children('.total_imfor').children().children('.total').html(amountPrice.toFixed(2));
  });

  //全选
  $(".all").click(function () {
  amountadd();
  if ($('.all>span').hasClass('normal')) {
    $('.all>span').addClass('true').removeClass('normal');
    $('.all>span>img').attr('src', 'img/cart/product_true.png');
    $(".Each>span").each(function () {
      $(this).addClass('true').removeClass('normal');
      $(this).children('img').attr('src', 'img/cart/product_true.png');
      let id = $(this).parent().parent().siblings('.pudc').children().attr('id');
      let check=1;
      $.ajax({
        xhrFields: {
          withCredentials: true
        },
        crossDomain: true,
        method: 'GET',
        url: 'http://127.0.0.1:5050/cart/item/checked',
        data: `specid=${id}&checked=${check}`,
        success:function(data,msg,xhr){
  
        }
      })
    })
    totl();
  } else {
    $('.all>span').addClass('normal').removeClass('true');
    $('.all>span>img').attr('src', 'img/cart/product_normal.png');
    $('.Each>span').addClass('normal').removeClass('true');
    $('.Each>span>img').attr('src', 'img/cart/product_normal.png');
    $(".susum").text(0.00);
    $(".susumOne").text(0.00);
    $('.total_1').text(0);
    $('.totalOne').text(0);
    $(".Each>span").each(function () {
      let id = $(this).parent().parent().siblings('.pudc').children().attr('id');
      let check=0;
      $.ajax({
        xhrFields: {
          withCredentials: true
        },
        crossDomain: true,
        method: 'GET',
        url: 'http://127.0.0.1:5050/cart/item/checked',
        data: `specid=${id}&checked=${check}`,
        success:function(data,msg,xhr){
  
        }
      })
    })
  }
  })

  //单选
  $('#cart_body').on('click', '.Each>span', function () {
  amountadd();
  $('.all>span').addClass('normal').removeClass('true');
  $('.all>span>img').attr('src', 'img/cart/product_normal.png');
  if ($(this).hasClass('normal')) {
    $(this).addClass('true').removeClass('normal');
    $(this).children('img').attr('src', 'img/cart/product_true.png');
    let amou = parseInt($('.total_1').text());
    amou++;
    $('.total_1').text(amou);
    $('.totalOne').text(amou);
    amountadd();
    let id = $(this).parent().parent().siblings('.pudc').children().attr('id');
    let check=1;
    $.ajax({
      xhrFields: {
        withCredentials: true
      },
      crossDomain: true,
      method: 'GET',
      url: 'http://127.0.0.1:5050/cart/item/checked',
      data: `specid=${id}&checked=${check}`,
      success:function(data,msg,xhr){
  
      }
    })
  } else {
    $(this).addClass('normal').removeClass('true');
    $(this).children('img').attr('src', 'img/cart/product_normal.png');
    let amou = parseInt($('.total_1').text());
    amou--;
    $('.total_1').text(amou);
    $('.totalOne').text(amou);
    let newamo = parseInt($('.susum').text()) - parseInt($(this).parent().parent().siblings('.total_imfor').children().children('.total').text());
    $('.susum').text(newamo.toFixed(2));
    $('.susumOne').text(newamo.toFixed(2));
    let id = $(this).parent().parent().siblings('.pudc').children().attr('id');
    let check=0;
    $.ajax({
      xhrFields: {
        withCredentials: true
      },
      crossDomain: true,
      method: 'GET',
      url: 'http://127.0.0.1:5050/cart/item/checked',
      data: `specid=${id}&checked=${check}`,
      success:function(data,msg,xhr){
  
      }
    })
  }
  })

  //删除当前行
  $('#cart_body').on('click', '.del_d', (function () {
  let me=this;  
  let id=$(this).parent().parent().siblings('.pudc').children().attr('id');
  $('.modal').fadeIn();
  $('.no').click(function () {
    $('.modal').fadeOut();
  });
  $('.close').click(function(){
    $('.modal').fadeOut();
  });
  $('.yes').click(function () {
    $('.modal').fadeOut();
    $(me).parent().parent().parent().remove();
    $.ajax({
      xhrFields: {
        withCredentials: true
      },
      crossDomain: true,
      method:'post',
      url:'http://127.0.0.1:5050/cart/item/delete',
      data:`specid=${id}`,
      success:function(data,msg,xhr){
  
      }
    })
  })
  }));

  //批量删除
  $(".foot_del").click(function () {
    let str = [];
    $('.Each>span').each(function () {
      if ($(this).hasClass('true')) {
        let id = $(this).parent().parent().next().children().attr('id');
        str.push(id);
      }
    });
    if (str.length > 0) {
      $('.modal').fadeIn();
      $('.no').click(function () {
        $('.modal').fadeOut();
      });
      $('.yes').click(function () {
        $('.modal').fadeOut();
        $(".susum").text(0.00);
        $(".susumOne").text(0.00);
        $('.total_1').text(0);
        $('.totalOne').text(0);
        for(let i=0;i<str.length;i++){
          $("#"+str[i]).parent().prev().parent().remove();
          $.ajax({
            xhrFields: {
              withCredentials: true
            },
            crossDomain: true,
            method:'post',
            url:'http://127.0.0.1:5050/cart/item/delete',
            data:`specid=${str[i]}`,
            success:function(data,msg,xhr){
        
            }
          })
        }
      });
    } else {
      $('.modalNo').fadeIn();
      $('.close').click(function () {
        $('.modalNo').fadeOut();
      })
    }
  })

})


// 单独
function amountadd() {
  let amo = 0;
  $('.Each>span').each(function () {
    if ($(this).hasClass('true')) {
      amo += parseInt($(this).parent().parent().siblings('.total_imfor').children().children('.total').text());
    }
  })
  $('.susum').text(amo.toFixed(2));
  $('.susumOne').text(amo.toFixed(2));
  
}

//合计
function totl() {
  let sum = 0.00;
  let amount = 0;
  $(".total").each(function () {
    sum += parseInt($(this).text());
    $(".susum").text(sum.toFixed(2));
    $(".susumOne").text(sum.toFixed(2));
    amount++;
    $('.total_1').text(amount);
    $('.totalOne').text(amount);
  })
}


//去结算
$('#settle-up').click(function () {
  let totalPrice = ($('.susumOne').html());
  if(totalPrice<=0){
    $('.modal_1').fadeIn();
    $('.close').click(function(){
      $('.modal_1').fadeOut();
    });
  }else {
    location.href = '#';
  }
})
