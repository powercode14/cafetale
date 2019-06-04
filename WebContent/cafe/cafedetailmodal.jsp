<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>

<style>
#cafedetail_image { position:relative; height: 156px; text-align:center; }
p.star_rating.parent() { background-color: yellow; }
p.star_rating { font-size:0; letter-spacing:-4px; text-align: center; margin-bottom: 0%; }
p.star_rating a {
    font-size:15px;
    letter-spacing:0;
    display:inline-block;
    margin-left:0px;
    color:#ccc;
    text-decoration:none;
}
p.star_rating a:first-child { margin-left:0; }
p.star_rating a.on { color:#777; }
#cafedetail_grade { font-size: 15px; }
#cafedetailmodal div.col-sm-3 { padding-left:0%; padding-right:0%; vertical-align: middle; }

</style>
		<div id="cafedetailmodal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			  <div class="modal-content">
			    <div class="modal-header" align="center">
			      <button type="button" class="close" data-dismiss="modal">&times;</button>
			      <h2 class="form-signin-heading" id="cafedetail_title"></h2>
			    </div>
			    <div class="modal-body">
			    	<div class="row">
			    		<div class="col-sm-5">
			    			<div class="thumbnail">
								<img id="cafedetail_image" alt="이미지가 없습니다." src=""/><!-- width="198" height="156" -->
							</div>
			    		</div>
			    		<div class="col-sm-7">
			    			<address id="cafedetail_newAddress"></address>
			    			<address id="cafedetail_zipcode"></address>
			    			<address id="cafedetail_phone"></address>
			    			<div class="row">
					    		<div class="col-sm-2">
						    		<button id="cafedetail_good" type="button" class="btn btn-default btn-sm"></button>
					    		</div>
					    		<div class="col-sm-6" id="divRecommend">
					    			<c:if test="${loginUserInfo.member_id != null}">
					    			<button type="button" class="btn btn-default btn-sm" data-toggle="popover" data-placement="bottom">친구에게 추천하기
					    				<i class="fa fa-user" aria-hidden="true"></i> <i class="caret"></i>
					    			</button>
					    			</c:if>
						    	</div>
					    	</div>
			    		</div>
			    	</div>
			    	<br>
			    	<div class="row">
			    		<div class="col-sm-5">
			    			<b id="cafedetail_grade"></b>
			    		</div>
			    		<div class="col-sm-3" style="text-align:right;">
			    			<b>별점남기기</b>
			    		</div>
			    		<div class="col-sm-3">
							<p class="star_rating">
							    <a href="#">★</a>
							    <a href="#">★</a>
							    <a href="#">★</a>
							    <a href="#">★</a>
							    <a href="#">★</a>
							</p>
			    		</div>
			    	</div>
				</div>
			    <div class="modal-footer">
			      <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			    </div>
		      </div>
		    </div>
	      </div>