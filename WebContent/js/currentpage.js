function getCurrentPage(){
	var currentPage = document.location.href; 
	//현재 전체 주소를 가져온다. 예) http://www.naver.com
	currentPage = currentPage.slice(7); 
	//slice를 이용하여 앞에 http:// 빼고 가져올 수 있다. slice는 특정 인덱스부터 잘라낸다.
	arr = currentPage.split("/");
	//URL의 "/" 뒤에 나오는 값을 화용하여 split 이용하여 자를 수 있다.
	currentPage = arr[2];
	//  "/"에서 자른 것들을 배열로 저장되는데 2로 하면 2번째 위치 값이 내가 얻고자하는 값이다.
	return currentPage;
}