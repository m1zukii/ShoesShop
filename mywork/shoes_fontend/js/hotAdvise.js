// Created by guoqy
//所有的推荐商品数据
var JSONData={
	name:"为您推荐",
	srcPath:"img/product/pro_img/",
	data:[{href:"#",src:"pro_1.jpg",price:56.00},
		{href:"#",src:"pro_2.jpg",price:97.00},
		{href:"#",src:"pro_3.jpg",price:89.00},
		{href:"#",src:"pro_4.jpg",price:69.00},
		{href:"#",src:"pro_5.jpg",price:35.00},
		{href:"#",src:"pro_6.jpg",price:18.00},
		{href:"#",src:"pro_7.jpg",price:76.00},
		{href:"#",src:"pro_8.jpg",price:82.00},
		{href:"#",src:"pro_1.jpg",price:56.00},
		{href:"#",src:"pro_2.jpg",price:97.00},
		{href:"#",src:"pro_3.jpg",price:89.00},
		{href:"#",src:"pro_4.jpg",price:69.00},
		{href:"#",src:"pro_5.jpg",price:35.00},
		{href:"#",src:"pro_6.jpg",price:18.00},
		{href:"#",src:"pro_7.jpg",price:76.00},
		{href:"#",src:"pro_8.jpg",price:82.00}]
};
//指定窗口加载完毕时，调用的函数
window.onload=function(){
	var adviseContent='<div class="pic_list3">';
	var turnShow=getRandomNum(8,0,14);
	for(var i=0;i<turnShow.length;i++){
		var index=turnShow[i];
		adviseContent=adviseContent+'<div class=" col-md-3 col-xs-3"><a href="'+JSONData.data[index].href
				+'"><img class=" img-responsive" src="'+JSONData.srcPath+JSONData.data[index].src
				+'" /></a><p class="price2">已有'
				+'<span class="endendend" > '+JSONData.data[index].price+' </span>人购买</p></div>';
	}
	adviseContent=adviseContent+'</div>';
	document.getElementsByClassName("right_nav")[0].innerHTML=adviseContent;
};
//设置定时器，定时更新热门推荐信息
window.setInterval("showHotAdvise()",4000);
//显示热门推荐信息
function showHotAdvise(){
	var adviseContent='<div class="pic_list3">';
	var turnShow=getRandomNum(8,0,14);
	for(var i=0;i<turnShow.length;i++){
		var index=turnShow[i];
		adviseContent=adviseContent+'<div class=" col-md-3 col-xs-3"><a href="'+JSONData.data[index].href
				+'"><img class=" img-responsive" src="'+JSONData.srcPath+JSONData.data[index].src
				+'" /></a><p class="price2">已有'
				+'<span class="endendend" > '+JSONData.data[index].price+' </span>人购买</p></div>';
	}
	adviseContent=adviseContent+'</div>';
	document.getElementsByClassName("right_nav")[0].innerHTML=adviseContent;
}
//返回num个不重复的随机数,范围在minNum~maxNum之间
function getRandomNum(num,minNum,maxNum){
	var array=new Array();
	for(var i=0;i<num;i++){
		do{
			var randomNum=Math.floor(Math.random()*maxNum+minNum);
			if(!checkNum(array,randomNum)){
				array.push(randomNum);
				break;
			}
		}while(true);
	}
	return array;
}
//数组array中包含num时返回true；否则返回false
function checkNum(array,num){
	for(var i=0;i<array.length;i++){
		if(array[i]==num){
			return true;
		}
	}
	return false;
}
