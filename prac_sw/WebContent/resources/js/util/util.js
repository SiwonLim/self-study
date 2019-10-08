// 넘어온 값이 빈값인지 체크합니다.
// !value 하면 생기는 논리적 오류를 제거하기 위해
// 명시적으로 value == 사용
// [], {} 도 빈값으로 처리
var isEmpty = function(value) {
	if (value == ""
			|| value == null
			|| value == undefined
			|| value == "undefined"
			|| (value != null && typeof value == "object" && !Object
					.keys(value).length)) {
		return true
	} else {
		return false
	}
};

/**
 * 페이징 텍스트 리턴
 * 
 * totalCnt 전체레코드수
 * dataSize 페이지당 보여줄 데이타수
 * pageNo 페이지 그룹 범위 1 2 3 5 6 7 8 9 10
 * token 현재페이지
 */
var paging = function(totalCnt, dataSize, pageSize, pageNo, token){
	totalCnt = parseInt(totalCnt);// 전체레코드수
	dataSize = parseInt(dataSize); // 페이지당 보여줄 데이타수
	pageSize = parseInt(pageSize); // 페이지 그룹 범위 1 2 3 5 6 7 8 9 10
	pageNo = parseInt(pageNo); // 현재페이지
	
	var html = new Array(); 
	if(totalCnt == 0){ return ""; } // 페이지 카운트
	
	var pageCnt = totalCnt % dataSize;
	if(pageCnt == 0){
		pageCnt = parseInt(totalCnt / dataSize);
	}else{
		pageCnt = parseInt(totalCnt / dataSize) + 1;
	}
	
	var pRCnt = parseInt(pageNo / pageSize);
	
	if(pageNo % pageSize == 0){
		pRCnt = parseInt(pageNo / pageSize) - 1;
	} // 이전
																																																																	// 화살표
	if(pageNo > pageSize){
		var s2;
		if(pageNo % pageSize == 0){
			s2 = pageNo - pageSize;
		}else{
			s2 = pageNo - pageNo % pageSize;
		}
		
		html.push('<a href=javascript:' + token + '("');
		html.push(s2);
		html.push('");>');
		html.push('◀');
		html.push("</a>");
		
		}else{
			
			html.push('<a href="#">\n');
			html.push('◀'); html.push('</a>');
		} // paging
																																																																																		// Bar
	for(var index=pRCnt * pageSize + 1; index<(pRCnt + 1)*pageSize + 1;index++){
		if(index == pageNo){
			html.push('<strong>');
			html.push(index); html.push('</strong>');
		}else{
			html.push('<a href=javascript:' + token + '("');
			html.push(index); html.push('");>'); html.push(index);
			html.push('</a>');
		}if(index == pageCnt){
			break;
		}else html.push(' ');
	} // 다음
																																																																																									// 화살표
	if(pageCnt > (pRCnt + 1) * pageSize){
		html.push('<a href=javascript:' + token + '("');
		html.push((pRCnt + 1)*pageSize+1); html.push('");>');
		html.push('▶'); html.push('</a>');
	}else{
		html.push('<a href="#">');
		html.push('▶');
		html.push('</a>');
	} 
	
	return html.join("");
}




//두개의 날짜를 비교하여 차이를 알려준다.
function dateDiff(date1, date2) {
	var date1Arr = date1.split("-");
	var date2Arr = date2.split("-");
	
	var stDate = new Date(parseInt(date1Arr[0]), parseInt(date1Arr[1]), parseInt(date1Arr[2])) ;
    var endDate = new Date(parseInt(date2Arr[0]), parseInt(date2Arr[1]), parseInt(date2Arr[2])) ;
 
    var btMs = endDate.getTime() - stDate.getTime() ;
    var btDay = btMs / (1000*60*60*24) ;
    return btDay;
}


// 로딩 화면 켜고 끄기
var loading = function(onoff){
	
	if(onoff == "ON"){
		//$("body").prepend('<div class="custom-loading"><div class="loading-image"></div></div>');
		$('body').loading({
			overlay: $(".custom-loading")
		});		
	}else{
		$('body').loading("stop");
	}
}


// 오브젝트 높이 재설정
function resize($obj) {
	$obj.height(1).height($obj.prop('scrollHeight')+12);
}


function replaceAll(str, target, replacement){
  return str.split(target).join(replacement);
};



function htmlCharRun(str){
  var tmp=replaceAll(str,'\t',"&nbsp;&nbsp;&nbsp;&nbsp;");
  tmp=replaceAll(tmp,'<',"&lt;");
  tmp=replaceAll(tmp,'>',"&gt;");
  tmp=replaceAll(tmp,'\n',"<br>");
  return tmp;
};



function htmlCharDerun(str){
  var tmp=replaceAll(str,"<br>",'\r\n');
  return tmp;
}