SET NAMES UTF8;
DROP DATABASE IF EXISTS shoes;
CREATE DATABASE shoes CHARSET=UTF8;
USE shoes;


/**鞋子品牌类**/
CREATE TABLE shoes_brand(
  bid INT PRIMARY KEY AUTO_INCREMENT,
  bname VARCHAR(32)           #品牌名字
);

/**鞋子规格类**/
CREATE TABLE shoes_spec(
  sid INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT,
  color VARCHAR(32),          #颜色
  size INT,                   #尺码
  stock INT,                  #库存
  sort_lg VARCHAR(32),        #规格配图(大)
  sort_sm VARCHAR(32)	#规格配图(小)
);

/**鞋子类**/
CREATE TABLE shoes_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  brand_id INT,               #所属品牌编号
  title VARCHAR(128),         #主标题
  subtitle VARCHAR(128),      #副标题
  price DECIMAL(10,2),        #价格
  promise VARCHAR(64),        #服务承诺
  pro_img VARCHAR(32),        #封面配图

  pname VARCHAR(32),          #商品名称
  style VARCHAR(32),          #款式
  funct VARCHAR(32),          #功能
  material_f VARCHAR(32),     #鞋底材质
  material_h VARCHAR(32),     #帮面材质
  element VARCHAR(32),        #商品元素
  pro_address VARCHAR(32),    #商品产地
  target VARCHAR(32),         #适用对象
  pro_num VARCHAR(32),        #货号/款号
  details VARCHAR(1024),      #产品详细说明

  shelf_time VARCHAR(32),          #上市时间
  sold_count INT,             #已售出的数量
  opinion INT,                #评价数量
  is_onsale BOOLEAN,          #是否促销中
  web_address  VARCHAR(128)               #参考网址
);

/**鞋子图片**/
CREATE TABLE shoes_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  product_id INT,             #鞋子编号
  sm VARCHAR(128),            #小图片路径(那五张放大缩小的图片，与具体的规格无关)
  lg VARCHAR(128)             #大图片路径
);

/**用户信息**/
CREATE TABLE shoes_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),

  avatar VARCHAR(128),        #头像图片路径
  user_name VARCHAR(32),      #用户名，如王小明
  gender INT                  #性别  0-女  1-男
);

/**收货地址信息**/
CREATE TABLE shoes_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  fixedphone VARCHAR(16),     #固定电话
  postcode CHAR(6),           #邮编
  tag VARCHAR(16),            #标签名

  is_default BOOLEAN          #是否为当前用户的默认收货地址
);

/**购物车条目**/
CREATE TABLE shoes_shoppingcart_item(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,      #用户编号
  spec_id INT,   #商品编号
  count INT,        #购买数量
  is_checked BOOLEAN #是否已勾选，确定购买
);

/**用户订单**/
CREATE TABLE shoes_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  address_id INT,
  status INT,             #订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消
  order_time BIGINT,      #下单时间
  pay_time BIGINT,        #付款时间
  deliver_time BIGINT,    #发货时间
  received_time BIGINT    #签收时间
)AUTO_INCREMENT=10000000;

/**用户订单**/
CREATE TABLE shoes_order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,           #订单编号
  product_id INT,         #产品编号
  count INT               #购买数量
);

/****首页轮播广告商品****/
CREATE TABLE shoes_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  img VARCHAR(128),
  title VARCHAR(64),
  href VARCHAR(128)
);

/****首页商品****/
CREATE TABLE shoes_index_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64),
  details VARCHAR(128),
  pic VARCHAR(128),
  price DECIMAL(10,2),
  href VARCHAR(128),
  seq_recommended TINYINT,
  seq_new_arrival TINYINT,
  seq_top_sale TINYINT
);

/*******************/
/******数据导入******/
/*******************/
/**鞋子品牌类**/
INSERT INTO shoes_brand VALUES
(NULL,'PEAK/匹克'),
(NULL,'KungfuDeer/功夫鹿'),
(NULL,'Pardasaul/帕达索'),
(NULL,'Warrior/回力'),
(NULL,'LI-NING/李宁'),
(NULL,'ANTA/安踏'),
(NULL,'XTEP/特步'),
(NULL,'JORDAN/乔丹'),
(NULL,'PUMA/彪马');

