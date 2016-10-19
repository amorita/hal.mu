// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
#//= require turbolinks
//= require bootstrap
//= require_tree .

jQuery(document).ready(function(){
	$(".part_select").change(
		function(){
			if ($(this).val() > 99) {
				$(".subs_name").show();
				$(".subs_name").prop('required', 'true');
			} else {
				$(".subs_name").hide();
				$(".subs_name").removeAttr('required');
			}
		}
	);
	$(".nontan_class").change(
		function(){
			if ($(this).val() != 1) {
				$(".att_time").show();
				$(".att_time").prop('required', 'true');
			} else {
				$(".att_time").hide();
				$(".att_time").removeAttr('required');
			}
		}
	);
	
	$(".enq_ans_btn").click(
		function(){
			parDiv = $(this).parent("div");
			brosInput = parDiv.children("input").get(0);
			value =$(this).attr("value");
			$(brosInput).val(value);
		}
	)

	$(".zip-code").bind("keyup", function(){
		$.ajax({
			url: '/zip_codes/' + $(this).val(),
			success: function(res){
				$(".address").val(res);
			},
		});
	})

});

function clkbtn(obj){
			parDiv = $(obj).parent("div");
			brosInput = parDiv.children("input").get(0);
			value =$(obj).attr("value");
			$(brosInput).val(value);
		}

(function(){
  var ua = {
    iPhone: navigator.userAgent.indexOf('iPhone') != -1,
    iPad: navigator.userAgent.indexOf('iPad') != -1,
    iPod: navigator.userAgent.indexOf('iPod') != -1,
    android: navigator.userAgent.indexOf('Android') != -1,
    windows: navigator.userAgent.indexOf('Windows Phone') != -1
  }
  if(ua.iPhone || ua.iPad || ua.iPod || ua.android || ua.windows){
//    document.write('<meta name="viewport" content="width=device-width, minimum-scale=0.9, maximum-scale=0.9, width=3px">\n');
	document.write('<meta name="viewport" content="width=device-width,initial-scale=0.8,minimum-scale=0.75,maximum-scale=0.75,user-scalable=no">\n');
	
	
    //document.write('<link rel="stylesheet" type="text/css" href="SP.css" media="screen">\n');
  }else{
    //document.write('<link rel="stylesheet" type="text/css" href="PC.css" media="all">\n');
  }
}());

$(function() {
	$('[rel=popover]').popover({
		html:true
	});
});

function createMutter(){
	$('.mutter-button').prop('disabled', true);
	var url = '/mutters/create?message=' + encodeURIComponent($('.message-input').val());
	$('#mutters').load(url);
};


