<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>코뿌롱</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  

<link rel="stylesheet" type="text/css" href="<c:url value='/css/ui.css'/>" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- jQuery -->
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>
</head>
		<div class="col-md-8">
			<h3>쪽지 작성</h3>
			<form id="sendMessageForm" name="sendMessageForm">
				<table class="table table-condensed">
					<colgroup>
						<col width="15%">
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">받는사람</th>
							<td>
								<input type="text" id="receiver" name="receiver" value="${to}"></input>
								<input type="hidden" id="sender" name="sender" value=""/>
							</td>
						</tr>
						<tr>
							<th scope="row">제목</th>
							<td><input type="text" id="title" name="title" style="width: 98%;" required></input></td>
						</tr>
						<tr>
							<td colspan="2" class="view_text">
 								<textarea rows="15" cols="80" title="내용" id="contents" name="contents"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<hr/>
				<span style='float:right'>
					<button href="#this" class="btn btn-default" id="messageSend">보내기</button>
					<button href="#this" class="btn btn-default" id="exit">닫기</button>
				</span>
			</form>
		</div>
		<div class="col-md-2"></div>
	</div>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
			var oEditors = [];
			var idCheckFlag = true;
			$(document).ready(function(){
				nhn.husky.EZCreator.createInIFrame({
				    oAppRef: oEditors,
				    elPlaceHolder: "contents",
				    sSkinURI: "<c:url value='/se2/SmartEditor2Skin2.html'/>",
				    fCreator: "createSEditor2"
				});

				$("#messageSend").on("click", function(e){ //작성하기 버튼
					e.preventDefault();
					if(idCheckFlag == false){
						alert("존재하지 않는 아이디 입니다.");
						return;
					}
					if($('#title').val() == null || $('#title').val() == ""){
						alert("제목을 입력해 주세요.");
						return;
					}
					$('#sender').val("<%=session.getAttribute("myId")%>");
					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
					var insertData = $('#sendMessageForm').serialize();
					console.log(insertData);
					fn_sendMessage(insertData);
				});

				$("#exit").on("click", function(e){
					e.preventDefault();
					window.close();
				});

				$('#receiver').blur(function(){
					var insertData = $('#receiver').val();
					console.log("asd" + insertData);
					$.ajax({
						url:'/first/member/idCheck.do',
						type:'post',
						data:{'inputId':insertData},
						success:function(data){
							if(data == 0){
								alert("존재하지 않는 아이디 입니다.");
								idCheckFlag = false;
							} else {
								idCheckFlag = true;
							}
						}
					});
				});
			});
			
			function fn_sendMessage(insertData){
				$.ajax({
					url:'/first/message/sendMessage.do',
					type:'post',
					data:insertData,
					success:function(data){
						console.log(data);
						if(data.isSuccess) {
							alert(data.msg);
							window.close();
						}else{
							alert(data.msg);
							window.close();
						}
					}

				});
			}
	</script>
	<script type="text/javascript" src="<c:url value='/se2/js/service/HuskyEZCreator.js'/>" charset="utf-8"></script>
</body>
</html>