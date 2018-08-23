<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<%@ include file="/WEB-INF/include/include-side.jspf" %>
		<div class="col-md-8 content">
			<hr />
			<div class="col-md-6 col-md-offset-3">
				<h2>아이디 찾기</h2>
				<form id="findIdForm" name="findIdForm">
					<div class="form-group">
						<label for="inputEmail">이메일</label>
						<input type="text" class="form-control" id="inputEmail" name="inputEmail" placeholder="이메일 주소">
						<p class="help-block">가입시 사용한 이메일을 입력해 주세요.</p>
					</div>
					<div class="form-group text-center">
						<button id="findId" type="submit" class="btn btn-info">
							아이디 찾기<i class="fa fa-check spaceLeft"></i>
						</button>
					</div>
				</form>
				<h2>비밀번호 찾기</h2>
				<form id="findPwForm" name="findPwForm">
					<div class="form-group">
						<label for="inputId">아이디</label>
						<input type="text" class="form-control" id="inputId" name="inputId" placeholder="아이디">
					</div>
					<div class="form-group">
						<label for="inputEmail2">이메일 주소</label>
						<input type="email" class="form-control" id="inputEmail2" name="inputEmail2" placeholder="이메일 주소">
					</div>
					<div class="form-group text-center">
						<button id="emailAuth" type="submit" class="btn btn-info">
							이메일 인증<i class="fa fa-check spaceLeft"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
		<div class="col-md-2"></div>
	</div>	
		
		
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
	
		$(document).ready(function() {
			
			$("#findId").on("click", function(e) { //아이디 찾기 버튼
				e.preventDefault();
				if($('#inputEmail').val() == null || $('#inputEmail').val() == "undefine" || $('#inputEmail').val() == "null" || $('#inputEmail').val() == ""){
					alert("이메일 주소를 입력 해 주세요");
					return false;
				}
				var insertData = $('#findIdForm').serialize();
				fn_findId(insertData);					
			});

			$("#emailAuth").on("click", function(e) { //비밀번호 찾기 버튼
				e.preventDefault();
				if($('#inputId').val() == null || $('#inputId').val() == "undefine" || $('#inputId').val() == "null" || $('#inputId').val() == ""){
					alert("아이디를 입력 해 주세요");
					return false;
				}
				if($('#inputEmail2').val() == null || $('#inputEmail2').val() == "undefine" || $('#inputEmail2').val() == "null" || $('#inputEmail2').val() == ""){
					alert("이메일 주소를 입력 해 주세요");
					return false;
				}
				var insertData = $('#findPwForm').serialize();
				fn_findPw(insertData);					
			});
			
		});

		function fn_findId(insertData) {
			var w = 400;
			var h = 100;
			var xPos = (document.body.clientWidth / 2) - (w / 2); 
		    	xPos += window.screenLeft;  //듀얼 모니터일때....
		   	var yPos = (screen.availHeight / 2) - (h / 2);
			var win = window.open('','new window',"width="+w+",height="+h+", left="+xPos+", top="+yPos+", toolbars=no, resizable=no, scrollbars=no");
			$.ajax({
				url:'/first/member/findId.do',
				type:'post',
				data:insertData,
				success:function(data){
					if(data.isSuccess){
						win.document.write("<html><head><title>코뿌롱</title></head><body><h1 style='font-size:12pt;padding:5px;text-align: center;'>"+data.msg+"</h1><p style='text-align: center;'>["+data.id+"]</p></body></html>");
					}else{
						win.document.write("<html><head><title>코뿌롱</title></head><body><h1 style='font-size:12pt;padding:5px;text-align: center;'>"+data.msg+"</h1></body></html>");
					}
				}

			});
		}
		function fn_findPw(insertData) {
			var w = 500;
			var h = 300;
			var xPos = (document.body.clientWidth / 2) - (w / 2); 
		    	xPos += window.screenLeft;  //듀얼 모니터일때....
		   	var yPos = (screen.availHeight / 2) - (h / 2);
			var win = window.open('','popwindow',"width="+w+",height="+h+", left="+xPos+", top="+yPos+", toolbars=no, resizable=no, scrollbars=no");
			$.ajax({
				url:'/first/member/sendAuthNo.do',
				type:'post',
				data:insertData,
				success:function(data){
					console.log(data);
					if(data.isSuccess) {
						win.location.href = '/first/member/emailAuth.do';
					}else{
						win.document.write("<html><head><title>코뿌롱</title></head><body><h1 style='font-size:12pt;padding:5px;text-align: center;'>"+data.msg+"</h1></body></html>");
						return false;
					}
				}

			});
		}
	</script>	
</body>
</html>