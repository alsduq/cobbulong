<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>코뿌롱</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="col-md-6 col-md-offset-3" style="margin:20px;">
		<form id="authNoCheckForm" name="authNoCheckForm">
			<div class="form-group">
				<h4 class="text-center">이메일로 인증번호가 전송되었습니다.<br>전송된 인증번호를 입력해 주세요.</h4>
				<div class="input-group">
					<input type="text" class="form-control" id="inputAuthNo" name="inputAuthNo" placeholder="인증번호" value="">
					<input type="hidden" class="form-control" id="inputEmail" name="inputEmail" value="">
					<input type="hidden" class="form-control" id="inputId" name="inputId" value="">
					<span class="input-group-btn"><button class="btn btn-default" type="button" id="checkAuthNo">확인</button></span>
				</div>
				<p class="help-block">인증번호가 일치하면 이메일로 임시 비밀번호가 전송 됩니다. 로그인 후 비밀번호를 변경 해 주세요.</p>
			</div>
		</form>
	</div>
</body>
</html>

<script type="text/javascript">
	$(document).ready(function() {
		$("#checkAuthNo").on("click", function(e) { //아이디 찾기 버튼
			e.preventDefault();
			if($('#inputAuthNo').val() == null || $('#inputAuthNo').val() == "undefine" || $('#inputAuthNo').val() == "null" || $('#inputAuthNo').val() == ""){
				alert("인증번호를 입력 해 주세요.");
				return false;
			}
			$('#inputEmail').val(opener.document.getElementById("inputEmail2").value);
			$('#inputId').val(opener.document.getElementById("inputId").value);
			var insertData = $('#authNoCheckForm').serialize();
			fn_authNoCheck(insertData);					
		});
	});
	
	function fn_authNoCheck(insertData) {
		$.ajax({
			url:'/first/member/authNoCheck.do',
			type:'post',
			data:insertData,
			success:function(data){
				if(data.isSuccess){
					alert(data.msg);
					self.close();
				}else{
					alert(data.msg);
				}
			}
	
		});
	}
</script>