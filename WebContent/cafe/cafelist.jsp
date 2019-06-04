<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/public.jsp"%>
<c:set var="root" value="${pageContext.request.contextPath}"></c:set>

<style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:92%;}
.bg_white {background:#fff;}

#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;text-align:center;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F; margin:3px 0;}
/* #menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}*/
#menu_wrap button {margin-left:5px;}

#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;text-align:left;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}

#mapPagination {margin-top: 5%; margin-bottom: 5%;}
/* #mapPagination {margin:10px auto;text-align: center;}
#mapPagination a {display:inline-block;margin-right:10px;}
#mapPagination .on {font-weight: bold; cursor: default;color:#777;} */
</style>

<jsp:include page="/common/bar_top.jsp"/>

<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	<div id="menu_wrap">
        <form method="post" onsubmit="searchPlaces(1); return false;">
                   키워드 : <input type="text" value="" id="keyword" size="15"> 
            <button class="btn btn-default;" type="submit">검색</button>
        </form>
        <hr>
        <ul class="list-group" id="placesList"></ul>
        <ul class="pagination" id="mapPagination">
        </ul>
    </div>
</div>

<script type="text/javascript" src="${root}/js/cafe.js?ver=1"></script>
<script type="text/javascript" src="http://apis.daum.net/maps/maps3.js?apikey=8f8ee57f5e7c782aaf7b9915e4af3f97&libraries=services"></script>
<script>
// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new daum.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new daum.maps.InfoWindow({zIndex:1});

// 키워드로 장소를 검색합니다

searchPlaces(1);

// 키워드 검색을 요청하는 함수입니다
var searchKeyword;

function searchPlaces(page) {
	if (window.sessionStorage) {
		searchKeyword = sessionStorage.getItem('keyword');
		if($('#keyword').val()){
			sessionStorage.setItem('keyword', $('#keyword').val());
			searchKeyword = sessionStorage.getItem('keyword');
		}
		$('#keyword').val(searchKeyword);
	}

    if (!searchKeyword.replace(/^\s+|\s+$/g, '')) {
        alertify.alert('키워드를 입력해주세요!').set('frameless', true);
        return false;
    }
    if(searchKeyword.includes('카페') && (searchKeyword.indexOf('카페') + 2) == searchKeyword.length) {
    	searchKeyword = searchKeyword.substring(0, searchKeyword.indexOf('카페'));
    }
    
    searchKeyword = encodeURIComponent(searchKeyword + '카페');
    var url = 'https://apis.daum.net/local/v1/search/keyword.json?apikey=8f8ee57f5e7c782aaf7b9915e4af3f97&page='+page+'&query='+searchKeyword;
    var data;
    $.getJSON(url+'&callback=?' , function(json){
    	var items = json.channel.item;
    	var totalCount = json.channel.info.totalCount;
    	inputCafeInfo(items);
    	displayPagination(totalCount, page);
		$.each(items, function(i, item){
			var latitude = item.latitude;
			var longitude = item.longitude;
			if(i == 0){
				var options = { //지도를 생성할 때 필요한 기본 옵션
					center: new daum.maps.LatLng(latitude, longitude), //지도의 중심좌표.
					level: 3 //지도의 레벨(확대, 축소 정도)
				};
				map = new daum.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴
			}
		});
	});
}

function inputCafeInfo(items){
	$.ajax({
		method: 'post',
		url: root + '/inputCafeInfo.cafetale',
		dataType: 'json',
		processData : true,
		contentType : 'application/json; charset=UTF-8',
		data: JSON.stringify(items),
		success: function(data) {
			displayPlaces(data.cafeInfoList);
		},
		error: function(e) {
			alert('inputCafeInfo에러' + e);
		}
	});
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
/* function placesSearchCB(status, data, pagination) {
    if (status === daum.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data.places);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === daum.maps.services.Status.ZERO_RESULT) {
        alertify.alert('<b>검색 결과가 존재하지 않습니다.</b>').set('frameless', true);
        return;
    } else if (status === daum.maps.services.Status.ERROR) {
    	alertify.alert('<b>검색 결과 중 오류가 발생했습니다.</b>').set('frameless', true);
        return;
    }
}*/

// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(cafeInfoList) {
    var listEl = document.getElementById('placesList'),
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(),
    bounds = new daum.maps.LatLngBounds(), 
    listStr = '';
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();

    for ( var i=0; i<cafeInfoList.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new daum.maps.LatLng(cafeInfoList[i].latitude, cafeInfoList[i].longitude),
            marker = addMarker(placePosition, i),
            itemEl = getListItem(i, cafeInfoList[i], '${loginUserInfo.member_id}'); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function(marker, title) {
            daum.maps.event.addListener(marker, 'mouseover', function() {
                displayInfowindow(marker, title);
            });

            daum.maps.event.addListener(marker, 'mouseout', function() {
                infowindow.close();
            });

            itemEl.onmouseover =  function () {
                displayInfowindow(marker, title);
            };

            itemEl.onmouseout =  function () {
                infowindow.close();
            };
        })(marker, cafeInfoList[i].title);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new daum.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions = {
            spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new daum.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new daum.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new daum.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }
    markers = [];
}

function displayPagination(totalCount, page){
	if(totalCount < 15){
		$('#mapPagination').hide();
	} else {
		$('#mapPagination').show();
		if($('#mapPagination').has('li')){
			$('#mapPagination').children('li').remove();
		}
		var util = new mapPageUtil();
		util.totalCnt = totalCount;
		util.pageCnt = 15;
		util.setCurPage(page);
		util.setPageNumber();
		util.setStartEnd();
		util.draw();
	}
}

var mapPageUtil = function(){
	var totalCnt; // 전체 게시물 수
	var pageCnt; // 페이지당 게시물 수
	var curPage; // 현재 페이지
	var pageNumber;// 페이지번호 숫자
	var start;
	var end;

	this.setCurPage = function(curPage){
		this.curPage = curPage;
	}
	this.getCurPage = function(){
		return this.curPage;
	}
	this.setPageNumber = function(){
		this.pageNumber = parseInt(this.totalCnt / this.pageCnt) + (parseInt(this.totalCnt % this.pageCnt) ? 1 : 0);
	}
	this.setStartEnd = function(){
		this.start = (this.curPage - 1) * this.pageCnt;
		this.end = this.curPage * this.pageCnt >= this.totalCnt ? this.totalCnt-1 : this.curPage * this.pageCnt-1;
	}
	this.draw = function(){;
		var content = '<li'+(this.curPage == 1 ? ' class="disabled">' : '>')+'<a href="#" aria-label="Previous"';
		content += (this.curPage == 1 ? '>' : ' onclick="searchPlaces('+(this.curPage-1)+')">');
		content += '<span aria-hidden="true">&laquo;</span></a></li>';
		for(var i=1; i<=this.pageNumber; i++){
			content += '<li'+(i == this.curPage ? ' class="active">' : '>')+'<a href="#"';
			content += (i == this.curPage ? '>'+i+' <span class="sr-only">(current)</span></a>' : ' onclick="searchPlaces('+i+')">'+i+'</a>') + '</li>';
		}
		content += '<li'+(this.curPage == this.pageNumber ? ' class="disabled">' : '>')+'<a href="#" aria-label="Next"';
		content += (this.curPage == this.pageNumber ? '>' : ' onclick="searchPlaces('+(this.curPage+1)+')">');
		content += '<span aria-hidden="true">&raquo;</span></a></li>';
		console.log(content);
		$('#mapPagination').append(content);
	}
}

/* function myCafePagination(curPage, listIndex){

} */

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
/* function displayPagination(pagination) {
    var paginationEl = document.getElementById('mapPagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
} */

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
    infowindow.setContent(content);
    infowindow.open(map, marker);
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}         
</script>
</body>
</html>