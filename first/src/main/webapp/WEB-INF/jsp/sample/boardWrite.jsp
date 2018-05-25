<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
	<div class="container">
		<div class="col-md-10">
			<hr/>
			<form id="frm" name="frm" enctype="multipart/form-data">
				<h2>게시글 작성</h2>
				<table class="table table-condensed">
					<colgroup>
						<col width="15%">
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">제목</th>
							<td><input type="text" id="title" name="title" class="wdp_90"></input></td>
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
	</div>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#list").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openBoardList();
			});
			
			$("#write").on("click", function(e){ //작성하기 버튼
				e.preventDefault();
				fn_insertBoard();
			});
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
			comSubmit.submit();
		}
		
		function fn_insertBoard(){
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/sample/insertBoard.do' />");
			comSubmit.submit();
		}
	</script>
</body>
</html>