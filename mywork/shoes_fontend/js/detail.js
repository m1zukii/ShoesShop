var title=document.getElementById("title").innerText;
var price=document.getElementById("price").innerText;
var cima,sizeChoose;
var src,colorImgChoose;
var number = 1;
var temp = window.location.search;

var pid = temp.substring(5);//从url获取pid
var product, spec, pic, bname;
var colors = [];
var colorpics = [];

$(window).load(function() {
	$.ajax({
		xhrFields: {
			withCredentials: true
		},
		crossDomain: true,
		method: 'GET',
		url: `http://127.0.0.1:5050/product/detail?pid=${pid}`,
		success: function (data, msg, xhr) {

			

			product = data.product
			spec = data.spec
			pic = data.pic
			bname = data.bname
			for(let i=0;i<spec.length;i++){
				let c = spec[i].color
				let simg = spec[i].sort_sm
				if(colors.indexOf(c) == -1){
					colors.push(c)
					colorpics.push(simg)
				}
			}
			let i = 0
			$('.sm ul li img').each(function(){
				let smpic = pic[i++].sm
				$(this).attr('src',smpic)//小图
			})
			i = 0
			let sort_length=colors.length
			$('#sort li img').each(function(){
				if(i==sort_length){
					$(this).attr('width','0')
					$(this).attr('height','0')
					$(this).css('border','none')
					$(this).closest('li').css('border','none')
				}else{
					$(this).attr('src',colorpics[i])//颜色分类图
					$(this).attr('alt',colors[i])
					$(this).attr('title',colors[i++])
					$(this).attr('width','45px')
					$(this).attr('height','45px')
				}
			})
			$('#lg_pic').attr('src',pic[0].lg)//大图加载第一张
			$('#sort li img').eq(0).css('border','2px solid rgb(250,10,180)')
			$('#cm li').eq(0).css('border','2px solid rgb(250,10,180)')//尺码选择39
			sizeChoose = 39
			colorImgChoose=colorpics[0]
			// colorImgChoose=spec[0].spec_img
			$('#title h3').html(product.title)
			$('#title h4').html(product.subtitle)
			$('#price').html('￥'+product.price)
			$('#promise').html(product.promise)
			$('#pname').html('商品名称：'+product.pname)
			$('#style').html('款式：'+product.pname)
			$('#funct').html('功能：'+product.funct)
			$('#material_f').html('鞋底材质：'+product.material_f)
			$('#material_h').html('帮面材质：'+product.material_h)
			$('#pro_address').html('商品产地: '+product.pro_address)
			$('#target').html('适用对象：'+product.target)
			$('#pro_num').html('货号/款号：'+product.pro_num)
			$('#shelf_time').html('上市时间：'+product.shelf_time)
			$('#sold_count').html('已售出数量：'+product.sold_count)
			$('#opinion').html('评价数量：'+product.opinion)
			if(product.is_onsale==1){
				$('#is_onsale').html('是否促销中：是')
			}else{
				$('#is_onsale').html('是否促销中：否')
			}
			// $('#element').html('商品元素：'+product.element)
			// $('#details').html('商品详情：'+product.details)
		},
		error: function (xhr, error) {
			console.log(error)
		}
	})
})



function addCart(){
	let count = $('#num').val()
	let j,k,specid
	for(let i=0;i<spec.length;i++){
		j = spec[i].size
		k = spec[i].sort_sm
		if((j==sizeChoose) && (k==colorImgChoose)) 
			specid = spec[i].sid
	}
	if(typeof specid =="undefined"){
		$('#modalRegisterErr').modal()
		return 
	}
	$.ajax({
		method: 'GET',
		url: `http://127.0.0.1:5050/cart/item/add?specid=${specid}&buyCount=${count}`,
		xhrFields: {
			withCredentials: true
		},
		crossDomain: true,
		success: function (data, msg, xhr) {
			if (data.code === 200) {
				console.log('add success')
				$('#modalRegisterSucc').modal()
			}
			else {
				console.log('add fail')
				$('#modalRegisterErr').modal()
			}
		},
		error: function (xhr, error) {
			console.log(error)
			$('#modalRegisterErr').modal()
		}
	})
}



function changeSize(obj){
	$(obj).css('border','2px solid red').siblings('li').css('border','2px solid grey')
	sizeChoose = parseInt($(obj).html())
}
function changeLargePic(flag,position,obj){
	//点击小图
	if(flag == 0){
		$('#lg_pic').attr('src',pic[position-1].lg)
		$('#sm_pic li img').css("border","2px solid grey")
		$('#sm_pic li img').eq(position-1).css("border","2px solid red")
	}
	//点击不同规格
	else{
		$('#lg_pic').attr('src',colorpics[position-1])
		$('#sort li img').css("border","2px solid grey")
		$('#sort li img').eq(position-1).css("border","2px solid red")
		colorImgChoose = colorpics[position-1]
	}
}








