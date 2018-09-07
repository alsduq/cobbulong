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
		var board_idx = "${map.idx}";
		var myId = sessionStorage.getItem("myId");
		$(document).ready(function(){
			
			$("#reply").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_message("${message.sender}");
			});
			$("#update").on("click", function(e){ //수정하기 버튼
				e.preventDefault();
				fn_openBoardUpdate();
			});
	     	$('#crea_dtm').text(fn_dateConverter.dateTime("${message.crea_dtm}"));


		});

		function fn_message(obj){
			var w = 650;
			var h = 580;
			var xPos = (document.body.clientWidth / 2) - (w / 2); 
		    	xPos += window.screenLeft;  //듀얼 모니터일때....
		   	var yPos = (screen.availHeight / 2) - (h / 2);
			window.open('/first/message/openMessageWrite.do?to='+obj,'popwindow',"width="+w+",height="+h+", left="+xPos+", top="+yPos+", toolbars=no, resizable=no, scrollbars=no");
		}

        
	</script>
</body>
</html>