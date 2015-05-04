/*
 * requires:jQuery v1.4.2 later
 * name:jquery.simplaModalwindow.js
 * license:GPL(GNU General Public License)
 * author:Manabu Kushimoto(web-park.org)
 */
var OverLay="overLay"; //透過背景のID名
var DC="displayContent"; //読み込まれた要素を入れる要素の親ID名
var getContents="getContents"; //読み込まれた要素を入れるID名
var closeBox="closeBox"; //閉じるボタンのID名
var closeImg='<img src="./img/btn_close.png" alt="CLOSE" />'; //閉じるボタンのimg要素
var closeBoxElement='<p id="'+closeBox+'"><a href="#">'+closeImg+'</a></p>'; //閉じるボタンの構成
var loading='<img src="./img/loading.gif" />'; //ローディングアイコンのimg要素
var pluginClass="modal"; //プラグインを設定するアンカーのクラス

$(function(){
	
	$("body").append("<div id='"+OverLay+"'></div><div id='"+DC+"'><div id='"+getContents+"' />"+closeBoxElement+"</div>");
	$("#"+OverLay).css({"opacity":0.8}).hide();
	$("#"+DC).hide();
	
	$.fn.modalWindow = function(options){
		var $t=$(this),filePath=$t.attr("href"),imgObj=new Image();
		if(filePath.match(/\.jpg|\.gif|\.png/gi)){ imgObj.src=filePath; }
		$("#"+getContents).append(loading);

		function clickEvent(){
			$t.click(function(){
				var imgClass="imgClass",imgPath="<img class='"+imgClass+"' src='"+filePath+"' />",windowH=$(window).height(),wHhalf=windowH/1.5,documentH=$(document).height();
				w=new Number(filePath.replace(/([\D\d\.\/]+)width=([\d]+)(([\D\d\.\/]+)|)/g,"$2")),
				h=new Number(filePath.replace(/([\D\d\.\/]+)height=([\d]+)(([\D\d\.\/]+)|)/g,"$2")),
				Scroll=filePath.replace(/([\D\d\.\/]+)scroll=([\D\d\.\/]+)/g,"$2");
				$("#"+OverLay).show().css("height",documentH);
				$("#"+DC).show().css({top:($(document).scrollTop()+windowH/2)+"px"});
				switch(true){
					case /\.jpg|\.gif|\.png/gi.test(filePath):
						$("#"+getContents).html($(imgPath));
						$("#"+getContents).css({overflow:"hidden"}).show(function(){
							w=$("."+imgClass,this).width(),h=$("."+imgClass,this).height();
							function resizeWindow(){
								$("#"+DC).stop(false,true).animate({
									marginTop:-h/2+"px",
									marginLeft:-w/2+"px",
									width:w+"px",
									height:h+"px"
								});
							};
							if(w==0||h==0){
								$("#"+getContents).html(loading).show(function(){
									w=$("> img",this).width(),h=$("> img",this).height();
									resizeWindow();
								});
							}else{
								resizeWindow();
							}
						});
						break;
					case /^#/gi.test(filePath):
						var fileID=filePath.replace(/^#([\D\d\.\/]+)\?width=([\D\d\.\/]+)/g,"#$1");
						$("#"+getContents).html($(fileID).clone(true));
						break;
					case /\.htm#|\.html#|\.php#/i.test(filePath):
						var fileURL=filePath.replace(/([\D\d\.\/]+)#([\D\d\.\/]+)/g,"$1"),
						filePathID=filePath.replace(/([\D\d\.\/]+)\.html/g,"");
						$("#"+getContents).load(fileURL+" "+filePathID);
						break;
					case /\.htm|\.html|\.php/i.test(filePath):
						$("#"+getContents).load(filePath);
						break;
				}
				if(filePath.match(/^#/gi)||filePath.match(/\.htm|\.html|\.php/i)||filePath.match(/\.htm#|\.html#|\.php#/i)){
					if(w.toString()=="NaN"||h.toString()=="NaN"){
						$("#"+DC).css({margin:"",width:"",height:""});
					}else{
						if(windowH>h){
							$("#"+DC).stop(false,true).animate({
								marginTop:-h/2+"px",
								marginLeft:-w/2+"px",
								width:w+"px",
								height:h+"px"
							},300);
						}else{
							$("#"+DC).stop(false,true).animate({
								marginTop:-windowH/3+"px",
								marginLeft:-w/2+"px",
								width:w+"px",
								height:windowH/2+"px"
							},300);
						}
					}
					switch(Scroll){
						case "yes":
							$("#"+getContents).css({overflowY:"scroll",overflowX:"hidden"});
							break;
						default:
							$("#"+getContents).css({overflow:"hidden"});
							break;
					}
				}
				$("#"+closeBox).show();
				$("select").hide();
				return false;
			 });
		 };
	
		$("#"+OverLay+",#"+closeBox+" a").click(function(){
			if($("#"+DC+":not(:animated)")){
				$("#"+DC).hide();
				$("#"+OverLay).fadeOut(100,function(){
					$("#"+DC).hide();
				});
				$("#"+getContents).children().remove(function(){
					$(this).append(loading);
				});
				$("select").show();
			}
			return false;
		});
		clickEvent();
	};

	$("a."+pluginClass).each(function(){
		$(this).modalWindow();
	});

});