function changeLgPic(thumb_img){
    var lg=document.getElementById("lg_pic");
	var url=thumb_img.src;
	url=url.replace(/sm/,'lg');
	url=url.replace('sm','lg');
	url=url.replace(/sort_sm/,'sort_lg');
	lg.src=url;

    var sm_pic=document.getElementById("sm_pic");
    var item1=sm_pic.getElementsByTagName("li");
    for(var i=0;i<item1.length;i++){
        var thumb=item1[i].getElementsByTagName("img")[0];
        thumb.style.borderColor="gray";
    }
    var sort=this.document.getElementById("sort");
    var item2=sort.getElementsByTagName("li");
    for(var i=0;i<item2.length;i++){
        var thumb=item2[i].getElementsByTagName("img")[0];
        thumb.style.borderColor="";
    }
    thumb_img.style.border="2px solid rgb(250,10,180)";
    src=url;
}

function changeBoder(thumb){
    var cm=document.getElementById("cm");
    var item=cm.getElementsByTagName("li");
    for(var i=0;i<item.length;i++){
        item[i].style.borderColor="";
    }
    thumb.style.border="2px solid rgb(250,10,180)";
    cima=thumb.innerText;
}

function jian(){
    var num=document.getElementById("num").value;
    if(num>1){
        num=num-1;
    }
    document.getElementById("num").value=num;
    number=num;
}

function jia(){
    var num=document.getElementById("num").value;
    num++;
    document.getElementById("num").value=num;
    number=num;
}

function submit(){
    console.log(title);
    console.log(price);
    console.log(cima);
    console.log(src);
    console.log(number);
}

function getTop(e){
	var offset=e.offsetTop;
	if (e.offsetParent!=null){
		offset+=getTop(e.offsetParent);
	}
	return offset;
}
//获取元素的横坐标（相对于body）
function getLeft(e){
	var offset=e.offsetLeft;
	if(e.offsetParent!=null){
		offset+=getLeft(e.offsetParent);
	}
	return offset;
}

function mouseout(shade,canvas){
	shade.style.display="none";
	canvas.style.display="none";
	document.body.style.cursor="default";
}

function zoomPicture() {
	var box=document.getElementById("lg");
	var showGoodsPicture=document.getElementById("lg_pic");
	var canvas=document.getElementById("canvas");
	var shade=document.getElementById("shade");
	if(showGoodsPicture==null) {
		return false;
	}
	//绑定鼠标移出所触发的事件
	box.onmouseout=function(){
		shade.style.display="none";
		canvas.style.display="none";
		document.body.style.cursor="default";
	};
	//绑定鼠标移动所触发的事件
	box.onmousemove =function(ev){
		//设定鼠标的样式
		document.body.style.cursor="move";
		var box = document.getElementById("lg");
		var shadeX, shadeY;
		//获取box对象的左侧到浏览器窗口左侧的距离
		var boxX=getLeft(box);
		//获取box对象的顶部到浏览器窗口顶部的距离
		var boxY=getTop(box);
		//计算阴影区域的左上角的x坐标
		shadeX=ev.pageX-boxX-100;
		//计算阴影区域的左上角的y坐标
		shadeY=ev.pageY-boxY-100;
		//防止阴影区域移到图片之外
		if(shadeX<15){
			shadeX=15;
		}
		else if(shadeX>245){
			shadeX=245;
		}
		if(shadeY<0){
			shadeY=0;
		}
		else if(shadeY>230){
			shadeY=230;
		}
		if(shadeX>265){
			mouseout(shade,canvas);
		}
		//使用Canvas绘制遮罩区域，并进行放大
		var context=canvas.getContext("2d");
		shade.style.display="block";
		shade.style.left=shadeX+"px";
		shade.style.top=shadeY+"px";
		canvas.style.display="inline";
		context.clearRect(0, 0, 430, 430);
		var image=new Image();
		image.src=showGoodsPicture.src;
		context.drawImage(image, (shade.offsetLeft) * 1, (shade.offsetTop) * 1, 
		323, 323, 0, 0, 1000, 1000);
	}
}


window.onload=function(){
    // var sm_pic=this.document.getElementById("sm_pic");
    // var thumb_img=sm_pic.getElementsByTagName("li")[0].getElementsByTagName("img")[0];
    // changeLgPic(thumb_img);
    zoomPicture();
}
