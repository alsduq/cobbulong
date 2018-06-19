<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<%@ include file="/WEB-INF/include/include-side.jspf" %>
		<div class="col-md-8">
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
						<td id="crea_dtm">${map.crea_dtm}</td>
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
			<hr/>
			<div class="commentList"></div>
			<div>
				<form name="commentInsertForm">
					<input type="hidden" name="board_idx" value="${map.idx}">
                    <table class="table table-condensed">
                        <tr>
                            <td>
                            	<div class="empty_row"></div>
								<div class="form-group">
								    <input type="hidden" name="crea_id" class="form-control col-lg-2" data-rule-required="true" placeholder="이름" maxlength="10">
								</div>
								<div class="empty_row"></div>
								<div class="form-group">
									<div class="input-group">
										<textarea id="contents" name="contents" class="form-control" rows="1"></textarea>
										<span class="input-group-btn"><button type="button" name="commentInsertBtn" class="btn btn-default">확인</button></span>
									</div>
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
		<div class="col-md-2"></div>
	</div>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		var board_idx = "${map.idx}";
		var myId = sessionStorage.getItem("myId");
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
	     	$('#crea_dtm').text(fn_dateConverter.dateTime("${map.crea_dtm}"));

	     	$('[name=commentInsertBtn]').click(function(){
		     	$('[name=crea_id]').val(myId);
				var insertData = $('[name=commentInsertForm]').serialize();
				commentInsert(insertData);
	       	});

	     	$('[name=commentUpdateBtn]').on('click', function(){
	     		fn_commentUpdate();
		     });
		     
			if(myId != "${map.crea_id}"){
				$('#delete').remove();
				$('#update').remove();
			} 
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

		function fn_deleteBoard(){
			if(confirm("레알 삭제?")){
				if(myId != "${map.crea_id}"){
			       	alert("삭제불가");
			       	return;
				}
				var comSubmit = new ComSubmit();
				comSubmit.setUrl("<c:url value='/sample/deleteBoard.do' />");
				comSubmit.addParam("idx", board_idx);
				comSubmit.submit();
			} else {
				return;
			}
		}

       	function commentList(){
           	$.ajax({
				url: '/first/sample/commentList.do',
				type: 'get',
				data: {'board_idx':board_idx},
				success:function(data){
					var a = '';
					if(Object.keys(data).length == 0){
						a += '<div><p>등록된 댓글이 없습니다.</p></div>';
					} else {
						$.each(data, function(key, value){ 
							var date = new Date(value.crea_dtm);
			                a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
			                a += '<div class="commentInfo'+value.idx+'">'+'작성자 : '+value.crea_id + ' | 등록일 : ' + date.format('yyyy.MM.dd HH:mm:ss');
			                if(value.crea_id == myId){
				                a += ' [<a onclick="commentUpdate('+value.idx+',\''+value.contents+'\');"> 수정 </a> | ';
				                a += '<a onclick="commentDelete('+value.idx+');"> 삭제 </a>] </div>';
			                }
			                a += '<div class="commentContent'+value.idx+'"> <p> 내용 : '+value.contents +'</p>';
			                a += '</div></div>';
			            });
					}
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
			if(confirm("레알 삭제?")){
				$.ajax({
					url:'/first/sample/commentDelete.do',
					type:'post',
					data:{'idx':idx},
					success:function(){
						commentList();
					}
				});
			} else {
				return;
			}
		}

		function commentUpdate(idx, contents){
			var a = "<form name='commentUpdateForm"+idx+"'>";
			a += "<div class='form-group'>"	;
			a += "<div class='input-group'>";
			a += "<input type='hidden' name='idx' value='"+idx+"'>";
			a += "<textarea id='contents' name='contents' class='form-control'rows='1'>"+contents+"</textarea>";
			a += "<span class='input-group-btn'>";
			a += "<button onclick='fn_commentUpdate("+idx+")' type='button' name='commentUpdateBtn' class='btn btn-default'>수정";
			a += "</button></span></div></div></form>";
			$('.commentContent'+idx).html(a);
		}

		function fn_commentUpdate(idx){
			var insertData = $('[name=commentUpdateForm'+idx+']').serialize();
			$.ajax({
				url:'/first/sample/commentUpdate.do',
				type:'post',
				data:insertData,
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