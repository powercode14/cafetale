var root = "/cafetale";
var result;
function join(){
	if(!$("#member_id").val()) {
		alertify.alert("아이디는 필수 입력사항입니다.").set('frameless', true);
		return;
	} else if(!result || result.innerHTML.includes("아이디가") || result.innerHTML.includes("최대길이")){
		alertify.alert("사용 가능한 아이디를 입력해주세요.").set('frameless', true);
		return;
	} else if(!$("#member_pw").val()) {
		alertify.alert("비밀번호는 필수 입력사항입니다.").set('frameless', true);
		return;
	} else if($("#member_pw").val() != $("#member_pw_check").val()) {
		alertify.alert("비밀번호가 서로 다릅니다.").set('frameless', true);
		return;
	} else if(!$("#member_name").val()) {
		alertify.alert("이름은 필수 입력사항입니다.").set('frameless', true);
		return;
	} else if(!$("#member_email").val()) {
		alertify.alert("이메일은 필수 입력사항입니다.").set('frameless', true);
		return;
	} else {
		if(!$("#register_img").val()){
			var image = '<input type="hidden" name="member_image" value="C:/javadata/workspace_sts/cafetale/WebContent/image/default.png"/>';
			$('#joinform').append(image);
			$('#register_img').remove();
		}
		var hidden = '<input type="hidden" name="page" value="' + document.location.href + '"/>';
		$("#joinform").append(hidden);
		$("#joinform").submit();
	}
}

function idcheck(){
	var memberid = $("#member_id").val();
	result = document.getElementById("idresult");
	if(memberid.length < 4) {
		result.innerHTML = "<font color='red'>아이디가 짧습니다.(4~12자 이내)</font>";
	} else if(memberid.length > 12) {
		result.innerHTML = "<font color='red'>아이디의 최대길이를 넘었습니다.(4~12자 이내)</font>";
	} else {
		var param = "id=" + memberid;
		sendRequest(root + "/idcheck.cafetale", param, idcheckresultview, "GET");
	}
}

function idcheckresultview(){
	if(httpRequest.readyState == 4) {
		if(httpRequest.status == 200) {
			var idcnt = httpRequest.responseText;
			var color = "red";
			var yn = "불가능";
			if(idcnt == 0){ 
				color = "blue";
				yn = "가능";
			}
			result.innerHTML = "<font color='" + color + "'>사용" + yn + "한 아이디입니다.";
		}
	}
}

function passwordCheck(){
	var password1 = $("#member_pw").val();
	var password2 = $("#member_pw_check").val();
	var passwordcheckresult = document.getElementById("passwordcheckresult");
	if(password1 && password2 && (password1 == password2)){
		passwordcheckresult.innerHTML = "<font color='blue'>비밀번호가 일치합니다.</font>";
	} else {
		passwordcheckresult.innerHTML = "<font color='red'>비밀번호가 일치하지 않습니다.</font>";
	}
}

function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
     
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1); //어제날짜를 쿠키 소멸날짜로 설정
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}

function goPopup(){
	var pop = window.open(root + "/member/addresspopup.jsp","pop","width=570,height=420, scrollbars=yes"); //경로는 시스템에 맞게 수정하여 사용
}

function jusoCallBack(roadFullAddr, roadAddrPart1,addrDetail,roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn){
	$("#member_address1").val(roadAddrPart1 + ' (우)' + zipNo);
	$("#member_address2").val(addrDetail);
}