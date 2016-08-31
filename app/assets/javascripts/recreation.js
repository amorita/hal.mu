
var time = 150;

var teamOnGoing = "";

var timerObj;

var odai = ["AKB48","EXILE","ダンディ坂野","スキー","ヌンチャク","らくだ","跳び箱","クリスマス","カヌー","水風船","カバディ","Wコロン","弓道","コアラ","弁護士","ジャッキー・チェン","野々村議員","アニマル浜口","相撲","ラクロス","闘牛","エドはるみ","チンパンジー","アントニオ猪木","ありのままで","ゴリラ","ゴジラ","ラグビー","キリン","フランシスコザビエル","トライアスロン","ビリーズブートキャンプ","自転車","ドラえもん","餅つき","少林寺拳法","ジョジョ","桂三枝","スキージャンプ","ジャイアント馬場","フィギュアスケート","太極拳","ピッコロ","馬","空手","豆まき","鞍馬","牛","ふなっしー","ラッコ","ニョロニョロ（ムーミん）","ひな祭り","シンクロナイズドスイミング","マツコ・デラックス","孫悟空","砲丸投げ","仮面ライダー","レイザーラモンHG","初詣","羊","楽しんご","ボーリング","卓球","アンパンマン","ダチョウ倶楽部","吊り輪","走り幅跳び","ボクシング","射撃","江頭2:50","郷ひろみ","サッカー","犬","医者","カバ","バスケ","ハンドボール","コサックダンス","カーリング","ストレッチマン","鉄棒","嵐","トトロ","ブッダ","スイカ割り","小島よしお","ミッキーマウス","バレー","自動車","ヨッシー","志村けん","ボブスレー","エアロビクス","火消し","消防士","フェンシング","加藤茶","イエスキリスト","パンダ","バスケットボール","せんとくん","宮迫（雨上がり決死隊）","青森ねぶた祭り","小室哲哉","レスリング","モーグル","ねずみ","バドミントン","警察官","ウルトラセブン","スノボー","うさぎ","真田丸","象","猫","タクシー","イチロー","ロックマン","猿","鮫","棒高跳び","ドナルドダック","釣り","ビートたけし","大工","マリオ","アーチェリー","走り高跳び","ウルトラマン","オードリー春日","飛行機","手話","野球","ビリヤード","乗馬","テニス","マイケルジャクソン","ダイビング","ヨガ","フラメンコ","くいだおれ太郎"];
var odaiIndex = -1;

var imgReq;

var result = {};

var sortedResult = [];

$(document).ready(function(){

$(".team").click(function(){
	teamOnGoing = $(this).text().trim();
	resetStage();
	$(".start").addClass("height-hidden");
	$(".stage").removeClass("height-hidden");
	$(".timer").removeClass("height-hidden");
	$(".count").removeClass("height-hidden");
	$(".image").removeClass("height-hidden");
	$(".subject").removeClass("height-hidden");
	$("#question").text("");
})

$(".start-button").click(function(){
	$(this).addClass("height-hidden");
	$(".subject").removeClass("height-hidden");
	loadNext();
	timer();
})



})
 

var reutnToStart = function(){
	$(".start").removeClass("height-hidden");
	$(".stage").addClass("height-hidden");
	$(".timer").addClass("height-hidden");
	$(".image").addClass("height-hidden");
	$(".subject").addClass("height-hidden");
	$("#question").text("");
	result[teamOnGoing] = Number($(".count").text().trim());

	sortedResult = [];
	for (var r in result)
      	sortedResult.push([r, result[r]])
	sortedResult.sort(
    	function(a, b) {
        	return a[1] - b[1]
    	}
	);
}

var resetStage = function(){
	$(".start-button").removeClass("height-hidden");
	$(".start-button").text("Team " + teamOnGoing + " START!");
	$(".count").text("0");
	$(".timer").text(time);
}

var timer = function(){
	var timerElem = $(".timer");
	timerElem.text(timerElem.text() - 1);
	if (timerElem.text().trim() == '30'){
		$(".count").addClass("height-hidden");
	}
	if (timerElem.text().trim() != '0') {
		setTimeout(timer, 1000);
	} else {
		timeUp();
	}
}

var setKeyEvent = function(){
	$('html').keydown(function(e){
		switch(e.which){
			case 32:
				loadNext();
				return false;
			case 13:
				$(".count").text(Number($(".count").text().trim()) + 1);
				document.getElementById( 'correct' ).play() ;
				return false;
			case 27:
				reutnToStart();
				return false;
			case 82: // Rで結果表示
				var res = sortedResult[0];
				$("." + res[0].toLowerCase()).addClass("team-hovered");
				$(".display-point").text(res[1]);
				sortedResult.remove(0);
				return false;
			case 68: // Dでクリア
				$(".team").removeClass("team-hovered");
				$(".display-point").text(""); 
				return false;
		}
	})
}

var timeUp = function(){
	$("#question").text("終了");
	document.getElementById( 'gong' ).play();
}

var azureKey = "eyxcvN59BnDV3PwcgsJf4tPs21fJTFI8sVHC5S5M2E8";

var getImage = function(query) {

	if (imgReq) {
		imgReq.abort();
	}

	$(".image").addClass("invisible");
    //base64 encode the AppId
//    var azureKey = btoa(appId);
    //get the value from the search box
    var $searchQuery = $('#searchBox').val();
    //Create the search string
    var myUrl = 'https://api.datamarket.azure.com/Bing/Search/v1/Composite?Sources=%27image%27&$top=10&ImageFilters=%27Size:Small%27&$format=json&Query=%27' + query + '%27';
    //Make post request to bing
    imgReq = $.ajax({
      method: 'post',
      url: myUrl,
      //Set headers to authorize search with Bing
      beforeSend: function(xhr) {
					var credentials = btoa(":" + azureKey);
				    xhr.setRequestHeader("Authorization", "Basic " + credentials);
		},
      success: function(data) {
        //Insert random image in dom
        var randomIndex = Math.floor(Math.random() * 10);
        var imgLink = data.d.results[0].Image[randomIndex].MediaUrl;

        var imgLdr = new Image();
        imgLdr.onload = function(){
	        $(".image").attr('style', 'background-image: url("' + imgLink + '")');
    	    $(".image").removeClass("invisible");
    	};
    	imgLdr.src = imgLink;
     
      },
      failure: function(err) {
        console.error(err);
      }
    });
  };

var loadNext = function(){
	odaiIndex = odaiIndex + 1;
	$("#question").text(odai[odaiIndex]);
	getImage(odai[odaiIndex]);
}

Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

setKeyEvent();
