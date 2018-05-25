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
			<form id="frm">
				<table class="table table-condensed">
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<caption>게시글 상세</caption>
					<tbody>
						<tr>
							<th scope="row">글 번호</th>
							<td>
								${map.idx }
								<input type="hidden" id="idx" name="idx" value="${map.idx }">
							</td>
							<th scope="row">조회수</th>
							<td>${map.hit_cnt }</td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td>${map.crea_id }</td>
							<th scope="row">작성시간</th>
							<td>${map.crea_dtm }</td>
						</tr>
						<tr>
							<th scope="row">제목</th>
							<td colspan="3">
								<input type="text" id="title" name="title" class="wdp_90" value="${map.title}"/>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="view_text">
								<textarea rows="20" cols="130" title="내용" id="contents" name="contents">${map.contents}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<span style='float:right'>
				<button href="#this" class="btn btn-default" id="list">목록</button>
				<button href="#this" class="btn btn-default" id="update">저장</button>
				<button href="#this" class="btn btn-default" id="delete">삭제</button>
			</span>
		</div>
	
	
	</div>
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		var board_idx = "${map.idx}";
		$(document).ready(function(){
			$("#list").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openBoardList();
			});
			
			$("#update").on("click", function(e){ //저장하기 버튼
				e.preventDefault();
				fn_updateBoard();
			});
			
			$("#delete").on("click", function(e){ //삭제하기 버튼
				e.preventDefault();
				fn_deleteBoard();
			});
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
			comSubmit.submit();
		}
		
		function fn_updateBoard(){
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/sample/updateBoard.do' />");
			comSubmit.submit();
		}
		
		function fn_deleteBoard(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/deleteBoard.do' />");
			comSubmit.addParam("idx", board_idx);
			comSubmit.submit();
		}
	</script>
</body>
</html>