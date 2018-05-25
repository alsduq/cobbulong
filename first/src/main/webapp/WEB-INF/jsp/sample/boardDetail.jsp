<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-10">
				<hr/>
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
							<td>${map.idx}</td>
							<th scope="row">조회수</th>
							<td>${map.hit_cnt}</td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td>${map.crea_id }</td>
							<th scope="row">작성시간</th>
							<td>${map.crea_dtm }</td>
						</tr>
						<tr>
							<th scope="row">제목</th>
							<td colspan="3">${map.title }</td>
						</tr>
						<tr>
							<td colspan="4"><div style="min-height:300px; padding:10px;">${map.contents}</div></td>
						</tr>
						<tr>
			                <th scope="row">첨부파일</th>
			                <td colspan="3">
			                    <c:forEach var="row" items="${list}">
			                        <input type="hidden" id="idx" value="${row.idx}">
			                        <a href="#this" name="file">${row.original_file_name}</a>
			                        (${row.file_size}kb)
			                    </c:forEach>
			                </td>
			            </tr>
					</tbody>
				</table>
				<div class="commentList"></div>
				<div>
					<form name="commentInsertForm">
						<input type="hidden" name="board_idx" value="${map.idx}">
	                    <table class="table table-condensed">
	                        <tr>
	                            <td>
	                            	<div class="empty_row"></div>
	                                <div class="form-inline" role="form">
										<div class="form-group">
										    <input type="text" name="crea_id" class="form-control col-lg-2" data-rule-required="true" placeholder="이름" maxlength="10">
										</div>
										<div class="form-group">
										    <input type="password" name="password" class="form-control col-lg-2" data-rule-required="true" placeholder="패스워드" maxlength="10">
										</div>
										<div class="form-group">
										    <button type="button" name="commentInsertBtn" class="btn btn-default">확인</button>
										</div><div class="empty_row"></div>
										<textarea id="contents" name="contents" class="form-control col-lg-12" style="width:100%" rows="4"></textarea>
	                                </div>
	                            </td>
	                        </tr>
	                    </table>
					</form>
				</div>
				<div>
					<table class="table table-condensed">
                        <thead>
                            <tr>
                                <td>
                                    <span style='float:right'>
                                        <button type="button" id="list" class="btn btn-default">목록</button>
                                        <button type="button" id="update" class="btn btn-default">수정</button>
                                        <button type="button" id="delete" class="btn btn-default">삭제</button>
                                        <button type="button" id="write" class="btn btn-default">글쓰기</button>
                                    </span>
                                </td>
                            </tr>
                        </thead>
                    </table>
				</div>
			</div>
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
			$("#update").on("click", function(e){ //수정하기 버튼
				e.preventDefault();
				fn_openBoardUpdate();
			});
			$("[name='file']").on("click", function(e){ //파일 다운로드
	        	e.preventDefault();
	        	fn_downloadFile($(this));
	     	});
			$("#write").on("click", function(e){ //파일 다운로드
	        	e.preventDefault();
	        	fn_openBoardWrite($(this));
	     	});
			$("#delete").on("click", function(e){ //파일 다운로드
	        	e.preventDefault();
	        	fn_deleteBoard($(this));
	     	});
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
			comSubmit.submit();
		}
		
		function fn_openBoardUpdate(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardUpdate.do' />");
			comSubmit.addParam("idx", board_idx);
			comSubmit.submit();
		}

		function fn_downloadFile(obj){
	        var comSubmit = new ComSubmit();
	        comSubmit.setUrl("<c:url value='/common/downloadFile.do' />");
	        comSubmit.addParam("idx", board_idx);
	        comSubmit.submit();
	    }

		function fn_openBoardWrite(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardWrite.do' />");
			comSubmit.submit();
		}

		function fn_deleteBoard(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/deleteBoard.do' />");
			comSubmit.addParam("idx", board_idx);
			comSubmit.submit();
		}

        $('[name=commentInsertBtn]').click(function(){
			var insertData = $('[name=commentInsertForm]').serialize();
			commentInsert(insertData);
       	});

       	function commentList(){
           	$.ajax({
				url: '/first/sample/commentList.do',
				type: 'get',
				data: {'board_idx':board_idx},
				success:function(data){
					var a = '';
					console.log(data);
					$.each(data, function(key, value){ 
						var date = new Date(value.crea_dtm);
		                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
		                a += '<div class="commentInfo'+value.idx+'">'+'작성자 : '+value.crea_id + ' | 등록일 : ' + date.format('yyyy.MM.dd HH:mm:ss');
		                a += ' [<a onclick="commentUpdate('+value.idx+',\''+value.contents+'\');"> 수정 </a> | ';
		                a += '<a onclick="commentDelete('+value.idx+');"> 삭제 </a>] </div>';
		                a += '<div class="commentContent'+value.idx+'"> <p> 내용 : '+value.contents +'</p>';
		                a += '</div></div>';
		            });
		            $(".commentList").html(a);
				}
           	});
        }

		function commentInsert(insertData){
			$.ajax({
				url:'/first/sample/commentInsert.do',
				type:'post',
				data:insertData,
				success:function(){
					commentList();
					$('[name=contents]').val('');
				}
			});
		}

		function commentDelete(idx){
			$.ajax({
				url:'/first/sample/commentDelete.do',
				type:'post',
				data:{'idx':idx},
				success:function(){
					commentList();
				}
			});
		}

		$(document).ready(function(){
			commentList();
		});
        
	</script>
</body>
</html>