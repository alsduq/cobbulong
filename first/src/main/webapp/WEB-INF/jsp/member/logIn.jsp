<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<%@ include file="/WEB-INF/include/include-side.jspf" %>
		<div class="col-md-8 content">
			<hr />
			<div class="col-md-6 col-md-offset-3">
				<h2>로그인</h2>
				<form id="logInForm" name="logInForm">
					<div class="form-group">
						<label for="InputEmail">아이디</label>
						<input type="text" class="form-control" id="inputId" name="inputId" placeholder="아이디">
					</div>
					<div class="form-group">
						<label for="InputPassword1">비밀번호</label> 
						<input type="password" class="form-control" id="inputPassword" name="inputPassword" placeholder="비밀번호">
					</div>
					<div class="form-group text-center">
						<label class="checkbox-inline">
						  <input type="checkbox" id="saveIdCheck" value="saveIdCheck"> 아이디 저장
						</label>
						<button id="logIn" type="submit" class="btn btn-success">
							로그인<i class="fa fa-check spaceLeft"></i>
						</button>
					</div>	
					<div class="form-group text-center">	
						<button id="signUp" type="submit" class="btn btn-info">
							회원가입<i class="fa fa-times spaceLeft"></i>
						</button>
						<button id="findIdPw" type="submit" class="btn btn-primary">
							아아디/비밀번호 찾기<i class="fa fa-times spaceLeft"></i>
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
			var saveId = getCookie("saveId"); 
			if(saveId != null){
				$('#inputId').val(saveId);
				$('#saveIdCheck').attr("checked",true);
			}

			$('#signUp').on('click', function(e){
				e.preventDefault();
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("<c:url value='/member/openSignUp.do' />");
				comSubmit.submit();
			});

			$('#logIn').on('click', function(e){
				e.preventDefault();
				var insertData = $('#logInForm').serialize();
				fn_logIn(insertData);
			});

			$('#findIdPw').on('click', function(e){
				e.preventDefault();
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("<c:url value='/member/openFindIdPw.do' />");
				comSubmit.submit();
			});

			function fn_logIn(insertData){
				$.ajax({
					url:'/first/member/logIn.do',
					type:'post',
					data:insertData,
					success:function(data){
						if(data){
							sessionStorage.setItem('myId', $('#inputId').val());
							if($('#saveIdCheck').prop("checked")){
								setCookie("saveId", $('#inputId').val(), 30);
							}else{
								setCookie("saveId", "", 0);
							}
							window.location.href = "/first/sample/openBoardList.do";
						} else {
							alert("아이디 또는 비밀번호가 틀렸습니다.");
						}
					}
				});
			}
		});
	</script>	
</body>
</html>