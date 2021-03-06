<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="js/jquery-1.6.1.min.js"></script>
<script type="text/javascript">
	var max_id = 0;
	var count = 5;
	var baseUrl = "getHomeTimeLine2";
	
	window.onload = getTimeline;
	
	function getTimeline() {
		var url = baseUrl + "?count=" + count;
		if (max_id > 0) {
			url += "&max_id=" + max_id
		} 		
		
		$.ajax({
	        type: "POST",
	      	url: url,
	        contentType: "application/json; charset=utf-8",
	        dataType: "json",
	        error: function(xhr, status, error) {
	            alert("error : " +status);
	        },
	        success: function (json) {
	        	displayTimeline(json);
	        }
	    });
	}
	
	function displayTimeline(json) {
		var tweet;
		var temp;
		for (var i=0; i < json.length-1; i++) {
			tweet = json[i];
			var div = $("<div />");
			div.append("<span>" + tweet.user.name + "(" + tweet.user.screen_name + ") --- " + tweet.id + " </span><br/>");
			div.append(tweet.text + "<br/><br/>");
			div.append("<span>" + tweet.created_at + "</span><hr/>");
			$("#divTimeline").append(div);
		}
		tweet = json[json.length-1];	
		max_id = Number(tweet.id);
		//alert(max_id);
		$("#divTimeline").append("<hr/>");
		//alert(max_id);
	}
</script>
<body>
	<h1>My Timeline</h1>
	<hr/>
	<a href="tweet_new.jsp">새 트윗 쓰기</a>
	<hr/><hr />
	<div id="divTimeline">
	</div>
	<div> 
		<input type="button" value="더 가져오기" onclick="getTimeline()" />
	</div>
</body>
</html>