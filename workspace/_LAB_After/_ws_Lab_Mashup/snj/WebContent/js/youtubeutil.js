/**
 * 
 */
function findYouTube(){
	
	var modelCode = jQuery("#modelNo").val();
	
	var req  = "http://gdata.youtube.com/feeds/api/videos?alt=json-in-script&callback=showMyVideos&max-results=10&format=5&q=" + modelCode;
	
	bObj = new JSONscriptRequest(req); 
	bObj.buildScriptTag(); 
	bObj.addScriptTag();
	
}

function loadVideo(playerUrl, autoplay) {
	  swfobject.embedSWF(
	      playerUrl + '&rel=1&border=0&fs=1&autoplay=' + 
	      (autoplay?1:0), 'player', '290', '250', '9.0.0', false, 
	      false, {allowfullscreen: 'true'});
	}

	function showMyVideos(data) {
	  bObj.removeScriptTag();
	  var feed = data.feed;
	  var entries = feed.entry || [];
	  var html = ['<ul class="videos">'];
	  for (var i = 0; i < entries.length; i++) {
	    var entry = entries[i];
	    var title = entry.title.$t.substr(0, 20);
	    var thumbnailUrl = entries[i].media$group.media$thumbnail[0].url;
	    var playerUrl = entries[i].media$group.media$content[0].url;
	    html.push('<li onclick="loadVideo(\'', playerUrl, '\', true)">',
	              '<span class="titlec">', title, '...</span><br /><img src="', 
	              thumbnailUrl, '" width="130" height="97"/>', '</span></li>');
	  }
	  html.push('</ul><br style="clear: left;"/>');
	  document.getElementById('videos2').innerHTML = html.join('');
	  if (entries.length > 0) {
	    loadVideo(entries[0].media$group.media$content[0].url, false);
	  }
	  
	}