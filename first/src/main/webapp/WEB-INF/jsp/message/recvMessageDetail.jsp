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
				<caption>쪽지 읽기</caption>
				<tbody>
					<tr>
						<th scope="row">보낸 사람</th>
						<td>${message.sender}</td>
						<th scope="row">받은 시간</th>
						<td id="crea_dtm">${message.crea_dtm}</td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3">${message.title}</td>
					</tr>
					<tr>
						<td colspan="4"><div style="min-height:300px; padding:10px;">${message.contents}</div></td>
					</tr>
				</tbody>
			</table>
			<hr/>
			<div>
				<table class="table table-condensed">
                       <thead>
                           <tr>
                               <td>
                                   <span style='float:right'>
                                       <button type="button" id="reply" class="btn btn-default">답장</button>
                                       <button type="button" id="delete" class="btn btn-default">삭제</button>
                                       <button type="button" id="list" class="btn btn-default">목록</button>
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
		var myId = "<%=session.getAttribute("myId")%>";
		$(document).ready(function(){
			$("#reply").on("click", function(e){ //답장쓰기
				e.preventDefault();
				fn_sendMessage("${message.sender}");
			});
			
			$('#delete').on("click", function(e){
				var messageIdx = "${message.idx}"; 
				fn_deleteMessage(messageIdx);
			});
			
	     	$('#crea_dtm').text(fn_dateConverter.dateTime("${message.crea_dtm}"));


		});

     	function fn_deleteMessage(obj){
			if(confirm("레알 삭제?")){
				$.ajax({
					url:'/first/message/deleteMessage.do',
					traditional: true,
					type:'post',
					data:{'messageIdx':obj,
							'type':'R'},
					success:function(){
						fn_openRecvMessagePage("${pageIdx}");
					}
				});
			} else {
				return;
			}
		}

	</script>
</body>
</html>