/**鞋子类(最后那个是爬取数据网页的网址，暂时保存一下，没什么用的)**/
INSERT INTO shoes_product VALUES
(1,1,'匹克休闲鞋男鞋2019冬季新款低帮耐磨复古皮革拼接运动鞋老爹鞋男','此商品活动中，请尽快购买！',209,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','img/product/pro_img/pro_1.jpg','匹克休闲鞋男鞋','男休闲鞋','防滑 耐磨 平衡 支撑','耐磨橡胶','合成革+织物','皮革拼接','中国大陆','男子','DE930771','null','2019年秋季',2968,2451,true,'https://detail.tmall.com/item.htm?id=598366324249&ali_refid=a3_430673_1006:1102557608:N:4UXPWb4jZAVCX7u/ywi/nQ==:2207d671ab31d0a449057cf32eff4087&ali_trackid=1_2207d671ab31d0a449057cf32eff4087&spm=a2e15.8261149.07626516002.3&skuId=4344834411029'),
(2,1,'匹克态极小白鞋一尘低帮板鞋运动鞋男轻便时尚滑板鞋平底休闲鞋','经典传承休闲文化鞋，态极自适应缓震回弹科',359,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','img/product/pro_img/pro_2.jpg','匹克态极小白鞋','休闲鞋','防滑 轻便','耐磨橡胶','合成革+织物','皮革拼接','中国大陆','男子','E93097B','null','2019年秋季',4428,16006,true,'https://click.simba.taobao.com/cc_im?spm=a2e15.8261149.07626516002.1&p=%C6%A5%BF%CB%D0%AC&s=94876744&k=621&clk1=46dbd97e0e034b89dba43c5c52e2c00f&e=7maaFhyfdEYRaTsI5wrDzKCPF2yVrdnPfet9yTq5qnIsLFUi6EKXDB6k23TexqCFhrfhdB1sgd4TviTWb9brP%2FdCtuARmn7TF%2FNOv8GAi0Y2DDICkiPnp9q1vtlAVuvHY2A4AveSAhkG%2F%2B3pyWItxfiM5nVpmo3K36j%2Fmd5OGa5%2Fwri020E4H7JUSIIsza8vrED1Cb9DgGLzq%2FQL9MEZ4NmPMdzvGVlag5kgE5qttDR5k2WuSWRQNgkzp2tv6dFipgnEYxG2arsNt1%2BZ%2F1uS1j5UZYbWZQzgQmS%2FNBNGMIIKsSufxTXAsaeHOhuKwRyE9ZuvIigsgTLoWzuoTnEqauA4N%2FOZEBwYMzaHnQipoMhOYcwav3cmGpf2bxLNYEwjQXq1pke4grrwXC8eMtDMKsHlEsTb8E%2FBM6qhKopM1QRnnd4MpRu5xlvqP7mbhq8WuSMXMMaeYi5CkvCQZjNXlksWQXmJsfNALCONCncQocSm0R0Wnk7u%2FBS0UBntEmxKZzhIb9lLxSaFOIX%2B5MpGRo3Q8Tscjj7875bI3WlGdHkknGSF9TfBsVA7HE5e31WmJ55q7fqQvObOCfRV2GMEX0xcAef6OvrdhOEgPkVHizE%3D&union_lens=lensId%3An%401576459113%400b0b2afa_9d09_16f0c4912f1_395b%4001'),
(3,2,'马丁靴男冬季加绒保暖英伦高帮鞋子男鞋中帮潮鞋工装靴子雪地棉鞋','整高13cm,跟高3.5cm,鞋面真皮,加购货',308,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','img/product/pro_img/pro_3.jpg','马丁靴男冬季加绒保暖英伦高帮鞋子','男休闲鞋','保暖','橡胶','牛反绒','车缝线','中国大陆','青年','3321','null','2019年秋季',2968,99001,true,'https://detail.tmall.com/item.htm?id=575952879008&ali_refid=a3_430673_1006:1109725882:N:BaxGxtmXhnUjBqGrANoKiA==:b2f8fae3b36b68982f79434fffdc9877&ali_trackid=1_b2f8fae3b36b68982f79434fffdc9877&spm=a2e15.8261149.07626516002.3&sku_properties=1627207:6789018369'),
(4,3,'帕达索男鞋2019秋季新款休闲鞋透气百搭板鞋潮流帆布鞋男PB90836','此商品活动中，请尽快购买！',536,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','img/product/pro_img/pro_4.jpg','帕达索男鞋','青春潮流','耐磨','橡胶','布','不系带','中国大陆','青年','PB90836','null','2019年秋季',2968,28,true,'https://detail.tmall.com/item.htm?id=601179200504&ali_refid=a3_430673_1006:1106075845:N:BaxGxtmXhnUjBqGrANoKiA==:519e62d27bd85eab13f62cf8205ef7ca&ali_trackid=1_519e62d27bd85eab13f62cf8205ef7ca&spm=a2e15.8261149.07626516002.10&sku_properties=1627207:6497657392'),
(5,4,'回力女鞋反光厚底加绒老爹鞋2019秋冬新款休闲百搭运动鞋ins潮鞋','回力新款老爹鞋 厚底增高反光鞋',99,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','img/product/pro_img/pro_5.jpg','回力女鞋','运动休闲鞋','休闲用','PVC','多种材质拼接','交叉绑带','广东','青年 18-40周岁','90508','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>','2019年秋季',2153,1964,true,'https://detail.tmall.com/item.htm?spm=a1z10.3-b-s.w4011-14883668248.117.2d821164hk46xR&id=604021512170&rn=9c644702806ea17782014b4a2a940a1a&abbucket=3&sku_properties=1627207:6130542836'),
(6,4,'回力差评联名帆布鞋女鞋小白鞋2019秋款板鞋秋季新款秋鞋爆改潮鞋','回力版 差评联名款 鞋舌标不一样', 89,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','img/product/pro_img/pro_6.jpg','回力帆布鞋','帆布鞋','休闲出行','橡胶','人造革','交叉绑带 拼色','北京','青年 25-35岁','WB-1L','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>','2019年秋季',750,685,true,'https://detail.tmall.com/item.htm?spm=a1z10.3-b-s.w4011-14883668248.127.2d821164hk46xR&id=574610316430&rn=9c644702806ea17782014b4a2a940a1a&abbucket=3'),
(7,5,'李宁篮球鞋男鞋韦德系列封锁高帮减震耐磨防滑秋冬专业运动鞋男','19-21日：叠券满300-50，499-80',379,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货', 'img/product/pro_img/pro_7.jpg','李宁篮球鞋男鞋','运动鞋','防滑 耐磨 支撑','橡胶+EVA+TPU','纺织品+TPU+合成革','秋冬','中国大陆','男子','ABAN065','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>','2018冬季',3659,10562,true,'https://detail.tmall.com/item.htm?spm=a230r.1.14.10.1e6f3f9cmVx6dw&id=576062914438&cm_id=140105335569ed55e27b&abbucket=10'),
(8,5,'李宁篮球鞋男鞋封锁2019新款秋冬耐磨一体织高帮专业比赛鞋运动鞋','19-21日：叠券满300-50，499-80',419,'*退货补运费 *30天无忧退货 *48小时快速退款 *72小时发货','img/product/pro_img/pro_8.jpg','李宁篮球鞋男鞋','运动鞋','透气 包裹性 耐磨 防滑 支撑','橡胶+EVA+TPU','纺织品','专业比赛鞋', '中国大陆','男子','ABAP057','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>','2019春季',4213,8699,true,'https://detail.tmall.com/item.htm?spm=a230r.1.14.18.1e6f3f9cmVx6dw&id=585329112107&cm_id=140105335569ed55e27b&abbucket=10'),
(9,8,'乔丹篮球鞋男秋冬黑武士球鞋高帮减震战靴防滑耐磨学生运动鞋男鞋','【高帮减震】【防滑耐磨】潮流上爬抓地款式',239,'*正品保证 *极速退款 *赠运费险 *七天无理由退换',' img/product/pro_img/pro_9.jpg','乔丹篮球鞋','运动鞋','减震 防滑 耐磨 透气','防滑橡胶','合成革','气垫 缓震胶 扭转系统','中国大陆','男女','XM3570137','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>','2017年秋季',1559,13229,true,'https://detail.tmall.com/item.htm?id=554766498606&ali_refid=a3_430583_1006:1110493301:N:ffhvWmCYtkk2kMra2SQa+CMGoasA2gqI:610c9bdc64a5e6f4de94aa0caedf5803&ali_trackid=1_610c9bdc64a5e6f4de94aa0caedf5803&spm=a230r.1.14.3'),
(10,8,'乔丹2019篮球鞋男鞋秋冬季高帮学生运动鞋男减震毒液外场实战球鞋','爆款篮球鞋 实战战靴',189, '*正品保证 *极速退款 *赠运费险 *七天无理由退换', ' img/product/pro_img/pro_10.jpg','乔丹2019篮球鞋','运动鞋', '减震 防滑 耐磨 透气','橡胶+EVA+TPU+DPU','牛皮+人造革','运动系列','中国大陆','男子','XM1570168','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>','2019年冬季',516,196,true,'https://detail.tmall.com/item.htm?spm=a230r.1.14.18.15f848cfZjq1yU&id=602108147026&cm_id=140105335569ed55e27b&abbucket=10'),
(11,6,'安踏要疯篮球鞋男鞋2019冬季新款官网旗舰kt汤普森3星轨4运动鞋5','官网旗舰 7天无理由退换货',299,'*赠保价险 *正品保证 *极速退款 *赠运费险 *七天无理由退换',' img/product/pro_img/pro_11.jpg','安踏要疯篮球鞋','运动鞋','回弹','橡胶+EVA','合成革','篮球外场鞋','中国大陆','男子','11731399T','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>','2018年冬季',4771,33367,true,'https://detail.tmall.com/item.htm?spm=a230r.1.14.10.2e1367a8MRNDFE&id=566313829983&cm_id=140105335569ed55e27b&abbucket=10 '),
(12,6,'安踏篮球鞋男鞋冬季60th纪念款官网汤普森kt4高帮2品牌5运动鞋男6','anta正品2019新款限量款全明星灭霸实战战靴',399,'*正品保证 *极速退款 *赠运费险 *七天无理由退换','img/product/pro_img/pro_12.jpg','安踏篮球鞋','运动鞋','减震 防滑 耐磨 包裹性','橡胶+EVA+TPU','人造革+织物','NBA-全明星系列鞋','中国大陆','男子','11731101','<div class="content_tpl"> <div class="formwork">   <div class="formwork_img"><br></div><div class="formwork_img">    <img alt="" class="" src="img/product/detail/57b15612N81dc489d.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_img">    <img alt="" class="" src="//img20.360buyimg.com/vc/jfs/t2683/60/4222930118/169462/233c7678/57b15616N1e285f09.jpg">   </div>  </div>  <div class="formwork">   <div class="formwork_text">    技术规格请前往 www.apple.com/cn/macbook-air/specs.html 查看完整内容。</div></div></div>','2019年秋季',2698,4893,true,'https://detail.tmall.com/item.htm?spm=a230r.1.14.50.2e1367a8MRNDFE&id=551113031805&ns=1&abbucket=10');


/*鞋子详情页小和大对应的那几张图*/
INSERT INTO shoes_pic VALUES
(NULL, 1, 'img/product/sm/sm1_1.jpg','img/product/lg/lg1_1.jpg'),
(NULL, 1, 'img/product/sm/sm1_2.jpg','img/product/lg/lg1_2.jpg'),
(NULL, 1, 'img/product/sm/sm1_3.jpg','img/product/lg/lg1_3.jpg'),
(NULL, 1, 'img/product/sm/sm1_4.jpg','img/product/lg/lg1_4.jpg'),
(NULL, 1, 'img/product/sm/sm1_5.jpg','img/product/lg/lg1_5.jpg'),
(NULL, 2, 'img/product/sm/sm2_1.jpg','img/product/lg/lg2_1.jpg'),
(NULL, 2, 'img/product/sm/sm2_2.jpg','img/product/lg/lg2_2.jpg'),
(NULL, 2, 'img/product/sm/sm2_3.jpg','img/product/lg/lg2_3.jpg'),
(NULL, 2, 'img/product/sm/sm2_4.jpg','img/product/lg/lg2_4.jpg'),
(NULL, 2, 'img/product/sm/sm2_5.jpg','img/product/lg/lg2_5.jpg'),
(NULL, 3, 'img/product/sm/sm3_1.jpg','img/product/lg/lg3_1.jpg'),
(NULL, 3, 'img/product/sm/sm3_2.jpg','img/product/lg/lg3_2.jpg'),
(NULL, 3, 'img/product/sm/sm3_3.jpg','img/product/lg/lg3_3.jpg'),
(NULL, 3, 'img/product/sm/sm3_4.jpg','img/product/lg/lg3_4.jpg'),
(NULL, 3, 'img/product/sm/sm3_5.jpg','img/product/lg/lg3_5.jpg'),
(NULL, 4, 'img/product/sm/sm4_1.jpg','img/product/lg/lg4_1.jpg'),
(NULL, 4, 'img/product/sm/sm4_2.jpg','img/product/lg/lg4_2.jpg'),
(NULL, 4, 'img/product/sm/sm4_3.jpg','img/product/lg/lg4_3.jpg'),
(NULL, 4, 'img/product/sm/sm4_4.jpg','img/product/lg/lg4_4.jpg'),
(NULL, 4, 'img/product/sm/sm4_5.jpg','img/product/lg/lg4_5.jpg'),
(NULL, 5, 'img/product/sm/sm5_1.jpg','img/product/lg/lg5_1.jpg'),
(NULL, 5, 'img/product/sm/sm5_2.jpg','img/product/lg/lg5_2.jpg'),
(NULL, 5, 'img/product/sm/sm5_3.jpg','img/product/lg/lg5_3.jpg'),
(NULL, 5, 'img/product/sm/sm5_4.jpg','img/product/lg/lg5_4.jpg'),
(NULL, 5, 'img/product/sm/sm5_5.jpg','img/product/lg/lg5_5.jpg'),
(NULL, 6, 'img/product/sm/sm6_1.jpg','img/product/lg/lg6_1.jpg'),
(NULL, 6, 'img/product/sm/sm6_2.jpg','img/product/lg/lg6_2.jpg'),
(NULL, 6, 'img/product/sm/sm6_3.jpg','img/product/lg/lg6_3.jpg'),
(NULL, 6, 'img/product/sm/sm6_4.jpg','img/product/lg/lg6_4.jpg'),
(NULL, 6, 'img/product/sm/sm6_5.jpg','img/product/lg/lg6_5.jpg'),
(NULL, 7, 'img/product/sm/sm7_1.jpg','img/product/lg/lg7_1.jpg'),
(NULL, 7, 'img/product/sm/sm7_2.jpg','img/product/lg/lg7_2.jpg'),
(NULL, 7, 'img/product/sm/sm7_3.jpg','img/product/lg/lg7_3.jpg'),
(NULL, 7, 'img/product/sm/sm7_4.jpg','img/product/lg/lg7_4.jpg'),
(NULL, 7, 'img/product/sm/sm7_5.jpg','img/product/lg/lg7_5.jpg'),
(NULL, 8, 'img/product/sm/sm8_1.jpg','img/product/lg/lg8_1.jpg'),
(NULL, 8, 'img/product/sm/sm8_2.jpg','img/product/lg/lg8_2.jpg'),
(NULL, 8, 'img/product/sm/sm8_3.jpg','img/product/lg/lg8_3.jpg'),
(NULL, 8, 'img/product/sm/sm8_4.jpg','img/product/lg/lg8_4.jpg'),
(NULL, 8, 'img/product/sm/sm8_5.jpg','img/product/lg/lg8_5.jpg'),
(NULL,9,'img/product/sm/sm9_1.jpg','img/product/lg/lg9_1.jpg'),
(NULL,9,'img/product/sm/sm9_2.jpg','img/product/lg/lg9_2.jpg'),
(NULL,9,'img/product/sm/sm9_3.jpg','img/product/lg/lg9_3.jpg'),
(NULL,9,'img/product/sm/sm9_4.jpg','img/product/lg/lg9_4.jpg'),
(NULL,9,'img/product/sm/sm9_5.jpg','img/product/lg/lg9_5.jpg'),
(NULL,10,'img/product/sm/sm10_1.jpg','img/product/lg/lg10_1.jpg'),
(NULL,10,'img/product/sm/sm10_2.jpg','img/product/lg/lg10_2.jpg'),
(NULL,10,'img/product/sm/sm10_3.jpg','img/product/lg/lg10_3.jpg'),
(NULL,10,'img/product/sm/sm10_4.jpg','img/product/lg/lg10_4.jpg'),
(NULL,10,'img/product/sm/sm10_5.jpg','img/product/lg/lg10_5.jpg'),
(NULL,11,'img/product/sm/sm11_1.jpg','img/product/lg/lg11_1.jpg'),
(NULL,11,'img/product/sm/sm11_2.jpg','img/product/lg/lg11_2.jpg'),
(NULL,11,'img/product/sm/sm11_3.jpg','img/product/lg/lg11_3.jpg'),
(NULL,11,'img/product/sm/sm11_4.jpg','img/product/lg/lg11_4.jpg'),
(NULL,11,'img/product/sm/sm11_5.jpg','img/product/lg/lg11_5.jpg'),
(NULL,12,'img/product/sm/sm12_1.jpg','img/product/lg/lg12_1.jpg'),
(NULL,12,'img/product/sm/sm12_2.jpg','img/product/lg/lg12_2.jpg'),
(NULL,12,'img/product/sm/sm12_3.jpg','img/product/lg/lg12_3.jpg'),
(NULL,12,'img/product/sm/sm12_4.jpg','img/product/lg/lg12_4.jpg'),
(NULL,12,'img/product/sm/sm12_5.jpg','img/product/lg/lg12_5.jpg');


/**鞋子规格的大图(这里的1跟2对应的是鞋子类)**/
INSERT INTO shoes_spec VALUES
(NULL,1,'卡其色',39,310,'img/product/sort_lg/sort1_1.jpg','img/product/sort_sm/sort1_1.jpg'),
(NULL,1,'大白/沉寂蓝',39,219,'img/product/sort_lg/sort1_2.jpg','img/product/sort_sm/sort1_2.jpg'),
(NULL,1,'黑色/荧光红',39,287,'img/product/sort_lg/sort1_3.jpg','img/product/sort_sm/sort1_3.jpg'),
(NULL,1,'卡其色',40,121,'img/product/sort_lg/sort1_1.jpg','img/product/sort_sm/sort1_1.jpg'),
(NULL,1,'大白/沉寂蓝',40,230,'img/product/sort_lg/sort1_2.jpg','img/product/sort_sm/sort1_2.jpg'),
(NULL,1,'黑色/荧光红',40,234,'img/product/sort_lg/sort1_3.jpg','img/product/sort_sm/sort1_3.jpg'),
(NULL,1,'卡其色',41,125,'img/product/sort_lg/sort1_1.jpg','img/product/sort_sm/sort1_1.jpg'),
(NULL,1,'大白/沉寂蓝',41,23,'img/product/sort_lg/sort1_2.jpg','img/product/sort_sm/sort1_2.jpg'),
(NULL,1,'黑色/荧光红',41,214,'img/product/sort_lg/sort1_3.jpg','img/product/sort_sm/sort1_3.jpg'),
(NULL,1,'卡其色',42,101,'img/product/sort_lg/sort1_1.jpg','img/product/sort_sm/sort1_1.jpg'),
(NULL,1,'大白/沉寂蓝',42,222,'img/product/sort_lg/sort1_2.jpg','img/product/sort_sm/sort1_2.jpg'),
(NULL,1,'黑色/荧光红',42,0,'img/product/sort_lg/sort1_3.jpg','img/product/sort_sm/sort1_3.jpg'),
(NULL,1,'卡其色',43,0,'img/product/sort_lg/sort1_1.jpg','img/product/sort_sm/sort1_1.jpg'),
(NULL,1,'大白/沉寂蓝',43,162,'img/product/sort_lg/sort1_2.jpg','img/product/sort_sm/sort1_2.jpg'),
(NULL,1,'黑色/荧光红',43,70,'img/product/sort_lg/sort1_3.jpg','img/product/sort_sm/sort1_3.jpg'),
(NULL,2,'帆布白',39,310,'img/product/sort_lg/sort2_1.jpg','img/product/sort_sm/sort2_1.jpg'),
(NULL,2,'黑色/米白',39,219,'img/product/sort_lg/sort2_2.jpg','img/product/sort_sm/sort2_2.jpg'),
(NULL,2,'大白/闪光绿',39,287,'img/product/sort_lg/sort2_3.jpg','img/product/sort_sm/sort2_3.jpg'),
(NULL,2,'大白/大红',39,287,'img/product/sort_lg/sort2_4.jpg','img/product/sort_sm/sort2_4.jpg'),
(NULL,2,'帆布白',40,121,'img/product/sort_lg/sort2_1.jpg','img/product/sort_sm/sort2_1.jpg'),
(NULL,2,'黑色/米白',40,230,'img/product/sort_lg/sort2_2.jpg','img/product/sort_sm/sort2_2.jpg'),
(NULL,2,'大白/闪光绿',40,234,'img/product/sort_lg/sort2_3.jpg','img/product/sort_sm/sort2_3.jpg'),
(NULL,2,'大白/大红',40,287,'img/product/sort_lg/sort2_4.jpg','img/product/sort_sm/sort2_4.jpg'),
(NULL,2,'帆布白',41,125,'img/product/sort_lg/sort2_1.jpg','img/product/sort_sm/sort2_1.jpg'),
(NULL,2,'黑色/米白',41,23,'img/product/sort_lg/sort2_2.jpg','img/product/sort_sm/sort2_2.jpg'),
(NULL,2,'大白/闪光绿',41,214,'img/product/sort_lg/sort2_3.jpg','img/product/sort_sm/sort2_3.jpg'),
(NULL,2,'大白/大红',41,287,'img/product/sort_lg/sort2_4.jpg','img/product/sort_sm/sort2_4.jpg'),
(NULL,2,'帆布白',42,101,'img/product/sort_lg/sort2_1.jpg','img/product/sort_sm/sort2_1.jpg'),
(NULL,2,'黑色/米白',42,222,'img/product/sort_lg/sort2_2.jpg','img/product/sort_sm/sort2_2.jpg'),
(NULL,2,'大白/闪光绿',42,0,'img/product/sort_lg/sort2_3.jpg','img/product/sort_sm/sort2_3.jpg'),
(NULL,2,'大白/大红',42,287,'img/product/sort_lg/sort2_4.jpg','img/product/sort_sm/sort2_4.jpg'),
(NULL,2,'帆布白',43,0,'img/product/sort_lg/sort2_1.jpg','img/product/sort_sm/sort2_1.jpg'),
(NULL,2,'黑色/米白',43,162,'img/product/sort_lg/sort2_2.jpg','img/product/sort_sm/sort2_2.jpg'),
(NULL,2,'大白/闪光绿',43,70,'img/product/sort_lg/sort2_3.jpg','img/product/sort_sm/sort2_3.jpg'),
(NULL,2,'大白/大红',43,287,'img/product/sort_lg/sort2_4.jpg','img/product/sort_sm/sort2_4.jpg'),
(NULL,3,'米色-秋冬款',39,7179,'img/product/sort_lg/sort3_1.jpg','img/product/sort_sm/sort3_1.jpg'),
(NULL,3,'米色-秋冬款',40,6812,'img/product/sort_lg/sort3_1.jpg','img/product/sort_sm/sort3_1.jpg'),
(NULL,3,'米色-秋冬款',41,6412,'img/product/sort_lg/sort3_1.jpg','img/product/sort_sm/sort3_1.jpg'),
(NULL,3,'米色-秋冬款',42,3456,'img/product/sort_lg/sort3_1.jpg','img/product/sort_sm/sort3_1.jpg'),
(NULL,3,'米色-秋冬款',43,5467,'img/product/sort_lg/sort3_1.jpg','img/product/sort_sm/sort3_1.jpg'),
(NULL,3,'黄色-秋冬款',39,2871,'img/product/sort_lg/sort3_2.jpg','img/product/sort_sm/sort3_2.jpg'),
(NULL,3,'黄色-秋冬款',40,5287,'img/product/sort_lg/sort3_2.jpg','img/product/sort_sm/sort3_2.jpg'),
(NULL,3,'黄色-秋冬款',41,2682,'img/product/sort_lg/sort3_2.jpg','img/product/sort_sm/sort3_2.jpg'),
(NULL,3,'黄色-秋冬款',42,2682,'img/product/sort_lg/sort3_2.jpg','img/product/sort_sm/sort3_2.jpg'),
(NULL,3,'黄色-秋冬款',43,2682,'img/product/sort_lg/sort3_2.jpg','img/product/sort_sm/sort3_2.jpg'),
(NULL,3,'黑色-秋冬款',39,2281,'img/product/sort_lg/sort3_3.jpg','img/product/sort_sm/sort3_3.jpg'),
(NULL,3,'黑色-秋冬款',40,2183,'img/product/sort_lg/sort3_3.jpg','img/product/sort_sm/sort3_3.jpg'),
(NULL,3,'黑色-秋冬款',41,3212,'img/product/sort_lg/sort3_3.jpg','img/product/sort_sm/sort3_3.jpg'),
(NULL,3,'黑色-秋冬款',42,4576,'img/product/sort_lg/sort3_3.jpg','img/product/sort_sm/sort3_3.jpg'),
(NULL,3,'黑色-秋冬款',43,3455,'img/product/sort_lg/sort3_3.jpg','img/product/sort_sm/sort3_3.jpg'),
(NULL,3,'米色-四季款',39,3556,'img/product/sort_lg/sort3_4.jpg','img/product/sort_sm/sort3_4.jpg'),
(NULL,3,'米色-四季款',40,3677,'img/product/sort_lg/sort3_4.jpg','img/product/sort_sm/sort3_4.jpg'),
(NULL,3,'米色-四季款',41,3876,'img/product/sort_lg/sort3_4.jpg','img/product/sort_sm/sort3_4.jpg'),
(NULL,3,'米色-四季款',42,3941,'img/product/sort_lg/sort3_4.jpg','img/product/sort_sm/sort3_4.jpg'),
(NULL,3,'米色-四季款',43,3654,'img/product/sort_lg/sort3_4.jpg','img/product/sort_sm/sort3_4.jpg'),
(NULL,3,'黄色-四季款',39,3651,'img/product/sort_lg/sort3_5.jpg','img/product/sort_sm/sort3_5.jpg'),
(NULL,3,'黄色-四季款',40,3623,'img/product/sort_lg/sort3_5.jpg','img/product/sort_sm/sort3_5.jpg'),
(NULL,3,'黄色-四季款',41,4123,'img/product/sort_lg/sort3_5.jpg','img/product/sort_sm/sort3_5.jpg'),
(NULL,3,'黄色-四季款',42,3251,'img/product/sort_lg/sort3_5.jpg','img/product/sort_sm/sort3_5.jpg'),
(NULL,3,'黄色-四季款',43,3659,'img/product/sort_lg/sort3_5.jpg','img/product/sort_sm/sort3_5.jpg'),
(NULL,3,'黑色-四季款',39,3654,'img/product/sort_lg/sort3_6.jpg','img/product/sort_sm/sort3_6.jpg'),
(NULL,3,'黑色-四季款',40,4051,'img/product/sort_lg/sort3_6.jpg','img/product/sort_sm/sort3_6.jpg'),
(NULL,3,'黑色-四季款',41,3152,'img/product/sort_lg/sort3_6.jpg','img/product/sort_sm/sort3_6.jpg'),
(NULL,3,'黑色-四季款',42,2857,'img/product/sort_lg/sort3_6.jpg','img/product/sort_sm/sort3_6.jpg'),
(NULL,3,'黑色-四季款',43,3254,'img/product/sort_lg/sort3_6.jpg','img/product/sort_sm/sort3_6.jpg'),
(NULL,4,'卡其色',39,3215,'img/product/sort_lg/sort4_1.jpg','img/product/sort_sm/sort4_1.jpg'),
(NULL,4,'卡其色',40,3098,'img/product/sort_lg/sort4_1.jpg','img/product/sort_sm/sort4_1.jpg'),
(NULL,4,'卡其色',41,3292,'img/product/sort_lg/sort4_1.jpg','img/product/sort_sm/sort4_1.jpg'),
(NULL,4,'卡其色',42,3112,'img/product/sort_lg/sort4_1.jpg','img/product/sort_sm/sort4_1.jpg'),
(NULL,4,'卡其色',43,3154,'img/product/sort_lg/sort4_1.jpg','img/product/sort_sm/sort4_1.jpg'),
(NULL,4,'黑色',39,3215,'img/product/sort_lg/sort4_2.jpg','img/product/sort_sm/sort4_2.jpg'),
(NULL,4,'黑色',40,3098,'img/product/sort_lg/sort4_2.jpg','img/product/sort_sm/sort4_2.jpg'),
(NULL,4,'黑色',41,3292,'img/product/sort_lg/sort4_2.jpg','img/product/sort_sm/sort4_2.jpg'),
(NULL,4,'黑色',42,3112,'img/product/sort_lg/sort4_2.jpg','img/product/sort_sm/sort4_2.jpg'),
(NULL,4,'黑色',43,3154,'img/product/sort_lg/sort4_2.jpg','img/product/sort_sm/sort4_2.jpg'),
(NULL,4,'灰色',39,3215,'img/product/sort_lg/sort4_3.jpg','img/product/sort_sm/sort4_3.jpg'),
(NULL,4,'灰色',40,3098,'img/product/sort_lg/sort4_3.jpg','img/product/sort_sm/sort4_3.jpg'),
(NULL,4,'灰色',41,3292,'img/product/sort_lg/sort4_3.jpg','img/product/sort_sm/sort4_3.jpg'),
(NULL,4,'灰色',42,3112,'img/product/sort_lg/sort4_3.jpg','img/product/sort_sm/sort4_3.jpg'),
(NULL,4,'灰色',43,3154,'img/product/sort_lg/sort4_3.jpg','img/product/sort_sm/sort4_3.jpg'),
(NULL,4,'绿色',39,3215,'img/product/sort_lg/sort4_4.jpg','img/product/sort_sm/sort4_4.jpg'),
(NULL,4,'绿色',40,3098,'img/product/sort_lg/sort4_4.jpg','img/product/sort_sm/sort4_4.jpg'),
(NULL,4,'绿色',41,3292,'img/product/sort_lg/sort4_4.jpg','img/product/sort_sm/sort4_4.jpg'),
(NULL,4,'绿色',42,3112,'img/product/sort_lg/sort4_4.jpg','img/product/sort_sm/sort4_4.jpg'),
(NULL,4,'绿色',43,3154,'img/product/sort_lg/sort4_4.jpg','img/product/sort_sm/sort4_4.jpg'),
(NULL,5,'白黑',39,3215,'img/product/sort_lg/sort5_1.jpg','img/product/sort_sm/sort5_1.jpg'),
(NULL,5,'白黑',40,3098,'img/product/sort_lg/sort5_1.jpg','img/product/sort_sm/sort5_1.jpg'),
(NULL,5,'白黑',41,3292,'img/product/sort_lg/sort5_1.jpg','img/product/sort_sm/sort5_1.jpg'),
(NULL,5,'白黑',42,3112,'img/product/sort_lg/sort5_1.jpg','img/product/sort_sm/sort5_1.jpg'),
(NULL,5,'白黑',43,3154,'img/product/sort_lg/sort5_1.jpg','img/product/sort_sm/sort5_1.jpg'),
(NULL,5,'白灰',39,3215,'img/product/sort_lg/sort5_2.jpg','img/product/sort_sm/sort5_2.jpg'),
(NULL,5,'白灰',40,3098,'img/product/sort_lg/sort5_2.jpg','img/product/sort_sm/sort5_2.jpg'),
(NULL,5,'白灰',41,3292,'img/product/sort_lg/sort5_2.jpg','img/product/sort_sm/sort5_2.jpg'),
(NULL,5,'白灰',42,3112,'img/product/sort_lg/sort5_2.jpg','img/product/sort_sm/sort5_2.jpg'),
(NULL,5,'白灰',43,3154,'img/product/sort_lg/sort5_2.jpg','img/product/sort_sm/sort5_2.jpg'),
(NULL,5,'白/黑-加绒款',39,3215,'img/product/sort_lg/sort5_3.jpg','img/product/sort_sm/sort5_3.jpg'),
(NULL,5,'白/黑-加绒款',40,3098,'img/product/sort_lg/sort5_3.jpg','img/product/sort_sm/sort5_3.jpg'),
(NULL,5,'白/黑-加绒款',41,3292,'img/product/sort_lg/sort5_3.jpg','img/product/sort_sm/sort5_3.jpg'),
(NULL,5,'白/黑-加绒款',42,3112,'img/product/sort_lg/sort5_3.jpg','img/product/sort_sm/sort5_3.jpg'),
(NULL,5,'白/黑-加绒款',43,3154,'img/product/sort_lg/sort5_3.jpg','img/product/sort_sm/sort5_3.jpg'),
(NULL,5,'白/灰-加绒款',39,3215,'img/product/sort_lg/sort5_4.jpg','img/product/sort_sm/sort5_4.jpg'),
(NULL,5,'白/灰-加绒款',40,3098,'img/product/sort_lg/sort5_4.jpg','img/product/sort_sm/sort5_4.jpg'),
(NULL,5,'白/灰-加绒款',41,3292,'img/product/sort_lg/sort5_4.jpg','img/product/sort_sm/sort5_4.jpg'),
(NULL,5,'白/灰-加绒款',42,3112,'img/product/sort_lg/sort5_4.jpg','img/product/sort_sm/sort5_4.jpg'),
(NULL,5,'白/灰-加绒款',43,3154,'img/product/sort_lg/sort5_4.jpg','img/product/sort_sm/sort5_4.jpg'),
(NULL,6,'白/深蓝',39,3215,'img/product/sort_lg/sort6_1.jpg','img/product/sort_sm/sort6_1.jpg'),
(NULL,6,'白/深蓝',40,3098,'img/product/sort_lg/sort6_1.jpg','img/product/sort_sm/sort6_1.jpg'),
(NULL,6,'白/深蓝',41,3292,'img/product/sort_lg/sort6_1.jpg','img/product/sort_sm/sort6_1.jpg'),
(NULL,6,'白/深蓝',42,3112,'img/product/sort_lg/sort6_1.jpg','img/product/sort_sm/sort6_1.jpg'),
(NULL,6,'白/深蓝',43,3154,'img/product/sort_lg/sort6_1.jpg','img/product/sort_sm/sort6_1.jpg'),
(NULL,6,'白/红',39,3215,'img/product/sort_lg/sort6_2.jpg','img/product/sort_sm/sort6_2.jpg'),
(NULL,6,'白/红',40,3098,'img/product/sort_lg/sort6_2.jpg','img/product/sort_sm/sort6_2.jpg'),
(NULL,6,'白/红',41,3292,'img/product/sort_lg/sort6_2.jpg','img/product/sort_sm/sort6_2.jpg'),
(NULL,6,'白/红',42,3112,'img/product/sort_lg/sort6_2.jpg','img/product/sort_sm/sort6_2.jpg'),
(NULL,6,'白/红',43,3154,'img/product/sort_lg/sort6_2.jpg','img/product/sort_sm/sort6_2.jpg'),
(NULL,6,'黑/白',39,3215,'img/product/sort_lg/sort6_3.jpg','img/product/sort_sm/sort6_3.jpg'),
(NULL,6,'黑/白',40,3098,'img/product/sort_lg/sort6_3.jpg','img/product/sort_sm/sort6_3.jpg'),
(NULL,6,'黑/白',41,3292,'img/product/sort_lg/sort6_3.jpg','img/product/sort_sm/sort6_3.jpg'),
(NULL,6,'黑/白',42,3112,'img/product/sort_lg/sort6_3.jpg','img/product/sort_sm/sort6_3.jpg'),
(NULL,6,'黑/白',43,3154,'img/product/sort_lg/sort6_3.jpg','img/product/sort_sm/sort6_3.jpg'),
(NULL,6,'白/黑',39,3215,'img/product/sort_lg/sort6_4.jpg','img/product/sort_sm/sort6_4.jpg'),
(NULL,6,'白/黑',40,3098,'img/product/sort_lg/sort6_4.jpg','img/product/sort_sm/sort6_4.jpg'),
(NULL,6,'白/黑',41,3292,'img/product/sort_lg/sort6_4.jpg','img/product/sort_sm/sort6_4.jpg'),
(NULL,6,'白/黑',42,3112,'img/product/sort_lg/sort6_4.jpg','img/product/sort_sm/sort6_4.jpg'),
(NULL,6,'白/黑',43,3154,'img/product/sort_lg/sort6_4.jpg','img/product/sort_sm/sort6_4.jpg'),
(NULL,7,'标准黑/标准白',39,3215,'img/product/sort_lg/sort7_1.jpg','img/product/sort_sm/sort7_1.jpg'),
(NULL,7,'标准黑/标准白',40,3098,'img/product/sort_lg/sort7_1.jpg','img/product/sort_sm/sort7_1.jpg'),
(NULL,7,'标准黑/标准白',41,3292,'img/product/sort_lg/sort7_1.jpg','img/product/sort_sm/sort7_1.jpg'),
(NULL,7,'标准黑/标准白',42,3112,'img/product/sort_lg/sort7_1.jpg','img/product/sort_sm/sort7_1.jpg'),
(NULL,7,'标准黑/标准白',43,3154,'img/product/sort_lg/sort7_1.jpg','img/product/sort_sm/sort7_1.jpg'),
(NULL,7,'标准白/冰川灰',39,3215,'img/product/sort_lg/sort7_2.jpg','img/product/sort_sm/sort7_2.jpg'),
(NULL,7,'标准白/冰川灰',40,3098,'img/product/sort_lg/sort7_2.jpg','img/product/sort_sm/sort7_2.jpg'),
(NULL,7,'标准白/冰川灰',41,3292,'img/product/sort_lg/sort7_2.jpg','img/product/sort_sm/sort7_2.jpg'),
(NULL,7,'标准白/冰川灰',42,3112,'img/product/sort_lg/sort7_2.jpg','img/product/sort_sm/sort7_2.jpg'),
(NULL,7,'标准白/冰川灰',43,3154,'img/product/sort_lg/sort7_2.jpg','img/product/sort_sm/sort7_2.jpg'),
(NULL,7,'莲紫色/阴沉灰',39,3215,'img/product/sort_lg/sort7_3.jpg','img/product/sort_sm/sort7_3.jpg'),
(NULL,7,'莲紫色/阴沉灰',40,3098,'img/product/sort_lg/sort7_3.jpg','img/product/sort_sm/sort7_3.jpg'),
(NULL,7,'莲紫色/阴沉灰',41,3292,'img/product/sort_lg/sort7_3.jpg','img/product/sort_sm/sort7_3.jpg'),
(NULL,7,'莲紫色/阴沉灰',42,3112,'img/product/sort_lg/sort7_3.jpg','img/product/sort_sm/sort7_3.jpg'),
(NULL,7,'莲紫色/阴沉灰',43,3154,'img/product/sort_lg/sort7_3.jpg','img/product/sort_sm/sort7_3.jpg'),
(NULL,8,'标准黑/公牛红/标准白',39,3215,'img/product/sort_lg/sort8_1.jpg','img/product/sort_sm/sort8_1.jpg'),
(NULL,8,'标准黑/公牛红/标准白',40,3098,'img/product/sort_lg/sort8_1.jpg','img/product/sort_sm/sort8_1.jpg'),
(NULL,8,'标准黑/公牛红/标准白',41,3292,'img/product/sort_lg/sort8_1.jpg','img/product/sort_sm/sort8_1.jpg'),
(NULL,8,'标准黑/公牛红/标准白',42,3112,'img/product/sort_lg/sort8_1.jpg','img/product/sort_sm/sort8_1.jpg'),
(NULL,8,'标准黑/公牛红/标准白',43,3154,'img/product/sort_lg/sort8_1.jpg','img/product/sort_sm/sort8_1.jpg'),
(NULL,8,'光芒蓝/冰橙色/标准白',39,3215,'img/product/sort_lg/sort8_2.jpg','img/product/sort_sm/sort8_2.jpg'),
(NULL,8,'光芒蓝/冰橙色/标准白',40,3098,'img/product/sort_lg/sort8_2.jpg','img/product/sort_sm/sort8_2.jpg'),
(NULL,8,'光芒蓝/冰橙色/标准白',41,3292,'img/product/sort_lg/sort8_2.jpg','img/product/sort_sm/sort8_2.jpg'),
(NULL,8,'光芒蓝/冰橙色/标准白',42,3112,'img/product/sort_lg/sort8_2.jpg','img/product/sort_sm/sort8_2.jpg'),
(NULL,8,'光芒蓝/冰橙色/标准白',43,3154,'img/product/sort_lg/sort8_2.jpg','img/product/sort_sm/sort8_2.jpg'),
(NULL,8,'新法国蓝/深宝蓝/冰川灰',39,3215,'img/product/sort_lg/sort8_3.jpg','img/product/sort_sm/sort8_3.jpg'),
(NULL,8,'新法国蓝/深宝蓝/冰川灰',40,3098,'img/product/sort_lg/sort8_3.jpg','img/product/sort_sm/sort8_3.jpg'),
(NULL,8,'新法国蓝/深宝蓝/冰川灰',41,3292,'img/product/sort_lg/sort8_3.jpg','img/product/sort_sm/sort8_3.jpg'),
(NULL,8,'新法国蓝/深宝蓝/冰川灰',42,3112,'img/product/sort_lg/sort8_3.jpg','img/product/sort_sm/sort8_3.jpg'),
(NULL,8,'新法国蓝/深宝蓝/冰川灰',43,3154,'img/product/sort_lg/sort8_3.jpg','img/product/sort_sm/sort8_3.jpg'),
(NULL,9,'黑色/银色',39,19853,'img/product/sort_lg/sort9_1.jpg','img/product/sort_sm/sort9_1.jpg'),
(NULL,9,'黑色/银色',40,15664,'img/product/sort_lg/sort9_1.jpg','img/product/sort_sm/sort9_1.jpg'),
(NULL,9,'黑色/银色',41,15753,'img/product/sort_lg/sort9_1.jpg','img/product/sort_sm/sort9_1.jpg'),
(NULL,9,'黑色/银色',42,15643,'img/product/sort_lg/sort9_1.jpg','img/product/sort_sm/sort9_1.jpg'),
(NULL,9,'黑色/银色',43,9953,'img/product/sort_lg/sort9_1.jpg','img/product/sort_sm/sort9_1.jpg'),
(NULL,9,'新乔丹红/白色',39,19855,'img/product/sort_lg/sort9_2.jpg','img/product/sort_sm/sort9_2.jpg'),
(NULL,9,'新乔丹红/白色',40,12424,'img/product/sort_lg/sort9_2.jpg','img/product/sort_sm/sort9_2.jpg'),
(NULL,9,'新乔丹红/白色',41,19656,'img/product/sort_lg/sort9_2.jpg','img/product/sort_sm/sort9_2.jpg'),
(NULL,9,'新乔丹红/白色',42,18768,'img/product/sort_lg/sort9_2.jpg','img/product/sort_sm/sort9_2.jpg'),
(NULL,9,'新乔丹红/白色',43,7667,'img/product/sort_lg/sort9_2.jpg','img/product/sort_sm/sort9_2.jpg'),
(NULL,9,'深藏青/新乔丹红',39,8224,'img/product/sort_lg/sort9_3.jpg','img/product/sort_sm/sort9_3.jpg'),
(NULL,9,'深藏青/新乔丹红',40,15644,'img/product/sort_lg/sort9_3.jpg','img/product/sort_sm/sort9_3.jpg'),
(NULL,9,'深藏青/新乔丹红',41,9976,'img/product/sort_lg/sort9_3.jpg','img/product/sort_sm/sort9_3.jpg'),
(NULL,9,'深藏青/新乔丹红',42,9988,'img/product/sort_lg/sort9_3.jpg','img/product/sort_sm/sort9_3.jpg'),
(NULL,9,'深藏青/新乔丹红',43,15567,'img/product/sort_lg/sort9_3.jpg','img/product/sort_sm/sort9_3.jpg'),
(NULL,10,'黑色/银色',39,146,'img/product/sort_lg/sort10_1.jpg','img/product/sort_sm/sort10_1.jpg'),
(NULL,10,'黑色/银色',40,171,'img/product/sort_lg/sort10_1.jpg','img/product/sort_sm/sort10_1.jpg'),
(NULL,10,'黑色/银色',41,245,'img/product/sort_lg/sort10_1.jpg','img/product/sort_sm/sort10_1.jpg'),
(NULL,10,'黑色/银色',42,63,'img/product/sort_lg/sort10_1.jpg','img/product/sort_sm/sort10_1.jpg'),
(NULL,10,'黑色/银色',43,343,'img/product/sort_lg/sort10_1.jpg','img/product/sort_sm/sort10_1.jpg'),
(NULL,10,'黑色/乔丹红',39,622,'img/product/sort_lg/sort10_2.jpg','img/product/sort_sm/sort10_2.jpg'),
(NULL,10,'黑色/乔丹红',40,385,'img/product/sort_lg/sort10_2.jpg','img/product/sort_sm/sort10_2.jpg'),
(NULL,10,'黑色/乔丹红',41,344,'img/product/sort_lg/sort10_2.jpg','img/product/sort_sm/sort10_2.jpg'),
(NULL,10,'黑色/乔丹红',42,178,'img/product/sort_lg/sort10_2.jpg','img/product/sort_sm/sort10_2.jpg'),
(NULL,10,'黑色/乔丹红',43,244,'img/product/sort_lg/sort10_2.jpg','img/product/sort_sm/sort10_2.jpg'),
(NULL,10,'芒果黄/冰蓝',39,356,'img/product/sort_lg/sort10_3.jpg','img/product/sort_sm/sort10_3.jpg'),
(NULL,10,'芒果黄/冰蓝',40,546,'img/product/sort_lg/sort10_3.jpg','img/product/sort_sm/sort10_3.jpg'),
(NULL,10,'芒果黄/冰蓝',41,178,'img/product/sort_lg/sort10_3.jpg','img/product/sort_sm/sort10_3.jpg'),
(NULL,10,'芒果黄/冰蓝',42,455,'img/product/sort_lg/sort10_3.jpg','img/product/sort_sm/sort10_3.jpg'),
(NULL,10,'芒果黄/冰蓝',43,349,'img/product/sort_lg/sort10_3.jpg','img/product/sort_sm/sort10_3.jpg'),
(NULL,11,'黑/浅灰/安踏白-8',39,43,'img/product/sort_lg/sort11_1.jpg','img/product/sort_sm/sort11_1.jpg'),
(NULL,11,'黑/浅灰/安踏白-8',40,85,'img/product/sort_lg/sort11_1.jpg','img/product/sort_sm/sort11_1.jpg'),
(NULL,11,'黑/浅灰/安踏白-8',41,255,'img/product/sort_lg/sort11_1.jpg','img/product/sort_sm/sort11_1.jpg'),
(NULL,11,'黑/浅灰/安踏白-8',42,243,'img/product/sort_lg/sort11_1.jpg','img/product/sort_sm/sort11_1.jpg'),
(NULL,11,'黑/浅灰/安踏白-8',43,276,'img/product/sort_lg/sort11_1.jpg','img/product/sort_sm/sort11_1.jpg'),
(NULL,11,'黑/冷灰-7',39,101,'img/product/sort_lg/sort11_2.jpg','img/product/sort_sm/sort11_2.jpg'),
(NULL,11,'黑/冷灰-7',40,343,'img/product/sort_lg/sort11_2.jpg','img/product/sort_sm/sort11_2.jpg'),
(NULL,11,'黑/冷灰-7',41,111,'img/product/sort_lg/sort11_2.jpg','img/product/sort_sm/sort11_2.jpg'),
(NULL,11,'黑/冷灰-7',42,232,'img/product/sort_lg/sort11_2.jpg','img/product/sort_sm/sort11_2.jpg'),
(NULL,11,'黑/冷灰-7',43,566,'img/product/sort_lg/sort11_2.jpg','img/product/sort_sm/sort11_2.jpg'),
(NULL,12,'白色',39,322,'img/product/sort_lg/sort12_1.jpg','img/product/sort_sm/sort12_1.jpg'),
(NULL,12,'白色',40,412,'img/product/sort_lg/sort12_1.jpg','img/product/sort_sm/sort12_1.jpg'),
(NULL,12,'白色',41,465,'img/product/sort_lg/sort12_1.jpg','img/product/sort_sm/sort12_1.jpg'),
(NULL,12,'白色',42,123,'img/product/sort_lg/sort12_1.jpg','img/product/sort_sm/sort12_1.jpg'),
(NULL,12,'白色',43,244,'img/product/sort_lg/sort12_1.jpg','img/product/sort_sm/sort12_1.jpg'),
(NULL,12,'黑色',39,322,'img/product/sort_lg/sort12_2.jpg','img/product/sort_sm/sort12_2.jpg'),
(NULL,12,'黑色',40,142,'img/product/sort_lg/sort12_2.jpg','img/product/sort_sm/sort12_2.jpg'),
(NULL,12,'黑色',41,533,'img/product/sort_lg/sort12_2.jpg','img/product/sort_sm/sort12_2.jpg'),
(NULL,12,'黑色',42,231,'img/product/sort_lg/sort12_2.jpg','img/product/sort_sm/sort12_2.jpg'),
(NULL,12,'黑色',43,211,'img/product/sort_lg/sort12_2.jpg','img/product/sort_sm/sort12_2.jpg'),
(NULL,12,'玫瑰金',39,322,'img/product/sort_lg/sort12_3.jpg','img/product/sort_sm/sort12_3.jpg'),
(NULL,12,'玫瑰金',40,127,'img/product/sort_lg/sort12_3.jpg','img/product/sort_sm/sort12_3.jpg'),
(NULL,12,'玫瑰金',41,141,'img/product/sort_lg/sort12_3.jpg','img/product/sort_sm/sort12_3.jpg'),
(NULL,12,'玫瑰金',42,232,'img/product/sort_lg/sort12_3.jpg','img/product/sort_sm/sort12_3.jpg'),
(NULL,12,'玫瑰金',43,654,'img/product/sort_lg/sort12_3.jpg','img/product/sort_sm/sort12_3.jpg');


/**用户信息**/
INSERT INTO shoes_user VALUES
(NULL, 'dingding', '123456', 'ding@qq.com', '13501234567', 'img/avatar/default.png', '丁伟', '1'),
(NULL, 'dangdang', '123456', 'dang@qq.com', '13501234568', 'img/avatar/default.png', '林当', '1'),
(NULL, 'doudou', '123456', 'dou@qq.com', '13501234569', 'img/avatar/default.png', '窦志强', '1'),
(NULL, 'yaya', '123456', 'ya@qq.com', '13501234560', 'img/avatar/default.png', '秦小雅', '0');

/****首页轮播广告商品****/
INSERT INTO shoes_index_carousel VALUES
(NULL, 'img/index/banner1.jpg','轮播广告商品1','detail.html?pid=1'),
(NULL, 'img/index/banner2.jpg','轮播广告商品2','detail.html?pid=2'),
(NULL, 'img/index/banner3.jpg','轮播广告商品3','detail.html?pid=3'),
(NULL, 'img/index/banner4.jpg','轮播广告商品4','detail.html?pid=4');

/****首页商品****/
INSERT INTO shoes_index_product VALUES
(NULL, '匹克休闲鞋男鞋', '匹克休闲鞋男鞋2019冬季新款低帮耐磨复古皮革拼接运动鞋老爹鞋男', 'img/product/pro_img/pro_1.jpg', 209, 'detail.html?pid=1', 1, 1, 1),
(NULL, '匹克态极小白鞋', '匹克态极小白鞋一尘低帮板鞋运动鞋男轻便时尚滑板鞋平底休闲鞋', 'img/product/pro_img/pro_2.jpg', 359, 'detail.html?pid=2', 2, 2, 2),
(NULL, '马丁靴男冬季加绒保暖英伦高帮鞋子', '酷睿双核i7处理器|256GB SSD|4GB内存|英特尔HD显卡680M', 'img/product/pro_img/pro_3.jpg', 308, 'detail.html?pid=3', 3, 3, 3),
(NULL, '帕达索男鞋', '酷睿双核i5处理器|512GB SSD|4GB内存|英特尔HD游戏级显卡', 'img/product/pro_img/pro_4.jpg', 536, 'detail.html?pid=4', 4, 4, 4),
(NULL, '回力女鞋', '酷睿双核i7处理器|1TGB SSD|8GB内存|英特尔HD显卡620含共享显卡内存', 'img/product/pro_img/pro_5.jpg', 99, 'detail.html?pid=5', 5, 5, 5),
(NULL, '回力帆布鞋', '酷睿双核i5处理器|512GB SSD|2GB内存|英特尔HD显卡', 'img/product/pro_img/pro_6.jpg', 89, 'detail.html?pid=6', 6, 6, 6),
(NULL, '神州战神Z7M 高性价比游戏本', '酷睿双核i7处理器|1TGB SSD|8GB内存|英特尔HD游戏机独立显卡', 'img/product/pro_img/pro_7.jpg', 5799, 'detail.html?pid=7', 0, 0, 0);

