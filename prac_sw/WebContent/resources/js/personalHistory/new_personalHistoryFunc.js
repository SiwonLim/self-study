"use strict"; // 엄격한 문법 검사

/**
 * 유효성 검사
 * 
 * @desc 사용자가 개인이력카드 등록 및 수정 시 등록 가능한 정보를 입력 하였는지 검사하여
 * 		잘못된 부분이 있으면 메세지 알림 후 해당 폼으로 포커스
 */
var regexAndEmptyCheck = function() {
	var val;
	var $obj;
	var regExp;
	var regResult;
	
	var isNew = $("#userIdx").val() == ""? true:false;
	
	// 이름
	$obj = $("#userName");
	val = $obj.val().trim();
	if (val == "") {
		if(!alert("이름은 필수 입력 사항입니다.")) $obj.focus();
		return false;
	};
	
	// 주민등록번호
	
	if(isNew){ // 새 이력 작성인경우 주민등록번호 유효성 검사
		
		$obj = $("#userSocialSecunum");
		val = $obj.val().trim();
		regExp = new RegExp("^\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])\\-?[1-4][0-9]{6}$");
		if (val == ""){
			if(!alert("주민등록번호는 필수 입력 사항입니다.")) $obj.focus();
			return false;
		};
		regResult = regExp.test(val);
		if(!regResult){
			if(!alert("잘못 된 주민등록번호 입니다.")) $obj.focus();
			return false;
		}
				
	}
	
	// 휴대전화번호
	
	$obj = $("#userTelnumWireless");
	val = $obj.val().trim();
	regExp = /^\d{3}-\d{3,4}-\d{4}$/;
	regResult = regExp.test(val);
	if(!regResult && !isEmpty(val)){
		if(!alert("잘못 된 휴대전화번호 입니다.")) $obj.focus();
		return false;
	}
	
	
	// 유선전화번호
	
	$obj = $("#userTelnumWired");
	val = $obj.val().trim();
	regExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
	regResult = regExp.test(val);
	if(!regResult && !isEmpty(val)){
		if(!alert("잘못 된 전화번호 입니다.")) $obj.focus();
		return false;
	}
	
	// 이메일
	$obj = $("#userEmail");
	val = $obj.val().trim();
	regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	regResult = regExp.test(val);
	if(!regResult && !isEmpty(val)){
		if(!alert("잘못 된 이메일 입니다.")) $obj.focus();
		return false;
	}
	return true;
};

/**
* 개인이력카드 고정형 데이터 치환
* @desc user-info-table1,user-info-table2 form으로 부터 데이터를 받아 JSON 데이터 형태로 치환한다.
* @return JSON Object submitDataObj : 치환한 고정형 데이터를 JSON.parse하여 리턴 
*/
var getTableUserInfos = function(){
	var userDataObjArr=[];
	var userDataObjPlainText="";
	//테이블의 input,select값을 가져온다
	$(".user-info-table1, .user-info-table2").find("input, select").each(function(){
		var nowLoopData = this;
		var nowLoopId = $(nowLoopData).attr("id")+"";
		var nowLoopValue = $(nowLoopData).val()+"";
		
		//JSON형태로 치환_1 "key": "value"
		var nowDataPlainText ='"'+nowLoopId+'":"'+nowLoopValue+'"';
		var isNew = ($("userIdx").val() == "") ? true : false;
		// 해당 키에 내용이 없으면 전송 데이터에서 제외(루프는 진행) || 수정모드시 주민등록번호 전송 제외
		if(nowLoopValue == "" || !isNew && nowLoopId == "userSocialSecunum"){
			return true;
		}
		else{
			userDataObjArr.push(nowDataPlainText);
		}
	});
	
	//JSON형태로 치환_2 {"key": "value"}
	userDataObjPlainText = "{"+userDataObjArr.join(",")+"}";
	//매퍼에서 변수 사용시 변수명 뒤에[0] 붙여야함
	var submitDataObj = JSON.parse(userDataObjPlainText);
	console.log(submitDataObj);
	return submitDataObj;
}

/**
*개인 이력카드 저장
*@desc json화 된 데이터를 ajax로 controller에 보냄
*@param submitDataObj : 일단 .user-info-table1, .user-info-table2 데이터만 받아서 저장
*/
var registerUsingAjax = function(jsonData){
	console.log(jsonData);
	loading("ON");
	var userIdxVal = $("#userIdx").val();
	var userIdxObj = {"userIdx":userIdxVal};
	
	//param과 {"userIdx":userIdxVal} 합치기
	var extendedJson = $.extend(jsonData,userIdxObj);
	console.log("extended Json : "+extendedJson);
	
	var url="";
	if(isEmpty(userIdxVal)){//새로운 작성
		url = "./personalHistory/registerUser";
	}
	else{
		alert("./personalHistory/registerUserUpdate 페이지 추가하삼");
		return true;
		//url 추가할것..
	}
	
	$.ajax({
		url : url,
		type : 'post',
		data : JSON.stringify(extendedJson),
		dataType : 'json',
		contentType:'application/json; charset=utf-8',
		success : function(data){
			//리턴 값들을 받아온다
			let userIdx = data.userIdx;
			let errorCode = data.errorCode;
			let errorMsg = data.errorMsg;
			if(isEmpty(errorCode)){
				$("#userIdx").val(userIdx);
				userListPagingView();//리스트 새로 불러오기
				modeChange("UPDATE");//저장 후 상단 상태 변경
			}
			alert("작성한 내용이 저장되었습니다.");
		}, error : function(){
			alert("저장 오류");
		}, complete : function(){
			loading("OFF");
		}
	});
}
var setData=function(getData){
	$("#userIdx").val(getData);
}
/**
* [+] 행 추가 버튼
* @desc 여러 테이블에서 같이 사용하므로 기준이 되는 obj를 받음
* @param $eveObj
*/
var addRowBtnEve = function($eveObj){
	let btnStr = '<button style="display:none;" class="removeTrBtn">-</button>';
	let $tbodyObj = $eveObj.parent().prev().find("tbody");//데이터가 들어가는 <tbody>테이블을 찾는다
	//tbody의 첫번째 tr의 html값을 찾는다
	let firstRowText = "<tr>"+$tbodyObj.find("tr:first-child").html()+"</tr>";
	$tbodyObj.append(firstRowText);
	
	let $addTr = $tbodyObj.find("tr:last-child");//datapicker있는 td
	$addTr.append(btnStr);//버튼 추가
	flexibleTableTrEve();//추가된 삭제버튼에 이벤트 할당
	
	$addTr.find("textarea").text("").height(30);
	//dataInput으로 써서 달력 적용 안됬었음; 오타 주의
	$addTr.find(".dateInput").attr("id","").removeClass('hasDatepicker').datepicker();//데이트피커 재정의
}

