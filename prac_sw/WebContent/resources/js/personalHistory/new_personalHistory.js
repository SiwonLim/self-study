"use strict";//엄격한 문법검사

//페이지 로드시 바로 실행
$(window).on("load",function(){
	$.datepicker.setDefaults({
		showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
        ,changeYear: true //콤보박스에서 년 선택 가능
        ,changeMonth: true //콤보박스에서 월 선택 가능                              
        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
		,dateFormat: 'yy-mm-dd' //Input Display Format 변경
	});
	
	btnEve(); // 버튼이벤트
	commonEve(); // 기타 이벤트
	
	$(".dateInput").removeClass('hasDatepicker').datepicker();
	$("input").prop("autocomplete","off"); // 자동완성 사용안함
});

var btnEve = function(){
	// textarea 내용 입력시 높이 자동 수정
	$(document).on( "keyup", "textarea", function (e){
		resize($(this));
	});
	
	//저장 버튼
	$(".personalHistorySaveBtn").click(function(){
		let check = regexAndEmptyCheck();//등록 전에 폼이 유효한지 검사
		if(check){//폼의 내용이 유효하면 등록처리
			//테이블의 값을 json으로 가져오기
			let getHistoryData = getTableUserInfos();//개인이력카드 작성 내용 데이터로 치환
			//flexibleTable 동적 데이터값 데이터로 치환
			let getFlxData = flexibleTableGetData();
			console.log("flxibleTableGetData() : "+getFlxData);
			//json데이터 key설정
			getFlxData = {"flexibleTable":JSON.stringify(getFlxData)};
			//전송하기 위해 고정데이터와 동적데이터 합치기
			let submitDataObj = $.extend(getHistoryData,getFlxData);
			//개인 이력카드 저장
			registerUsingAjax(getHistoryData);
		}
	});
	
	//초기화 버튼
	$('.personalHistoryResetBtn').click(function(){
		if(confirm("내용을 초기화 하시겠습니까?")){
			resetInput();
		}
	});
	
	//테이블 행 추가 버튼
	$(".addRowBtn").click(function(){
		let $eveObj = $(this);
		addRowBtnEve($eveObj);
	});
}

/**
 * 일반 이벤트 정의
 */
var commonEve = function(){
	// 불러오기 창 드래거블
	$("#drag-ele1").draggable();
};