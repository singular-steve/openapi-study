<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="description" content="_your description goes here_" />
<meta name="keywords" content="_your,keywords,goes,here_" />
<meta name="author" content="_your name goes here_  / Original design: Andreas Viklund - http://andreasviklund.com/" />
<link rel="stylesheet" type="text/css" href="andreas05.css" />
<title>Sara And John</title>
<script type="text/javascript" src="js/jquery-1.6.1.min.js"></script>
<script type="text/javascript">

//Change to Your API Key!!
var apikey = "e5WP8Ur2OIBGu6J2SXYna0r2aGw=";

function doJob(){
	
	var mcode = $("#mcode").val();
	
	//alert(mcode);
	$("#mcodeSpan").html("No Result<br/>");
	$("#mdesc").html("");
	
	if(mcode != 'ALL'){
		var url = "http://tFactory.com:8000/tFactory/model/open/json/"+mcode+"?key="+encodeURIComponent(apikey);
	 	$.getJSON(url, function(data){
			//alert(data.modelVO.mcode);
			$("#mcodeSpan").html("- Model Code : " + data.modelVO.mcode+"<br/>- Model Name : "+data.modelVO.mname);
			$("#mdesc").html(data.modelVO.mdesc);
		}); 
	}else {
		
		alert("get All models data");
		
	 	$.getJSON("http://tFactory.com:8000/tFactory/model/open/json/all?key"+encodeURIComponent(apikey),function(response){
	 		
	 		
			$.each(response.list,function(i, data){ 
				$("#mcodeSpan").append("- " + data.mcode+"<br>");
			}
			);//end each
			
		}
		);
		
	}	
	
}




</script>
</head>

<body>
<div id="title"><h1>John connor's Site</h1></div>
<div id="container">
<div id="sidebar">

<h2>Site menu</h2>
<a class="menu" href="main.do">Main page</a>
<a class="menu" href="viewModel.do">Connect TFactory</a>
<a class="menu" href="viewPosition.do">Connect Satellite</a>
<a class="menu" href="#">Sample</a>
<a class="menu" href="#">Sample</a>
<a class="menu" href="#">Sample</a>
<a class="menu" href="#">Sample</a>
<a class="menu" href="#">Sample</a>
</div>

<div id="main">
<h2>andreas05 - the simple solution!</h2>
<img src="dragonmini.png" width="125" height="125" alt="Dragon screenshot" />
<p>Model Code : <input type="text" id="mcode" value="T1000"></input><a href="javascript:doJob();">VIEW</a></p>
<p><strong><span id="mcodeSpan"></span></strong>
   <div id="mdesc">
   </div>
</p>

<h2>An open source design!</h2>
<p>This design is released as open source, which means that you can make any changes you may want to, and use the page in any way you want to. Have fun! If you want more designs to choose from, you can visit <a href="http://oswd.org/userinfo.phtml?user=Andreas">my page</a> at OSWD.org, or download my other designs directly: <a href="http://www.oswd.org/download.phtml/andreas01.zip?id=2199">01</a> |
<a href="http://www.oswd.org/download.phtml/andreas02.zip?id=2204">02</a> |
<a href="http://www.oswd.org/download.phtml/andreas03.zip?id=2340">03</a> |
<a href="http://www.oswd.org/download.phtml/andreas04.zip?id=2346">04</a></p>

<p class="credits">&copy; 2005 Your name | Design by <a href="http://andreasviklund.com">Andreas Viklund</a></p>
</div>

<div id="footer"></div>
</div>
</body>
</html>