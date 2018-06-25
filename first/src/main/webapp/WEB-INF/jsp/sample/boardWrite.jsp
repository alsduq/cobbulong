<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<%@ include file="/WEB-INF/include/include-side.jspf" %>

		<div class="col-md-8">
			<hr/>
			<h2>게시글 작성</h2>
			<form id="frm" name="frm" enctype="multipart/form-data">
				<table class="table table-condensed">
					<colgroup>
						<col width="15%">
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">제목</th>
							<td><input type="text" id="title" name="title" class="wdp_90" required></input></td>
						</tr>
						<tr>
							<td colspan="2" class="view_text">
 								<textarea rows="20" cols="130" title="내용" id="contents" name="contents"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<input type="file" name="file" class="btn btn-default">
				<hr/>
				<span style='float:right'>
					<button href="#this" class="btn btn-default" id="write">작성</button>
					<button href="#this" class="btn btn-default" id="list">목록</button>
				</span>
			</form>
		</div>
		<div class="col-md-2"></div>
	</div>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		/* (function($) { */
		
			var oEditors = [];
			$(document).ready(function(){
				nhn.husky.EZCreator.createInIFrame({
				    oAppRef: oEditors,
				    elPlaceHolder: "contents",
				    sSkinURI: "<c:url value='/se2/SmartEditor2Skin.html'/>",
				    fCreator: "createSEditor2"
				});


				$("#list").on("click", function(e){ //목록으로 버튼
					e.preventDefault();
					fn_openBoardList();
				});
				
				$("#write").on("click", function(e){ //작성하기 버튼
					e.preventDefault();
					if($('#title').val() == null || $('#title').val() == ""){
						alert("제목을 입력해 주세요.");
						return;
					}
					fn_insertBoard();
				});
			});
			
			function fn_openBoardList(){
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
				comSubmit.submit();
			}
			
			function fn_insertBoard(){
				var myId = sessionStorage.getItem('myId');
				var comSubmit = new ComSubmit("frm");
			    oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				comSubmit.setUrl("<c:url value='/sample/insertBoard.do' />");
				comSubmit.addParam("crea_id", myId);
				comSubmit.submit();
			}
		/* })(jQuery); */
	</script>
	<script type="text/javascript" src="<c:url value='/se2/js/service/HuskyEZCreator.js'/>" charset="utf-8"></script>
</body>
</html>