
var time = 60;

var teamOnGoing = "";

var timerObj;

var odai = ["野々村議員","ふなっしー","せんとくん","野球","サッカー","バドミントン","バレー","ダイビング","卓球","テニス","走り幅跳び","走り高跳び","棒高跳び","ラクロス","スキージャンプ","フィギュアスケート","カーリング","バスケ","イチロー","ジャイアント馬場","アントニオ猪木","ビートたけし","象","らくだ","うさぎ","犬","猫","馬","羊","牛","ラッコ","コアラ","パンダ","鮫","ゴリラ","青森ねぶた祭り","ドラえもん","アンパンマン","猿","ボーリング","スノボー","ラグビー","ビリヤード","フェンシング","ボクシング","釣り","ダチョウ倶楽部","ウルトラマン","ウルトラセブン","ミッキーマウス","マイケルジャクソン","フランシスコザビエル","加藤茶","江頭2:50","AKB48","宮迫（雨上がり決死隊）","エドはるみ","孫悟空","ピッコロ","マリオ","ロックマン","小室哲哉","郷ひろみ","ジョジョ","仮面ライダー","ストレッチマン","カバ","キリン","ゴジラ","イエスキリスト","ブッダ","フラメンコ","カバディ","相撲","空手","太極拳","少林寺拳法","EXILE","嵐","オードリー春日","桂三枝","ヨガ","エアロビクス","ビリーズブートキャンプ","小島よしお","ダンディ坂野","志村けん","スキー","モーグル","トトロ","ニョロニョロ（ムーミン）"];
var odaiIndex = -1;

var imgReq;

var result = {};

var sortedResult = [];
 
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

$(".start-button").click(function(){
	$(this).addClass("height-hidden");
	$(".subject").removeClass("height-hidden");
	loadNext();
	timer();
})

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
