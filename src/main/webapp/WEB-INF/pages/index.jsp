<%-- 
    Document   : index
    Created on : Jul 20, 2015, 4:52:18 PM
    Author     : skywalker
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
            <link rel="stylesheet" href="${Constants.URL}css/style.css">
            <script type="text/javascript" src="${Constants.URL}js/jquery-1.9.1.min.js"></script>
	</head>
	<body>
		<header>
                    <div class="logo">
                        <form class="searchMenuSmall" action="${Constants.URL}search" method="GET" id="searchFormSmall">
                            <input type="text" name="find" id="searchBoxSmall">
                            <button type="button" id="searchButtonActiveSmall">
                                Search
                            </button>
                        </form>
                    </div>
			<div class="login">
				<a href="#">
					Alex
				</a>
			</div>
		</header>
		<main>
			<div class="docsList">
				<ul id="mainList">
					<li id="1" onclick="changeDoc('1')">Image(jpg jpeg png)
						<ul id="mainList">
							<li id="1" onclick="changeDoc('1')">Document 1</li>
							<li id="2" onclick="changeDoc('2')">Document 2
								<ul id="mainList">
									<li id="1" onclick="changeDoc('1')">Document 1</li>
									<li id="2" onclick="changeDoc('2')">Document 2</li>
									<li id="3" onclick="changeDoc('3')">Document 3
										<ul id="mainList">
											<li id="1" onclick="changeDoc('1')">Document 1</li>
											<li id="2" onclick="changeDoc('2')">Document 2</li>
											<li id="3" onclick="changeDoc('3')">Document 3</li>
										</ul>
									</li>
								</ul>
							</li>
							<li id="3" onclick="changeDoc('3')">Document 3</li>
						</ul>
					</li>
					<li id="2" onclick="changeDoc('2')">PDF file</li>
					<li id="3" onclick="changeDoc('3')">TXT file</li>
				</ul>
			</div>
			<div class="docPreview">
				<img id="d1" class="displayNone" src="${Constants.URL}files/2.jpg">
				<object id="d2" class="displayNone" data="${Constants.URL}files/1.pdf" type="application/pdf" width="100%" height="99.5%">
					<a href="myfile.pdf"></a>
				</object>
				<object id="d3" class="displayNone" data="${Constants.URL}files/file.txt">
				</object>
			</div>
			<div class="docInfo">
				<div class="docInfoBlock">Title: Document1.jpg</div>
				<div class="docInfoBlock">Uploader: Alex</div>
				<div class="docInfoBlock">Date: 18.04.2015</div>
				<div class="docInfoBlock">Hashtags: document, important</div>
			</div>
		</main>
		<footer>
		</footer>
	</body>
</html>
<script>
	$('main').height(window.innerHeight-$('header').height()-$('footer').height());
	
	//$('.docPreview').width(window.innerWidth-$('.docsList').width()-$('.docInfo').width()-23);
	
	function changeDoc(url){
		$('#d1').addClass('displayNone');
		$('#d2').addClass('displayNone');
		$('#d3').addClass('displayNone');
		$('#d'+url).removeClass('displayNone');
	}
	
	/*
	$.ajax({
        async:false,
        url: 'files/file.txt',
        dataType: 'text',
        success: function(data) 
        {
        $('.docPreview').append(data);
            }
        });
	*/
	
</script>