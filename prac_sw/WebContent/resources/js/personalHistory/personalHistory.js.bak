"use strict"; // 엄격한 문법 검사

// 페이지 로드시 바로 실행
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


// 버튼 이벤트
var btnEve = function(){
	
	// 저장버튼 클릭시 이벤트 발생
	$(".personalHistorySaveBtn").unbind().click(function(){
		
		var check = regexAndEmptyCheck(); // 등록 전에 폼의 내용이 유효한지 검사
		
		if(check) { // 폼의 내용이 유요하면 등록처리
			var personalHistoryData = personalHistoryGetData(); // 개인이력카드 작성 내용 데이터로 치환

			var flexibleData = flexibleTableGetData(); // 하단의 유동적인 내용 데이터로 치환
			
			flexibleData = {"flexibleData":JSON.stringify(flexibleData)}; // 치환된 배열 데이터를 key를 줌
			
			var submitDataObj = $.extend( personalHistoryData, flexibleData); // 전송하기 위해 고정데이터와 유동데이터 합침
			
			personalHistoryRegisterAjaxSend(submitDataObj); // 개인 이력카드 저장
			
			console.log(submitDataObj);
		}
		
	});
	
	// 초기화 버튼
	$(".personalHistoryResetBtn").unbind().click(function(){
		
		var result = confirm("내용을 초기화 하시겠습니까?");
		
		if(result) resetInput(); // 내용 비워줌
		
	});
	
	
	
	// 테이블 행 추가버튼
	$(".addRowBtn").unbind().click(function(){
		
		var $eveObj = $(this); // 이벤트 발생 객체
		
		addRowBtnEve($eveObj); // 행 추가
		
	});
	
	
	// 불러오기 버튼 클릭시 리스트창 켜고 끄기
	$(".personalHistoryListBtn").click(function(){
		
		var $listPannel = $(".pop-user-register-pannel");
		var listPannelVisible = $listPannel.is(":visible");
	
		if(listPannelVisible){
			$listPannel.css("display","none");
			
		}else{
			$listPannel.css("display","block");
			
			userListPagingView(1);
			
		}
		
	});
	
	
	// 새 이력 작성버튼
	// 초기화랑 다른점은 input #userIdx도 비움
	$(".newHistoryCreateBtn").click(function(){
		
		var result = confirm("새 이력을 작성하시겠습니까?");
		
		if(result){
			resetInput(); // 리셋
			modeChange("NEW"); // 작성모드 변경
		}
		
	});
	
	
	// 불러오기 등록 정보 최소화 버튼
	$(".minimizeUserPannelBtn").click(function(){
		
		var $listPannel = $(".pop-user-register-pannel");
		$listPannel.css("display","none");
		
	});
	
	
	// 불러오기창 검색버튼
	$("#userListSearchBtn").click(function(){
		userListPagingView(1);
	});	
	
	
	// 불러오기 내 검색어 입력창에서 엔터시 검색
	$("#userListSearchWord").keydown(function(key) {
		if (key.keyCode == 13) {
			$("#userListSearchBtn").click();
			$(this).blur();
		}
	});
	
	$("#personalZipcodeSearchBtn").unbind().click(function() {
		daum.postcode.load(function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	            	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('userZipcode').value = data.zonecode;
	                document.getElementById("userAddress").value = addr;
//	                document.getElementById("userAddress").value += ", ";
	                
//	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("userAddress").focus();
//	                alert("상세 주소를 입력해 주세요.")
	            }
	        }).open();
	    });
	});
	
	
	// keyword 추가 버튼
	$(".keywordAddBtn").click(function(){
		var $keywordInputPannel = $(".keywordInputPannel");
		if(!$keywordInputPannel.is(":visible")){
			$keywordInputPannel.removeClass("keyword-input-pannel-invisible");
			$keywordInputPannel.addClass("keyword-input-pannel-visible");
			$(".keywordInputPannel").find("input").focus();
		}
	});
	
	
	// 키워드 추가 버튼에서 엔터시 blur
	$(".keywordInputPannel").find("input").keydown(function(key) {
		if (key.keyCode == 13) {
			$(this).blur();
		}
	});
	
	// 키워드 추가 input에 blur 이벤트 발생 시 
	// 입력한 내용을 검색 키워드로 추가
	$(".keywordInputPannel").find("input").blur(function(){
		var $keywordInputPannel = $(".keywordInputPannel");
		var $inputSelf = $(this);
		
		var val = $inputSelf.val();
		
		$keywordInputPannel.removeClass("keyword-input-pannel-visible");
		$keywordInputPannel.addClass("keyword-input-pannel-invisible");
		
		if(!isEmpty(val)){
			var beforeText = "";
			
			beforeText += '<div class="keyword-body">#';
			beforeText += '<span class="keyword-text">';
			beforeText += val;
			beforeText += '</span><button class="keyword-remove-btn keywordRemoveBtn"><span>X</span></button></div>';
			
			$keywordInputPannel.before(beforeText);
			$inputSelf.val("");
		}
		
	});
	
	// 키워드 삭제 버튼
	$(document).on('click','.keywordRemoveBtn',function(){
		var $keywordObj = $(this).parent(".keyword-body");
		$keywordObj.remove();
	});
	
	
	// 짝 지어진 날짜정보와 비교
	$(document).on('change','.dateInput',function(){
		var $self = $(this);
		var val = $self.val(); 
		
		if(!isEmpty(val) && ($self.hasClass("prevDate") || $self.hasClass("laterDate"))){
			var $parentTr = $self.parents("tr");
			var prevDate = $parentTr.find(".prevDate").val();
			var laterDate = $parentTr.find(".laterDate").val();
			
			var diff = dateDiff(prevDate, laterDate);
			
			if(diff < 0){
				if(!alert("이전 날짜가 이후 날짜보다 클 수 없습니다.")) $self.val("").focus();
			}
		}
		
	});
	
	
	// textarea 내용 입력시 높이 자동 수정
	$(document).on( "keyup", "textarea", function (e){
		resize($(this));
	});
	
	
	// td 빈공간 클릭시 입력창으로 포커스
	// @desc textarea가 포함되어 있기때문에 입력창을 제외한 빈 공간이 존재할 수 있음
	// 그로 인해 사용자가 빈 공간을 클릭 할 경우가 생김으로 자동으로 내부에 있는 입력창에 포커스를 줌
	$(document).on( "click", ".skill-inventory-table td", function (e){
		var $childInput = $(this).find("textarea");
		
		if($childInput.length == 0) $childInput = $(this).find("input");
		
		$childInput.focus();
	});
	
	
	$(".printBtn").click(function(){
		
		$("select").each(function(){
			var $self = $(this);
			var $options = $self.find("option"); 
			var $selectedOption = $self.children("option:selected");
			
			$options.removeAttr("selected");
			$selectedOption.attr("selected","selected");
		});
		
		
		
		$(".user-info-list-pannel").print({
            globalStyles : true,
            mediaPrint : true,
            stylesheet : './resources/css/personalHistory/print.css',
            noPrintSelector : ".no-print",
            iframe : true,
            append : null,
            prepend : null,
            manuallyCopyFormValues : true,
            deferred : $.Deferred(),
            timeout : 750,
            title : null,
            doctype : '<!doctype html>'
        });
	});
	
};



/**
 * 일반 이벤트 정의
 */
var commonEve = function(){
	
	// 불러오기 창 드래거블
	$("#drag-ele1").draggable();
	
};

/**
 * 유동테이블 각 로우에 삭제버튼 추가
 */
var makeTrAppendRemoveBtn = function(){
	
	var btnStr = '<button style="display:none;" class="removeTrBtn">-</button>';
	
	$(".flexibleTable").find("tr").append(btnStr);
	
};