/**
 * [+]로 생성한 테이블 삭제 이벤트 재정의
 * @desc 유동 데이터 테이블 행이 추가 될 경우 해당 행과 다른 모든 행에 삭제 이벤트를 재정의 해준다.
 */
var flexibleTableTrEve=function(){
	$(".removeTrBtn").click(function(){
		let $btnSelf = $(this);//값 자체를 가져오는건감
		let $parentTr = $btnSelf.parent();
		let parentTbody = $parentTr.parent();
		$parentTr.remove();
	});
	$(".flexibleTable").find("tbody").find("tr").hover(function(){
		let $trSelf = $(this);
		let $childRemoveBtn = $trSelf.find(".removeTrBtn");
		$childRemoveBtn.css("display","block");
	},function(){
		let $trSelf = $(this);
		let $childRemoveBtn = $trSelf.find(".removeTrBtn");
		$childRemoveBtn.css("display","none");
	});
}

/**
* [+]로 생성한 동적테이블 데이터로 치환
* @desc 동적데이터를 json 형태로 치환한다
* @return Json Object flexDataObj : 치환한 데이터를 JSON.parse 하여 리턴 
*/
var flexibleTableGetData = function(){
	
	var dataPlainText = "[";
	
	$(".flexibleTable").find("tbody").find("tr").each(function(i){ // 유동 테이블 반복하며 데이터 획득
		
		var $trSelf = $(this);
		var tbName = $trSelf.parent().parent().attr("tb"); 
		
		if(i != 0) dataPlainText += ",";
		var trDataText = "{";
		
		$trSelf.find("input, select, textarea").each(function(j){
			
			var $tdSelf = $(this);
			
			var key = $tdSelf.attr("data");
			var val = htmlCharRun($tdSelf.val()); // html 특수문자 치환
			
			if(j == 0) trDataText += '"tbName":"' + tbName + '"';
			
			if(val == "") return true; // 값이 비어있으면 굳이 만들지 않아도 되기때문에 다음 루프로 넘김
			
			trDataText += ",";
			trDataText += '"' + key + '":' + '"' + val + '"';
			
		});
		
		trDataText += "}";
		dataPlainText += trDataText;
		
	}); // tbody
	
	dataPlainText += "]";
	
	var flexibleDataObj = JSON.parse(dataPlainText);
	console.log("flexibleTableGetData : "+flexibleDataObj);
	return flexibleDataObj;
};

/**
 * 작성창 초기화
 * @desc 작성창 초기화
 */
var resetInput=function(){
	//고유 id, 검색창, 한번에 보여지는 데이터 갯수, 페이지사이즈, 페이지넘버, 우편번호
	let ids = "#userIdx, #userInfoTotalCnt, #userInfoDataSize, #userInfoPageSize, #userInfoPageNo, #personalZipcodeSearchBtn";
	let $flexibleTable = $(".flexibleTable");
	$("input, select").not(ids).val("");//ids빼고 전부 초기화
	$("textarea").not(ids).text("");
	$flexibleTable.find("tbody").find("tr:not(:first-child)").remove();
	$flexibleTable.find(".dateInput").attr("id","").removeClass("hasDatepicker").datepicker();
	$("textarea").each(function(){resize($(this));})
}

/**
* 리스트 및 페이징 호출(불러오기)
*/
var userListPagingView = function(nowPage){
}

/**
* 모드전환
* @desc 작성 모드를 전환
* @param "NEW" : 새 작성모드 / "UPDATE" 수정모드
*/
var modeChange = function(mode){
	//정보 가져오기
	let $topHeaderStatus = $(".top-header-pannel").find("h5");
	let userIdx = $("#userIdx").val();
	let $userSocialSecunum = $("#userSocialSecunum");
	let $userInfoListPannel = $(".user-info-list-pannel");
	
	if(mode == "NEW"){
		$topHeaderStatus.text("※ 새 이력 작성");
		$("#userIdx").val("");
		$userSocialSecunum.prop("disabled",false);
		$userInfoListPannel.css("background-color","#ebf2f1");
	}
	else if(mode == "UPDATE"){
		$topHeaderStatus.text("※ 등록번호 : "+userIdx+" (수정)");
		$userSocialSecunum.prop("disabled",true);
		$userInfoListPannel.css("background-color","#e3e1f3");
	}
}