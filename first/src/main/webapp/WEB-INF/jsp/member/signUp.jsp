<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<%@ include file="/WEB-INF/include/include-side.jspf" %>
		<div class="col-md-8 content">
			<hr />
			<div class="col-md-6 col-md-offset-3">
				<h2>회원가입</h2>
				<form id="signUpForm" name="signUpForm">
					<div class="form-group">
						<label for="InputId">아이디</label>
						<div class="input-group">
							<input type="text" class="form-control" id="inputId" name="inputId" placeholder="아이디">
							<span class="input-group-btn"><button class="btn btn-default" type="button" id="idCheck">중복확인</button></span>
						</div>
						<p class="help-block">숫자, 영문 소문자로 이루어진 6~20자리</p>
					</div>
					<div class="form-group">
						<label for="InputEmail">이메일 주소</label>
						<input type="email" class="form-control" id="inputEmail" name="inputEmail" placeholder="이메일 주소">
					</div>
					<div class="form-group">
						<label for="InputPassword1">비밀번호</label> 
						<input type="password" class="form-control" id="inputPassword1" name="inputPassword1" placeholder="비밀번호">
						<p class="help-block">숫자, 영문 대소문자, 특수문자 포함 8~20자리</p>
					</div>
					<div class="form-group">
						<label for="InputPassword2">비밀번호 확인</label> 
						<input type="password" class="form-control" id="inputPassword2" name="inputPassword2" placeholder="비밀번호 확인">
						<p class="help-block">비밀번호 확인을 위해 다시한번 입력 해 주세요</p>
					</div>
					<div class="form-group">
						<label for="username">이름</label> 
						<input type="text" class="form-control" id="inputName" name="inputName" placeholder="이름을 입력해 주세요">
					</div>
					<div class="form-group text-center">
						<button id="signUp" type="submit" class="btn btn-info">
							회원가입<i class="fa fa-check spaceLeft"></i>
						</button>
						<button id="cancel" type="submit" class="btn btn-warning">
							가입취소<i class="fa fa-times spaceLeft"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
		<div class="col-md-2"></div>
	</div>	
		
		
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		var regexId = /^[0-9a-z]{6,20}$/;
		var regexEmail = /[0-9a-zA-Z][_0-9a-zA-Z-]*@[_0-9a-zA-Z-]+(\.[_0-9a-zA-Z-]+){1,2}$/;
		var regexPw = /^.*(?=.{8,20})(?=.*[!@#%^*-+=])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).*$/;
		var idFlag = false;
		var idCheckFlag = false;
		var emailFlag = false;
		var pwFlag1 = false;
		var pwFlag2 = false;
		
		$(document).ready(function() {
			$("#inputId").keyup(function(){
				var id = $("#inputId").val();
				idCheckFlag = false;
				if(regexId.test(id)) {
					idFlag=true;
					$("#inputId").css("border", "2px solid lightgreen");
				} else {
					idFlag=false;
					$("#inputId").css("border", "2px solid red");
				}
			});
			
			$("#inputEmail").keyup(function(){
				var email = $("#inputEmail").val();
				emailCheckFlag = false;
				if(regexEmail.test(email)) {
					emailFlag=true;
					$("#inputEmail").css("border", "2px solid lightgreen");
				} else {
					$("#inputEmail").css("border", "2px solid red");
					emailFlag=false;
				}
			});

			$("#idCheck").on("click", function(e){
				e.preventDefault();
				var id = $("#inputId").val();
				fn_idCheck(id);
			});

			$("#inputPassword1").keyup(function(){
				var password1 = $("#inputPassword1").val();
				if(regexPw.test(password1)) {
					$("#inputPassword1").css("border", "2px solid lightgreen");
					pwFlag1 = true;
				} else {
					$("#inputPassword1").css("border", "2px solid red");
					pwFlag1 = false;
				}
			});

			$("#inputPassword2").keyup(function(){
				var password1 = $("#inputPassword1").val();
				var password2 = $("#inputPassword2").val();
				
				if(password1 == password2) {
					$("#inputPassword2").css("border", "2px solid lightgreen");
					pwFlag2 = true;
				} else {
					$("#inputPassword2").css("border", "2px solid red");
					pwFlag2 = false;
				}
			});
			
			$("#signUp").on("click", function(e) { //회원가입 버튼
				e.preventDefault();
				if(idFlag && idCheckFlag && emailFlag && pwFlag1 && pwFlag2){
					var insertData = $('#signUpForm').serialize();
					fn_signUp(insertData);					
				} else if(idFlag == false) {
					alert("아이디를 형식에 맞게 입력해 주세요.");
				} else if(idCheckFlag == false) {
					alert("아이디 중복체크를 해라.");
				} else if(emailFlag == false) {
					alert("이메일 주소를 형식에 맞게 입력해 주세요.");
				} else if(pwFlag1 == false) {
					alert("비밀번호를 형식에 맞게 입력해 주세요.");
				} else if(pwFlag2 == false) {
					alert("비밀번호가 일치하지 않습니다.");
				} else {
					alert("형식에 맞게 입력해 주세요.");
				}
			});

			$("#cancel").on("click", function(e) { //취소버튼
				e.preventDefault();
				history.back();
			});
			
		});

		function fn_signUp(insertData) {
			$.ajax({
				url:'/first/member/signUp.do',
				type:'post',
				data:insertData,
				success:function(data){
					if(data.isSuccess) {
						alert(data.msg);
						window.location.href = "/first/member/openLogIn.do";
					}else{
						alert(data.msg);
						return false;
					}
				}

			});
		}

		function fn_openBoardDetail(obj) {
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />");
			comSubmit.addParam("idx", obj.parent().find("#idx").val());
			comSubmit.submit();
		}
		
		function fn_idCheck(id) {
			$.ajax({
				url:'/first/member/idCheck.do',
				type:'post',
				data:{'inputId':id},
				success:function(data){
					if(data == 0){
						alert("사용 가능한 아이디 입니다.");
						idCheckFlag = true;
					} else {
						alert("이미 사용중인 아이디 입니다.");
						idCheckFlag = false;
					}
				}
			});
			if(idCheckFlag && idFlag){
				$("#inputId").css("border", "2px solid lightgreen");
			}else{
				$("#inputId").css("border", "2px solid red");
			}
		}
	</script>	
</body>
</html>