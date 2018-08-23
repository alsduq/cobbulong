<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<%@ include file="/WEB-INF/include/include-side.jspf" %>
		<div class="col-md-8 content">
			<hr />
			<div class="col-md-6 col-md-offset-3">
				<h2>비밀번호 변경</h2>
				<form id="changePasswordForm" name="changePasswordForm">
					<div class="form-group">
						<label for="inputId">아이디</label>
						<input type="text" class="form-control" id="inputId" name="inputId" placeholder="아이디">
					</div>
					<div class="form-group">
						<label for="inputBeforePassword">기존 비밀번호</label> 
						<input type="password" class="form-control" id="inputBeforePassword" name="inputBeforePassword" placeholder="기존 비밀번호">
					</div>
					<div class="form-group">
						<label for="inputPassword">새 비밀번호</label> 
						<input type="password" class="form-control" id="inputPassword" name="inputPassword" placeholder="새 비밀번호">
					</div>
					<div class="form-group">
						<label for="inputPassword2">새 비밀번호 확인</label> 
						<input type="password" class="form-control" id="inputPassword2" name="inputPassword2" placeholder="새 비밀번호 확인">
					</div>
					<div class="form-group text-center">
						<button id="changePassword" type="submit" class="btn btn-success">
							확인<i class="fa fa-check spaceLeft"></i>
						</button>
						<button id="cancel" class="btn btn-info" onclick="javascript:history.back();return false;">
							취소<i class="fa fa-times spaceLeft"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
		<div class="col-md-2"></div>
	</div>	
		
		
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
			var regexPw = /^.*(?=.{8,20})(?=.*[!@#%^*-+=])(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).*$/;
			var pwFlag1 = false;
			var pwFlag2 = false;
			
			$('#changePassword').on('click', function(e){
				e.preventDefault();
				
				if($('#inputId').val() == null || $('#inputId').val() == "undefine" || $('#inputId').val() == "null" || $('#inputId').val() == ""){
					alert("아이디를 입력 해 주세요.");
					return false;
				}
				if($('#inputBeforePassword').val() == null || $('#inputBeforePassword').val() == "undefine" || $('#inputBeforePassword').val() == "null" || $('#inputBeforePassword').val() == ""){
					alert("기존 비밀번호를 입력 해 주세요.");
					return false;
				}
				if($('#inputPassword').val() == null || $('#inputPassword').val() == "undefine" || $('#inputPassword').val() == "null" || $('#inputPassword').val() == ""){
					alert("새 비밀번호를 입력 해 주세요.");
					return false;
				}
				if($('#inputPassword2').val() == null || $('#inputPassword2').val() == "undefine" || $('#inputPassword2').val() == "null" || $('#inputPassword2').val() == ""){
					alert("새 비밀번호를 한번 더 입력 해 주세요.");
					return false;
				}
				
				
				var insertData = $('#changePasswordForm').serialize();
				fn_changePassword(insertData);
			});


			function fn_changePassword(insertData){
				$.ajax({
					url:'/first/member/changePassword.do',
					type:'post',
					data:insertData,
					success:function(data){
						if(data.isSuccess){
							alert(data.msg);
							sessionStorage.removeItem('myId');
							window.location.href = "/first/member/openLogIn.do";
						} else {
							alert(data.msg);
							return false;
						}
					}
				});
			}


			$("#inputPassword").keyup(function(){
				var password1 = $("#inputPassword").val();
				if(regexPw.test(password1)) {
					$("#inputPassword").css("border", "2px solid lightgreen");
					pwFlag1 = true;
				} else {
					$("#inputPassword").css("border", "2px solid red");
					pwFlag1 = false;
				}
			});
			
			
			$("#inputPassword2").keyup(function(){
				var password1 = $("#inputPassword").val();
				var password2 = $("#inputPassword2").val();
				
				if(password1 == password2) {
					$("#inputPassword2").css("border", "2px solid lightgreen");
					pwFlag2 = true;
				} else {
					$("#inputPassword2").css("border", "2px solid red");
					pwFlag2 = false;
				}
			});

		});
	</script>	
</body>
</html>