jQuery.iPikaChoose={build:function(user_options)
{var user_options;var defaults={show_captions:true,slide_enabled:true,auto_play:true,show_prev_next:true,slide_speed:5000,thumb_width:50,thumb_height:42,buttons_text:{play:"Play",stop:"Stop",previous:"Previous",next:"Next"},delay_caption:true,user_thumbs:false};return jQuery(this).each(function(){var options=jQuery.extend(defaults,user_options);var images=jQuery(this).children('li').children('img');images.fadeOut(1);var ulist=jQuery(this);images.each(LoadImages);jQuery(this).before("<div class='pika_main'></div>");var main_div=jQuery(this).prev(".pika_main");if(options.slide_enabled){main_div.append("<div class='pika_play'></div>");var play_div=jQuery(this).prev(".pika_main").children(".pika_play");play_div.html("<a class='pika_play_button'>"+options.buttons_text.play+"</a><a class='pika_stop_button'>"+options.buttons_text.stop+"</a>");play_div.fadeOut(1);var play_anchor=play_div.children('a:first');var stop_anchor=play_div.children('a:last');}
main_div.append("<div class='pika_subdiv'></div>");var sub_div=main_div.children(".pika_subdiv");sub_div.append("<img />");var main_img=sub_div.children("img");if(options.show_captions){sub_div.append("<div class='pika_caption'></div>");var caption_div=sub_div.children(".pika_caption");}
jQuery(this).after("<div class='pika_navigation'></div>");var navigation_div=jQuery(this).next(".pika_navigation");navigation_div.prepend("<a>"+options.buttons_text.previous+"</a> :: <a>"+options.buttons_text.next+"</a>");var previous_image_anchor=navigation_div.children('a:first');var next_image_anchor=navigation_div.children('a:last');if(!options.show_prev_next){navigation_div.css("display","none");}
var playing=options.auto_play;main_img.wrap("<a></a>");var main_link=main_img.parent("a");function LoadImages()
{jQuery(this).bind("load",function()
{var w=jQuery(this).width();var h=jQuery(this).height();if(w===0){w=jQuery(this).attr("width");}
if(h===0){h=jQuery(this).attr("height");}
var rw=options.thumb_width/w;var rh=options.thumb_height/h;if(rw<rh){var ratio=rh;var left=((w*ratio-options.thumb_width)/2)*-1;left=Math.round(left);jQuery(this).css({left:left});}else{var ratio=rw;var top=0;jQuery(this).css({top:top});}
var width=Math.round(w*ratio);var height=Math.round(h*ratio);jQuery(this).css("position","relative");jQuery(this).width(width).height(height);var imgcss={width:width,height:height};jQuery(this).css(imgcss);jQuery(this).hover(function(){jQuery(this).fadeTo(250,1);},function(){if(!jQuery(this).hasClass("pika_selected")){jQuery(this).fadeTo(250,0.4);}});jQuery(this).fadeTo(250,0.4);if(jQuery(this).hasClass('pika_first')){jQuery(this).trigger("click",["auto"]);}});var newImage=jQuery(this).clone(true).insertAfter(this);jQuery(this).remove();images=ulist.children('li').children('img');}
function activate()
{images.bind("click",image_click);if(options.slide_enabled){if(options.auto_play){playing=true;play_anchor.hide();stop_anchor.show();}else{play_anchor.show();stop_anchor.hide();}}
images.filter(":last").addClass("pika_last");images.filter(":first").addClass("pika_first");var licss={width:options.thumb_width+"px",height:options.thumb_height+"px","list-style":"none",overflow:"hidden"};images.each(function(){jQuery(this).parent('li').css(licss);if(jQuery(this).attr('complete')==true&&jQuery(this).css('display')=="none")
{jQuery(this).css({display:'inline'});}});previous_image_anchor.bind("click",previous_image);next_image_anchor.bind("click",next_image);}
function image_click(event,how){if(how!="auto"){if(options.slide_enabled){stop_anchor.hide();play_anchor.show();playing=false;}
main_img.stop();main_img.dequeue();if(options.show_captions)
{caption_div.stop();caption_div.dequeue();}}
if(options.user_thumbs)
{var image_source=jQuery(this).attr("ref");}else
{var image_source=jQuery(this).attr("src");}
var image_link=jQuery(this).attr("ref");var image_caption=jQuery(this).next("span").html();images.filter(".pika_selected").fadeTo(250,0.4);images.filter(".pika_selected").removeClass("pika_selected");jQuery(this).fadeTo(250,1);jQuery(this).addClass("pika_selected");if(options.show_captions)
{if(options.delay_caption)
{caption_div.fadeTo(800,0);}
caption_div.fadeTo(500,0,function(){caption_div.html(image_caption);caption_div.fadeTo(800,1);});}
main_img.fadeTo(500,0.05,function(){main_img.attr("src",image_source);main_link.attr("href",image_link);main_img.fadeTo(800,1,function(){if(playing){jQuery(this).animate({top:0},options.slide_speed,function(){if(playing){next_image_anchor.trigger("click",["auto"]);}});}});});}
function next_image(event,how){if(images.filter(".pika_selected").hasClass("pika_last")){images.filter(":first").trigger("click",how);}else{images.filter(".pika_selected").parent('li').next('li').children('img').trigger("click",how);}}
function previous_image(event,how){if(images.filter(".pika_selected").hasClass("pika_first")){images.filter(":last").trigger("click",how);}else{images.filter(".pika_selected").parent('li').prev('li').children('img').trigger("click",how);}}
function play_button(){main_div.hover(function(){play_div.fadeIn(400);},function(){play_div.fadeOut(400);});play_anchor.bind("click",function(){main_img.stop();main_img.dequeue();if(options.show_captions)
{caption_div.stop();caption_div.dequeue();}
playing=true;next_image_anchor.trigger("click",["auto"]);jQuery(this).hide();stop_anchor.show();});stop_anchor.bind("click",function(){playing=false;jQuery(this).hide();play_anchor.show();});}
if(options.slide_enabled){play_button();}
activate();});}};jQuery.fn.PikaChoose=jQuery.iPikaChoose.build;