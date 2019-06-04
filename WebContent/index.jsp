<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/public.jsp"%>
<style>
#popularDiv>a { width: 100%; white-space: nowrap; overflow: hidden; word-break:break-all; text-overflow: ellipsis; }
</style>
<script>
$(document).ready(function(){
	$.ajax({
		type: 'GET',
		url: '${root}/popularArticle.cafetale',
		dataType: 'json',
		success: function(data) {
			var popularList = data.popularList;
			if(Object.keys(popularList).length){
				for(var i=0; i<Object.keys(popularList).length; i++){
					$('#popularDiv').append('<a href="#" onclick="moveBoard('+popularList[i].idx+');" class="btn btn-link"><b>'+(i+1) + '. 【'+ popularList[i].cafe_title +'】 '+ popularList[i].title +'</b></a><br>')
				}
			} else {
				$('#popularDiv').append('<b>게시물이 없습니다.</b><br><br><a href="#" onclick="writeBoard();" class="btn btn-primary">첫 번째 게시물 작성하기</a>');
			}
		},
		error: function(e) {
			alert('popularArticle 에러 : ' + e);
		}
	});
});

function moveBoard(idx){
	sessionStorage.setItem('idx', idx);
	sessionStorage.setItem('boardPage', 1);
	location.href = '${root}/moveBoard.cafetale';
}

function writeBoard(){
	sessionStorage.setItem('firstWrite', true);
	location.href = '${root}/writeBoard.cafetale';
}
</script>
  <div class="cover">
    <jsp:include page="/common/bar_top.jsp"/>
    <div class="cover-image" style="background-image : url('${root}/image/home.jpg');"></div>
    <div class="container">
      <div class="row">
        <div class="col-sm-12 text-center">
          <h1 class="text-inverse"><strong>Café Tale</strong></h1>
          <p class="text-inverse lead">우리들의 인생카페를 찾기 위한 이야기</p>
        </div>
	  </div>
	  <div class="row">
	    <div class="col-sm-4 col-sm-offset-4 text-center">
	      <div class="panel panel-default" style="opacity: 0.8;">
		    <div class="panel-heading">
		      <b class="panel-title">신규 게시물</b>
		    </div>
		    <div class="panel-body" id="popularDiv">
		    </div>
		  </div>
	    </div>
	  </div>
	  <br>
	  <div class="row">
        <div class="col-sm-4 col-sm-offset-4">
          <form class="input-group" action="${root}/cafeSearch.cafetale" onsubmit="javascript:search(); return false;">
            <input id="keyword" name="keyword" type="text" class="form-control" placeholder="예) 홍대"/>
            <span class="input-group-btn">
              <button id="searchButton" type="submit" class="btn btn-default">검색</button>
            </span>
          </form>
        </div>
        <script type="text/javascript">
			function search() {
				var keyword = document.getElementById('keyword').value;
		   	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		   	        alert('키워드를 입력해주세요!');
		   	        return false;
		   	    }
		   	    if(keyword.indexOf('카페') >= 0){
		   	    	keyword = keyword.substring(0, keyword.indexOf('카페'));
		   	    }
				if(window.sessionStorage) {
					sessionStorage.setItem('keyword', keyword);
				}
		   	    document.getElementById('searchButton').submit();
        	}
        </script>
        <div class="col-sm-4"></div>
      </div>
    </div>
  </div>
</body>
</html>