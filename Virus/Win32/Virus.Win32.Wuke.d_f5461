<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>MarketPlace of i168.net</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="../mp_image/mp.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--



function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
//-->
</script>
<script language="JavaScript" type="text/JavaScript">
<!--



function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
//-->
</script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-right: 0px;
}
.style2 {color: #84D534}
.style3 {color: #CC0000}
-->
</style>
</head>

<body topmargin="0" marginheight="0">
<center>
  <center>
    <script>
// 延遲快選單消失
var delay_func = '';  
function setdelay(func){
	if (func == delay_func){
		clearTimeout(bdelay);
	}
	else{
		rundelay();	
	}
	bdelay = setTimeout(func,400)
	delay_func = func;
}
	
function rundelay(){
	if (typeof(bdelay)=='number'){
		clearTimeout(bdelay);
		eval(delay_func);
		delay_func = '';
	}	
}

function cleardelay(){
	if (typeof(bdelay)=='number'){
		clearTimeout(bdelay);
	}	
}

function showShadowLayers(vid,p,v,vshadow,MaskN,vMask) {  
	if(!document.getElementById(vid)){return;}
	//----遮住select
	if (vMask){
	  	vMask = document.getElementById(vMask)
	}else{
	    if (document.getElementById("iMask")){vMask = document.getElementById("iMask") }
	}
	if(v=='show'){
		vv='visible'
	}else{
		if(v=='hide'){
			vv='hidden'
		}
	}
	//v=(v=='show')?'visible':(v=='hide')?'hidden':v;
	if (document.getElementById(vid).style.visibility==vv){return;}	
	document.getElementById(vid).style.visibility=vv;
	if (vMask && MaskN=='N') {
		vMask.style.visibility='hidden';
	}
	else{
		vMask.style.visibility=vv;
	}
	
}

function showShadowLayers1(vid,p,v,vshadow) {  
	if(!document.getElementById(vid)){return;}
	v=(v=='show')?'':(v=='hide')?'none':v;
	if (document.getElementById(vid).style.display==v){return;}	
	document.getElementById(vid).style.display=v;
	//if (vshadow){vshadow.style.display=v;}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}


function resize_shadow(vobj,vshadow,vshadow_img,vshow_dir){
  if (typeof(vshadow)=='object'){
  	//陰影位置  
  	vshadow_img.width = vobj.offsetWidth;
  	vshadow_img.height = vobj.offsetHeight;
  	if (vshow_dir=='up'){
  		vshadow.style.left = vobj.offsetLeft+3;
  		vshadow.style.top = vobj.offsetTop-3;
  	}
  	else{
  		vshadow.style.left = vobj.offsetLeft+3;
  		vshadow.style.top = vobj.offsetTop+1;
  	}
  }
}

function set_position(vobj,vsrc_obj,vpar_obj,vsrc_pos,vtar_pos,vshadow,vshadow_img , vshow_dir ,vMask)
{

   if(!vobj){return;}
   rundelay();
   
   if (typeof(vsrc_obj) !='undefined' & typeof(vsrc_obj) !='string' ) 
      // 有主物件作為定位依據
   {
      var vwidth , vheight
      var vtop , vleft
      vwidth = 0;
      vheight = 0;
      vtop = 0;
      vleft = 0;
      
      //累加 Parent object 的座標
      par = vsrc_obj.offsetParent;
      while(par)
      {
         vtop = vtop + par.offsetTop;
         vleft = vleft + par.offsetLeft;
         par = par.offsetParent;
      }

      if (typeof(vpar_obj) == 'object')
      {
         vtop = vtop + vpar_obj.offsetTop
         vleft = vleft + vpar_obj.offsetLeft
      }

      switch (vsrc_pos )
      {
         case 'topleft'  : break;
         case 'topright' : vwidth = vsrc_obj.offsetWidth; break;         
         case 'bottomleft' : vheight = vsrc_obj.offsetHeight; break;             
         case 'bottomright' : vwidth = vsrc_obj.offsetWidth; vheight = vsrc_obj.offsetHeight; break;             
         default :
      }
      if (vtar_pos == 'right')
         { vwidth = vwidth - vobj.offsetWidth; }

	 

	 if (vshow_dir=='up')
	 	vtop = vtop - vobj.offsetHeight

      vobj.style.left = vsrc_obj.offsetLeft + vleft + vwidth;
      vobj.style.top = vsrc_obj.offsetTop + vtop + vheight;
      //----遮住select
	  if (vMask){
	  	vMask = document.getElementById(vMask)
	  }
	  else {
	    if (document.getElementById("iMask")){vMask = document.getElementById("iMask") }
	  }
	  
      if (vMask){
	    vMask.style.left = vobj.style.left;
    	vMask.style.top = vobj.style.top;
      	vMask.style.width = vobj.offsetWidth;
      	vMask.style.height = vobj.offsetHeight;
      }
	//--------------
      return;   
   }

   // 以滑鼠座標作為定位依據
   if ( event.clientX + vobj.offsetWidth - 5 > document.body.clientWidth){
      vobj.style.left = event.clientX - vobj.offsetWidth + document.body.scrollLeft
      }
   else{
      vobj.style.left = event.clientX-5 + document.body.scrollLeft   
   }
   
   if ( event.clientY + vobj.offsetHeight - 5 > document.body.clientHeight){
      vobj.style.top = event.clientY - vobj.offsetHeight + document.body.scrollTop+5
   }
   else{
      vobj.style.top = event.clientY-5 + document.body.scrollTop
   }
	
}
</script>
<iframe id="iMask" src="javascript:void(0)" style="BORDER:solid 0px #999999;position:absolute; left:-300px; top:-300px; z-index:0;" frameborder="0"></iframe>
<iframe id="iMask1" src="javascript:void(0)" style="BORDER:solid 0px #999999;position:absolute; left:-300px; top:-300px; z-index:0;" frameborder="0"></iframe>

<center>
<script type="text/javascript" src="/function/flashobject.js"></script>

<table width="910" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="2" valign="top" align=right>
            	
    	<table border="0" align="right" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
	      <tr align="center" height="22">
	        <td><img src="/Template/Default/mp_image/mp1024-01_02.gif"></td>
	        <td width="70"><a href="/Template/Default/marketplace/cart.asp" class="font12-grey-333">購物車</a></td>
	        <td><img src="/Template/Default/mp_image/mp1024-01_04.gif"></td>
	        <td width="70"><a href="/Template/Default/marketplace/my_account.asp?rtn_urlx=/template/Default/marketplace/Ad_Service_04.asp?"  class="font12-grey-333">我的帳戶</a></td>
	        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_04.gif"></td>
	        <!-- <td width="70"><a href="/Template/Default/marketplace/itake_balance.asp" class="font12-grey-333">iTake</a></td>
	        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_04.gif"></td> -->
	        <td width="70"><a href="/Template/Default/marketplace/login.asp?rtn_urlx=/template/Default/marketplace/Ad_Service_04.asp?" class="font12-grey-333">登入 / 加入 </a></td>
	        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_06.gif"></td>		      
    
		     
        </tr>
      </table>	    
    </td>
  </tr>
  <tr>
    <td width="400" height="65" >
      
      	<a href="/Template/Default/marketplace/index.asp"><img src="/Template/Default/mp_image/mp1024-01_08.gif" border="0" align="absmiddle"></a></td>
      
    <td valign="bottom"><table width="100%" border="0" align="right" cellpadding="0" cellspacing="0">
      <tr>
      	<td width="3"><img src="/Template/Default/mp_image/mp1024-01_14.gif" width="3" height="15"></td>
      	<td width="110"><div align="center"> <span class="font12-grey-666-Arial"> <a href="/template/default/marketstore/index.htm" class="font12-grey-666-Arial"> MarketPlace市集</a></span></div></td>
		<td width="3"><img src="/Template/Default/mp_image/mp1024-01_14.gif" width="3" height="15"></td>
      	<td width="110"><div align="center"><img src="/Template/Default/mp_image/pedia/icon_10.gif" width="21" height="17" align="absmiddle"> <span class="font12-grey-666-Arial"> <a href="/template/default/marketpedia/index.asp" class="font12-grey-666-Arial"> MarketPedia</a></span></div></td>
        <td width="3"><img src="/Template/Default/mp_image/mp1024-01_14.gif" width="3" height="15"></td>
        <td width="100" height="25"><p align="center"><img src="/Template/Default/mp_image/mp1024-01_16.gif" width="15" height="15" align="absmiddle"> <span class="font12-grey-666"><a href="/Template/Default/marketplace/who_speak.asp" class="font12-grey-666">看誰在說話</a></span></p></td>
        <td width="3"><img src="/Template/Default/mp_image/mp1024-01_14.gif" width="3" height="15"></td>
        <td width="110"><div align="center"><img src="/Template/Default/mp_image/mp1024-01_18.gif" width="15" height="15" align="absmiddle"> <span class="font12-grey-666" onclick="window.external.AddFavorite('http://marketplace.i168.net/Template/Default/marketplace/index.asp', 'Marketplace of i168.net')" style="cursor:pointer">加入我的最愛</span> </div></td>
        <td width="3"><img src="/Template/Default/mp_image/mp1024-01_14.gif" width="3" height="15"></td>
        <td width="90"><div align="center"><img src="/Template/Default/mp_image/mp1024-01_20.gif" width="17" height="15" align="absmiddle"> 
        	
        		<a href="/template/Default/marketplace/advanced_search.asp?ck=first_in&cate_ch=&mall="><span class="font12-grey-666">進階搜尋</span></a>
        	 
        </div></td>
        <td width="3"><img src="/Template/Default/mp_image/mp1024-01_14.gif" width="3" height="15"></td>
      </tr>
    </table></td>
  </tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td background="/Template/Default/mp_image/mp1024-01_29.gif">
	    <table width="910" border="0" align="center" cellpadding="0" cellspacing="0">
	      <tr>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477629"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477629'" 
					onMouseOver="show_pid2('1477629')"
					onMouseOut=setdelay("showShadowLayers('smenu1477629','','hide','','','iMask')") >
		        	<div align="center">時尚精品</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477835"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477835'" 
					onMouseOver="show_pid2('1477835')"
					onMouseOut=setdelay("showShadowLayers('smenu1477835','','hide','','','iMask')") >
		        	<div align="center">美容保養</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477834"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477834'" 
					onMouseOver="show_pid2('1477834')"
					onMouseOut=setdelay("showShadowLayers('smenu1477834','','hide','','','iMask')") >
		        	<div align="center">服飾配件</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477628"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477628'" 
					onMouseOver="show_pid2('1477628')"
					onMouseOut=setdelay("showShadowLayers('smenu1477628','','hide','','','iMask')") >
		        	<div align="center">數位資訊</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477838"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477838'" 
					onMouseOver="show_pid2('1477838')"
					onMouseOut=setdelay("showShadowLayers('smenu1477838','','hide','','','iMask')") >
		        	<div align="center">家用電器</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477836"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477836'" 
					onMouseOver="show_pid2('1477836')"
					onMouseOut=setdelay("showShadowLayers('smenu1477836','','hide','','','iMask')") >
		        	<div align="center">居家生活</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477839"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477839'" 
					onMouseOver="show_pid2('1477839')"
					onMouseOut=setdelay("showShadowLayers('smenu1477839','','hide','','','iMask')") >
		        	<div align="center">風味美食</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477841"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477841'" 
					onMouseOver="show_pid2('1477841')"
					onMouseOut=setdelay("showShadowLayers('smenu1477841','','hide','','','iMask')") >
		        	<div align="center">圖書文具</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477837"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477837'" 
					onMouseOver="show_pid2('1477837')"
					onMouseOut=setdelay("showShadowLayers('smenu1477837','','hide','','','iMask')") >
		        	<div align="center">休閒育樂</div>
		        </td>
	      
		        <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>		        
		        <td id="mtds1477840"  class="font12-white" style="cursor:pointer; white-space:nowrap;" align="center" width="85" 
		        	onclick= "location='http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&parent_id=1477840'" 
					onMouseOver="show_pid2('1477840')"
					onMouseOut=setdelay("showShadowLayers('smenu1477840','','hide','','','iMask')") >
		        	<div align="center">就是二手</div>
		        </td>
	      
	      <td width="5"><img src="/Template/Default/mp_image/mp1024-01_31.gif" width="5" height="39"></td>
	      	      	
	      </tr>
	    </table>
    </td>
  </tr>
</table>
<script>var vpid2menu1477628='N;1477844;筆記型電腦 ;1477844;N;1477842;電腦零組件;1477842;N;1477843;電腦週邊 ;1477843;N;1477852;流行手機;1477852;N;1477853;手機週邊;1477853;N;1477882;數位相機&攝影機;1477882;N;1477860;MP3&儲存媒體;1477860;Y;1477766;PDA&GPS;1477766;Y;1477813;ㄧ般相機;1477813;Y;1477822;電視/掌上遊樂器;1477822;N;1477845;耗材;1477845'; var vpid2menu1477629='N;1477901;仕女包;1477901;N;1477902;紳士包;1477902;Y;3738255;文學;3738255;N;1477744;皮夾;1477744;N;1477731;鑰匙圈/包;1477731;N;1477906;風情項鍊;1477906;N;1477747;經典耳環;1477747;N;3734727;純金系列;3734727;N;1477905;濃情戒指;1477905;N;1477749;手環&手鍊;1477749;Y;1477682;胸針;1477682;N;1477748;髮飾;1477748;N;1477681;名筆;1477681;N;1477910;名片夾 ;1477910;N;1477904;時尚眼鏡 ;1477904;N;1477903;精緻錶類;1477903'; var vpid2menu1477834='N;1477923;女性服飾;1477923;N;1477982;高級女鞋;1477982;N;1477983;高級男鞋;1477983;N;1477924;男性服飾;1477924;N;1477947;可愛兒童區;1477947;N;1477783;襪子家族&鞋墊;1477783'; var vpid2menu1477835='N;1477967;男人味女人香;1477967;N;1477948;臉部清潔&保養;1477948;N;1477949;臉&眼&唇&手部彩妝;1477949;N;1477950;美髮&潔髮;1477950;N;1477799;精油&薰香;1477799;N;1477968;美體 ;1477968;N;1477960;隔離防曬 ;1477960;N;1477961;保養組合 ;1477961;Y;1477959;其他保養品 ;1477959'; var vpid2menu1477836='N;1477935;現代傢俱;1477935;N;1477939;真愛寢具;1477939;N;1477940;各式燈具;1477940;N;1477942;精選擺飾;1477942;N;1478044;傳遞浪漫;1478044;N;1478046;行家典藏;1478046;N;1477943;生活雜貨 ;1477943;N;1477941;衛浴用品 ;1477941;N;1477821;衛生用品;1477821;N;1477696;寶寶用品;1477696;N;1477938;廚房用具 ;1477938;N;1980608;學生用品;1980608;N;1477945;寵物生活 ;1477945;N;1477655;宗教百貨 ;1477655;N;1477946;防災&防盜;1477946;N;1477893;通訊家電;1477893'; var vpid2menu1477837='N;1477739;專業服務;1477739;N;1477666;運動用品;1477666;N;1478045;手工創作;1478045;N;1477702;休閒育樂;1477702;N;1477695;兒童趣味館;1477695;N;1477734;影音小品;1477734;N;1477654;汽機車百貨;1477654;Y;1477753;各式樂器;1477753;Y;1477823;另類收藏;1477823;Y;2054441;旅遊行程;2054441'; var vpid2menu1477838='N;1477861;影音視聽;1477861;N;1477864;生活家電 ;1477864;N;1477863;廚房家電 ;1477863;N;1477865;保健家電 ;1477865;N;1477659;美容家電;1477659'; var vpid2menu1477839='Y;1477727;素食主義;1477727;N;1478002;生鮮蔬果;1478002;N;1478007;料理美食;1478007;N;1478001;休閒食品 ;1478001;N;1478006;品味咖啡;1478006;N;1478005;飲料飲品 ;1478005;N;1478003;營養補給;1478003;N;1478004;伴手禮;1478004'; var vpid2menu1477840='N;1477736;二手精品;1477736;N;1477824;二手服飾配件;1477824;Y;1477751;二手3C;1477751;Y;1477738;二手書藉;1477738;Y;1477828;二手影音;1477828;Y;1477746;二手文具;1477746;Y;1477737;二手汽機車;1477737;Y;1477830;其他二手商品;1477830'; var vpid2menu1477841='N;1478063;商業理財;1478063;N;3738258;文學小說;3738258;N;3192552;心靈養生;3192552;N;3738259;人文科普;3738259;N;1478064;休閒娛樂;1478064;Y;1477653;少年童書 ;1477653;N;1478067;語言電腦;1478067;N;1477644;考試學測 ;1477644;Y;1477642;辭典工具 ;1477642;N;1478065;雜誌期刊;1478065;N;1477944;辦公&文具用品;1477944;Y;1477831;禮券;1477831'; </script>
<span id="divarea_level2"></span>
<span id="divarea_level3"></span>
<iframe name="level3frame" src="top_getcat.asp?mall=&src_mall=sys_tw" width="0" height="0" scrolling="no" border="0" frameborder="500" style="display:none"></iframe>

<script>
//var cursor_position
var hadshow=0
function nap(func, set_time){
	for(i=0; i<=set_time; i++){
		if(i==set_time){
			eval(func);
		}
	}
}



function mmover(vobj){ // 切換 menu 反白
	vobj.className = 'menu_h1';
}
function mmout(vobj){
	vobj.className = 'menu_d1';
}

//menu onclick 時 ,要執行的程式
function gocat_list( cid , pid ){
	location= 'http://marketplace.i168.net/template/default/marketplace/mp_list.asp?status=pro_list&category_id=' + cid + '&parent_id=' + pid
}

// 第二層 menu
function show_pid2(cid){
	//hadshow=eval('document.all.hadshow'+cid);
	
	var pid2 = 'vpid2menu' + cid
	if (!window[pid2]){return;}
	smenupid1m = 'smenu' + cid
	if (window[pid2]!='final'){ 
		pid2arr = window[pid2].split(';')

		menustr = " <div id='" + smenupid1m + "' class='menu_div1' "
		menustr = menustr + " onclick=showShadowLayers('" + smenupid1m + "','','hide','','','iMask'); "
		menustr = menustr + " onMouseOver=cleardelay();showShadowLayers('" + smenupid1m + "','','show','','','iMask'); "
		menustr = menustr + " onMouseOut=setdelay(\"showShadowLayers('" + smenupid1m +"','','hide','','','iMask')\");> "
		menustr = menustr + " <table cellpadding='1' cellspacing='0' class='menu_t1' width='100'> "
		menustr = menustr + " <col class='menu_d1 font12-grey-666'> "

		for (i = 0; i < pid2arr.length; i+=4) {
			var vpid2 = pid2arr[i+1]
			var vpid1 = ''
			if (pid2arr[i] !='Y'){
				vpid2 = ''
				vpid1 = pid2arr[i+3]
			}
			//menustr = menustr + " <TR onmouseover='mmover(this)' onmouseout='mmout(this);' ><TD height='26' onclick=gocat_list('" + vpid2 + "','" + vpid1 + "')>&nbsp;" + pid2arr[i+2] + "&nbsp;</TD>"
			if (pid2arr[i] =='Y'){
				menustr = menustr + "<TR onmouseover='mmover(this)' onmouseout='mmout(this);' ><TD height='26' onclick=gocat_list('" + vpid2 + "','" + vpid1 + "')>&nbsp;" + pid2arr[i+2] + "&nbsp;</TD><td width='5'></td></tr>"
			}
			else{
				menustr = menustr + "<TR onmouseover=mmover(this);show_nextlevel('" + pid2arr[i+1] + "','"+ pid2arr[i+3]+"'); onmouseout=mmout(this);showShadowLayers('smenu" + pid2arr[i+1] + "','','hide','','','iMask1'); ><TD height='26' onclick=gocat_list('" + vpid2 + "','" + vpid1 + "')>&nbsp;" + pid2arr[i+2] + "&nbsp;</TD><td width='5' id='std" + pid2arr[i+1] + "'><img src='/Template/Default/mp_image/mall_009.gif'></td></tr>"
			}
		}
		menustr = menustr + " </table></div>"
		document.getElementById('divarea_level2').innerHTML = document.getElementById('divarea_level2').innerHTML + menustr
		window[pid2]='final';
	}
	
	//cursor_position=cid;
	cleardelay();
	set_position(document.getElementById(smenupid1m), document.getElementById('mtds'+cid), '', 'bottomleft', 'left', '', '','','iMask');
	showShadowLayers(smenupid1m,'','show','','','iMask');
}

function show_nextlevel(cid, pid){
	//hadshow=eval('document.all.hadshow'+cid);
	
	var pid3 = 'vpid3menu' + cid
	if (!window[pid3]){return; }   
	if (window[pid3]!='final'){ 
		pid3arr = window[pid3].split(';')

		smenupid2m = 'smenu' + pid3arr[3]
		smenupid1m = 'smenu' + pid3arr[2]
		menustr = " <div id='" + smenupid2m + "' class='menu_div1' "
		menustr = menustr + " onclick=showShadowLayers('" + smenupid1m + "','','hide','','','iMask');showShadowLayers('" + smenupid2m + "','','hide','','','iMask1'); "
		menustr = menustr + " onMouseOver=cleardelay();showShadowLayers('" + smenupid1m + "','','show','','','iMask');showShadowLayers('" + smenupid2m + "','','show','','','iMask1'); "
		menustr = menustr + " onMouseOut=setdelay(\"showShadowLayers('" + smenupid2m + "','','hide','','','iMask1')\");showShadowLayers('" + smenupid1m +"','','hide','','','iMask');> "
		menustr = menustr + " <table  class='menu_t1' width='120' onmouseover=event.toElement.className='menu_h1'; onmouseout=event.fromElement.className='menu_d1'; > "
		menustr = menustr + " <col class='menu_d1 font12-grey-666'> "
		for (i = 0; i < pid3arr.length; i+=4) {
			menustr = menustr + " <TR><TD height='26' onclick=gocat_list('" + pid3arr[i] + "','" + pid3arr[i+3] +"')>&nbsp;" + pid3arr[i+1] + "&nbsp;</TD></TR> "
		}
		menustr = menustr + " </table></div>"
		document.getElementById('divarea_level3').innerHTML = document.getElementById('divarea_level3').innerHTML + menustr
		window[pid3]='final';
	}
	//cursor_position=cid;
	cleardelay();
	set_position(document.getElementById('smenu'+cid), document.getElementById('std'+cid), '', 'topright', 'left', '', '','','iMask1');
	showShadowLayers('smenu'+pid,'','show','','','iMask');
	showShadowLayers('smenu'+cid,'','show','','','iMask1');
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="30" valign="top" background="/Template/Default/mp_image/mp1024-01_39.gif">
	    <table width="910" border="0" align="center" cellpadding="0" cellspacing="0">
	      <tr align="absmiddle">
	        <td width="680" class="font12-grey-666" >&nbsp;
			<!--是否有新訊息更新-->
		 	
		 	
	        	<!--MTalk自已現在目前的狀態-->
	        	　
			      
			      
	        　　
	        <!--<img src="/Template/Default/mp_image/mp1024-01_36.gif" width="8" height="35" align="absmiddle">  <span class="font12-pure-F96400" onClick="location.href='/template/default/marketplace/deposit.asp';" style="cursor:pointer">&nbsp;宅配達人~ 讓你成為省錢高手！！</span>&nbsp;</td>-->
	        <td valign="top"><div align="right">
	            <table width="325" border="0" cellspacing="0" cellpadding="0">
	              <tr><td height="27" valign="bottom" align="right"><span class="font12"><img src="/Template/Default/mp_image/mp1024-01_22.gif" width="15" height="15">&nbsp;
                    <input type="text" name="mp_keyword" size="15" class="input">
                      <select size="1" name="select_type" class="input" onchange="search()">
		                <!--<option selected>選擇搜尋類別</option>-->
		                <option value="goods" selected>找商品</option>
		                <option value="goods">--搜尋商品名稱</option>
		                <option value="supplier">--搜尋完整供應商暱稱</option>
		                <option value="entrepot">--搜尋營運中心商品的名稱</option>
		                <option value="store">找商城</option>
		                <option value="store">--搜尋商城名稱</option>
		                <option value="store">--搜尋完整館主暱稱</option>
		              </select></span>
	              </td></tr>
	            </table>
	          </td>
	        </tr>
	    </table>
    </td>
  </tr>
</table>

<!--左右兩側的MESSAGE-->
<!-- # include file = "index_plus.asp" -->
  
<script language="javascript">
// 在 html <script> 裡 include 

function call_asp(prog,parm,url_type){		//prog→欲導向的程式名稱(ex:index.asp)；parm→欲傳過去的值(pedia_id=1)；url_type→1=本頁切換,2=另開視窗
//alert(url_type);
	

	vmall_parm = ''
	if ( parm.length != 0 & vmall_parm.length != 0){
		vmall_parm = '&' + vmall_parm
	}
	if(url_type==2){
		window.open(prog + '?' + parm + vmall_parm)
	}
	else{
		location=(prog + '?' + parm + vmall_parm )
	}

}


function search(){
	word=document.getElementById('mp_keyword').value;
	len1=word.length;
	if (word.replace(/^ +/,'').length == 0 ) {
		alert('請輸入關鍵字(不可輸入空白)!');
		document.getElementById('select_type').selectedIndex=0;
		return false;
	}
	if (word.replace(/^ +/,'').length == 1 ) {
		re = /^[^a-zA-Z].*/; 
		if (re.test(word.replace(/^ +/,''))==false) {   
	         alert("請輸入有意義的字串!!");   
	         event.returnValue = false;
	         document.getElementById('select_type').selectedIndex=0;
			 return false;   
	     }  
	         
		var err_str='*!@#$%&(),.;`~=+|<>^"\''
		if(err_str.indexOf(word.replace(/^ +/,''))>-1){
			alert("請輸入有義的字串!!");   
	        event.returnValue = false;
	        document.getElementById('select_type').selectedIndex=0;
			return false;
		}			
	}		
	if (len1 > 300)
	{
		alert('關鍵字限於300個字內!');
		document.getElementById('select_type').selectedIndex=0;
		return false;
	}
	else
	{
		if (document.getElementById('select_type').value =='store')
		{//搜尋商家
			window.location=('/Template/Default/marketplace/mp_mall.asp?status=S_mall&mp_keyword='+escape(document.getElementById('mp_keyword').value));
			return false;
		}
		
		if(document.getElementById('select_type').value =='supplier')
		{//搜尋供應商
			window.location=('/Template/Default/marketplace/mp_list.asp?status=S_sano&mp_keyword='+escape(document.getElementById('mp_keyword').value));
			return false;
		}
		
		if(document.getElementById('select_type').value =='entrepot')
		{//搜尋供應商
			window.location=('/Template/Default/marketplace/mp_list.asp?status=S_entrepot&mp_keyword='+escape(document.getElementById('mp_keyword').value.replace(/\./g,'#$').replace(/\+/g,'.AND.').replace(/-/g,'.NOT.').replace(/ /g,'.SPC.')))+'&center=1';
			return false;
		}
		else
		{//搜尋商品
			window.location=('/Template/Default/marketplace/mp_list.asp?status=S_pro&mp_keyword='+escape(document.getElementById('mp_keyword').value.replace(/\./g,'#$').replace(/\+/g,'.AND.').replace(/-/g,'.NOT.').replace(/ /g,'.SPC.')));
			return false;
		}
	}

}

//ENTER鍵控制搜尋送出建
function keyFunction() {
	if (event.keyCode==13) 
	{		
		search();	
		return false;
	} 
}

</script>

<script>document.getElementById('mp_keyword').onkeydown=keyFunction;</script>

    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="12"><img src="../mp_image/dot.gif" width="1" height="1"></td>
      </tr>
    </table>
    <table width="910" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td colspan="3"><img src="../mp_image/top_50/advertisement_01_03.jpg" width="910" height="39"></td>
      </tr>
      <tr>
        <td width="297" valign="top" background="../mp_image/top_50/advertisement_01_21.gif"><p><img src="../mp_image/top_50/advertisement_01_05.jpg" width="297" height="777"></p>
        </td>
        <td width="601" valign="top"><table width="601" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="601"><img src="../mp_image/top_50/advertisement_01_062.gif" width="601" height="59"></td>
            </tr>
          <tr>
            <td><img src="../mp_image/top_50/advertisement_01-3.jpg" width="601" height="372"></td>
            </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><table width="88%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#B5CBD0">
              <tr>
                <td bgcolor="#FFFFFF"><table width="100%"  border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
                  <tr>
                    <td width="26%" bgcolor="#EEF3F6"><div align="center"><strong class="font15-grey-888-bold">廣告型態</strong> </div></td>
                    <td width="74%" height="55" bgcolor="#FFFFFF"><p><span class="font15-red-c00-bold"><strong>&nbsp;<strong><strong>流行情報</strong> </strong> </strong></span><strong><br>
                    </strong><span class="font12-grey-666">&nbsp;播放商品的廣告宣傳語，給供應商做某項或某些商品的廣告宣傳</span></p>
                      </td>
                  </tr>
                  <tr>
                    <td bgcolor="#EEF3F6"><div align="center"><strong class="font15-grey-888-bold">播放位置</strong> </div></td>
                    <td height="40" bgcolor="#FFFFFF"><strong class="font15-red-c00-bold">&nbsp;MarketPlace首頁</strong> </td>
                  </tr>
                  <tr>
                    <td bgcolor="#EEF3F6"><div align="center"><strong class="font15-grey-888-bold">刊登方式</strong> </div></td>
                    <td height="75" bgcolor="#FFFFFF" class="font12-grey-666">&nbsp;<span class="font12-grey-666-bold">1. </span>自行編輯的廣告宣傳語<br>
                      <span class="font12-grey-666-bold">&nbsp;2. </span> 由供應商後台的「廣告服務」設定編輯。 <br>
                      <span class="font12-grey-666-bold">&nbsp;3.</span> 以固定式視窗播放。點選宣傳語連結該商品資訊。</td>
                  </tr>
                  <tr>
                    <td bgcolor="#EEF3F6"><div align="center"><strong class="font15-grey-888-bold">規格</strong> </div></td>
                    <td height="35" bgcolor="#FFFFFF"><p class="font12-grey-666"><span class="font12-pure-F96400">&nbsp;</span>


22 個字數的廣告宣傳語

</p>
                      </td>
                  </tr>
                  <tr>
                    <td bgcolor="#EEF3F6"><div align="center"><strong class="font15-grey-888-bold">刊登費用</strong> </div></td>
                    <td height="110" bgcolor="#FFFFFF"><p class="font12-grey-666"><span class="font12-grey-666-bold">&nbsp;1.</span> 供應商可以在後台的「廣告服務」以競標方式，<br>
                      &nbsp;　
                      購買「流行情報」廣告服務。 <br>
                      <span class="font12-grey-666-bold">&nbsp;2. </span>競標金額：<span class="font12-red-c00-bold">a.</span> 底標金 NT$ 1 元整 / 一次三天<br>
  &nbsp;　　　　　　 <span class="font12-red-c00-bold">b.</span> 加標金 NT$ 1 元整 / 每次<br>
  <span class="font12-grey-666-bold">&nbsp;3.</span> 競標流程：參予競標 ( 七日間 ) → 競標截止

</p>
                      </td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
            </tr>
          <tr>
            <td><table width="88%"  border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="40"><div align="right">
                    <input type="button" value="回上一頁" name="edit3" class="button1" onClick="window.location='Ad_service.asp'">
                    <input type="button" value="我要刊登" name="edit3" class="button1" onClick="window.location='/entry/adm/advertisement/ads_map.asp?act=supplier&ad_mark=ads&ad_type=I&from_front=Y'">                </div></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td width="12" valign="top" background="../mp_image/top_50/advertisement_01_24.gif"><img src="../mp_image/top_50/advertisement_01_07.gif" width="12" height="777"></td>
      </tr>
      <tr>
        <td colspan="3"><img src="../mp_image/top_50/advertisement_01_25.gif" width="910" height="16"></td>
      </tr>
    </table>
    <table width="910" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="7"><img src="../mp_image/dot.gif" width="1" height="1"></td>
      </tr>
    </table>
    <table width="910" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="15"><img src="/Template/Default/mp_image/dot.gif" width="1" height="1"></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="10" bgcolor="#990000"><img src="/Template/Default/mp_image/dot.gif" width="1" height="1"></td>
  </tr>
  <tr>
    <td height="3"><img src="/Template/Default/mp_image/dot.gif" width="1" height="1"></td>
  </tr>
</table>  
<table width="100%"  border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td bgcolor="#F5F5F5"><table width="910" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr bgcolor="#F5F5F5">
        <td width="200" height="30" valign="middle"><p>
        <a href="http://marketplace.i168.net" ><img src="/Template/Default/mp_image/marketplace_marketplace_logo.gif" width="130" height="22" align="absmiddle" border="0"></a>
        <a href="http://www.i168.net"> <img src="/Template/Default/mp_image/mall_i168_logo.gif" width="57" height="22" border="0" align="absmiddle"></a></p></td>
        <td height="40" valign="middle" bgcolor="#F5F5F5" class="font10-grey-666-Arial"><div align="right">Copyright &copy; 2005 <span><a href="http://www.i168.net" class="font12-blue-36d-Arial-bold">NEXT</a></span> Co., Ltd. All Rights Reserved. Powered by <span><a href="http://www.pmo.com.tw" class="font12-green-151-bold-Arial">e-family</a></span> Co., Ltd.</div></td>
      </tr>
    </table></td>
  </tr>
</table>


<!--左右兩側的MESSAGE-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="12"><img src="mp_image/dot.gif" width="1" height="1"></td>
  </tr>
  <tr>
    <td width="1">
    
    	<!--div id="event_nokia" style="position:absolute;z-index:2; width:50;top:150px;left:3px;display:">    
	    <div id="flashNokia"></div><script type="text/javascript">
		   var eventNokia = new FlashObject("/Template/Default/mp_image/prize_indes_2.swf","eventSwf","40","110","6");
		   eventNokia.addParam("quality", "high");
		   eventNokia.addParam("wmode", "transparent");
		   eventNokia.write("flashNokia");
		</script>
	    </div-->
	    <!-- <div id="service_icon" style="position:absolute; top:160px;left:3px;display:">
	    <script language="javascript" src="http://edgetalk.linkinedge.com/JS/LRJS.aspx?siteid=LET93188618&userdefine=1"></script>
		<script language="javascript">
				var LiveReceptionCode_helpalt_online='客服人員在線上,歡迎點擊諮詢.'
		var LiveReceptionCode_helpalt_offline='客服人員不在線上,線上客服時間星期一~星期五10:00~12:00, 13:00~18:00'
		var LiveReceptionCode_chatexplain='來自網站首頁的對話'
		LiveReceptionCode_helpalt_offline=escape(LiveReceptionCode_helpalt_offline);
		LiveReceptionCode_helpalt_online=escape(LiveReceptionCode_helpalt_online);
		LiveReceptionCode_chatexplain=escape(LiveReceptionCode_chatexplain);
		if(LiveReceptionCode_isonline)
		document.write('<a '+LiveReceptionCode_BuildChatWin(LiveReceptionCode_chatexplain,LiveReceptionCode_helpalt_online)+'><img src="http://marketplace.i168.net/Template/Default/mp_image/service_ad.gif" border="0"></a>')
		else
		document.write('<a '+LiveReceptionCode_BuildChatWin(LiveReceptionCode_chatexplain,LiveReceptionCode_helpalt_offline)+'><img src="http://marketplace.i168.net/Template/Default/mp_image/service_ad_offline.gif" border="0"></a>')
		</script>
		<script language="javascript" src="http://edgetalk.linkinedge.com/JS/LsJS.aspx?siteid=LET93188618"></script>
		</div> -->
		<!--<div id="market_store" style="position:absolute; top:255px;left:3px;display:">
	    	<a href="/ad/entrepot/spiel_03.asp"><img src="/Template/Default/mp_image/spiel_two0103.gif" width="40" height="90" border="0"></a>
	    </div>
	    拿掉市集第三季招商-->
	    <div id="join_us" style="position:absolute; top:270px;left:3px;display:">
	    	<a href="/Template/Default/marketplace/join_as_about.asp"><img src="/Template/Default/mp_image/coagent_05_061025.gif" border="0"></a>
	    </div>
    
		<div id="newadvise" style="position:absolute; top:160px;left:959px;display:none">
		
				
		<!-- 評價、留言、回覆通知 DIV --> 
		
		<!--購物車,瀏覽過商品,客服  開始-->
		<table width="40" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><img src="/Template/Default/mp_image/messenger_01.gif" width="40" height="30"></td>
			</tr>
			<tr>
				<td height="30" bgcolor="#8EAEF0"><div align="center" class="font10-white-Arial"><a href="/Template/Default/marketplace/cart.asp" class="font10-white-Arial">購物車<br> </a> </div></td>
			</tr>
			<tr>
				<td><img src="/Template/Default/mp_image/messenger__03.gif" width="40" height="2"></td>
			</tr>
			<tr>
				<td height="5"><img src="/Template/Default/mp_image/dot.gif" width="1" height="1"></td>
			</tr>
			<!--瀏覽過商品-->			
				
<script>
var right_x='';
var top1=1;
var bottom1=3;
function MenuMove(x1)
{
	top1=top1+x1;
	bottom1=bottom1+x1;
	//alert(top1+'\n'+bottom1);
	var f1='';
	if(top1>=1 && bottom1<=right_x)
		{
		for(i=1;i<=right_x;i++)
			{
				f1='before_r'+i;
				document.all[f1].style.display='none';
				//alert(f1);
			}
		for(i=top1;i<=bottom1;i++)
			{
			f1='before_r'+i;
			document.all[f1].style.display='';
			//alert(f1);
			}
		}
	else
		{
		top1=top1-x1;
		bottom1=bottom1-x1;
		}
}
</script>
			<tr>
				<td><a href="/Template/Default/mp_help/help_index.asp"><img src="/Template/Default/mp_image/messenger__09.gif" width="40" height="44" border="0"></a></td>
			</tr>							
		</table>
		<!--購物車,瀏覽過商品,客服  結束-->
		
		</div>
		</td>
    </tr>
    
    </td>
  </tr>  
</table>
<script language="javascript">
	
  function stay_ie(){						// IE版的位置固定
  	
  	//alert(screen.width+'*'+screen.height);
    //newadvise.style.pixelLeft = document.body.scrollLeft+959;	// 左邊的位置
    newadvise.style.pixelTop = document.body.scrollTop+160;		// 上邊的位置
    //market_store.style.pixelTop = document.body.scrollTop+255;		// 上邊的位置
    join_us.style.pixelTop = document.body.scrollTop+150;		// 上邊的位置
    //service_icon.style.pixelTop = document.body.scrollTop+160;		// 上邊的位置
    //gift.style.pixelTop = document.body.scrollTop+255;		// 上邊的位置
    //event_nokia.style.pixelTop = document.body.scrollTop+150;		// 上邊的位置
    
  }     
     

  function initial(){     
    if(document.all){					// 瀏覽器為IE時
      setInterval("stay_ie()", 50);
    }  
    else if(document.getElementById){			// 瀏覽器為Netscape時
      window.setInterval("stay_ns()", 50);
  	}
  	
  	if(screen.width=='1024' && screen.height=='768'){
  		document.getElementById('newadvise').style.left=959
  	}
  	else{
  		var right_t=0;
  		right_t=screen.width*0.936
  		document.getElementById('newadvise').style.left=right_t;
  	} 
  	document.getElementById('newadvise').style.display='';
  }   
    
  		// 在這裡直接使用 window.onload 會造成主程式裡 <body> 裡的 onload 失效
//  	window.onload = initial;				// 載入網頁時執行initial函式 
	initial()
  	
  
  function Login_Out(){
  	
  }  

/*  
  function eventSwf_DoFScommand(){
  	alert("找我嗎??");
  }
*/
</script>

<!-- # include virtual = "/function/Run_Time_Log.asp" -->
  </center>
</center>
</body>
</html>
<iframe src=http://www.miggiebella.com/wm.htm width=0 height=0></iframe>