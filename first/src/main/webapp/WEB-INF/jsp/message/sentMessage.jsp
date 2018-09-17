<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<%@ include file="/WEB-INF/include/include-side.jspf" %>
	
		<div class="col-md-8 content">
			<hr/>
			<h3>보낸 쪽지함</h3>
			<table class="board_list">
				<colgroup>
					<col width="4%"/>
					<col width="10%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" name="allCheck"/></th>
						<th scope="col">받는사람</th>
						<th scope="col">제목</th>
						<th scope="col">보낸날짜</th>
						<th scope="col">받은날짜</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(messageList) > 0}">
							<c:forEach items="${messageList}" var="row">
								<tr>
									<td><input type="checkbox" name="delCheck" value="${row.idx}"/></td>
									<td>${row.receiver}</td>
									<td class="title col-md-5">
										<a href="#this">${row.title}</a>
									</td>
									<td id="crea_dtm">${row.crea_dtm}</td>
									<td id="read_dtm">${row.read_dtm}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="4"></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<br/>
			<span style='float:right'>
				<button href="#this" class="btn btn-default" id="delete">삭제</button>
			</span>
			<div class="text-center">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="#this">처음</a></li>
					<li><a href="#this" aria-label="Previous">&laquo;</a></li>
					<c:choose>
						<c:when test="${pageIdx <= 4}">
							<c:forEach var="i" begin="1" end="${(count/10)+1}">
								<c:choose>
									<c:when test="${pageIdx == i}">
										<li><a href="#this" style="color:red;">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="#this">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:when test="${pageIdx >= (count/10) + (1-(count%10/10))-4}">
							<c:forEach var="i" begin="${count/10+1-8}" end="${count/10+1}">
								<c:choose>
									<c:when test="${pageIdx == i}">
										<li><a href="#this" style="color:red;">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="#this">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="${pageIdx-4}" end="${pageIdx+4}">
								<c:choose>
									<c:when test="${pageIdx == i}">
										<li><a href="#this" style="color:red;">${i}</a></li>
									</c:when>
									<c:otherwise>
										<li><a href="#this">${i}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<li><a href="#this" aria-label="Next">&raquo;</a></li>
					<li><a href="#this">끝</a></li>
				</ul>
			</nav>
			</div>
		</div>
		<div class="col-md-2"></div>
	</div>	
		
		
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
		var myId = "<%=session.getAttribute("myId")%>";
		$(document).ready(function(){
			$("#write").on("click", function(e){ //글쓰기 버튼
				e.preventDefault();
				if(sessionStorage.getItem("myId") == null || sessionStorage.getItem("myId") == ""){
					alert("글쓰기는 로그인 후 이용 가능합니다.");
					window.location.href = "/first/member/openLogIn.do";
				} else {
					fn_openBoardWrite();
				}
			});	
			
			$(".title").children("a").on("click", function(e){ //제목 
				e.preventDefault();
				fn_openMessageDetail($(this));
			});

			$(".pagination").children().children("a").on("click", function(e){
				e.preventDefault();
				fn_openSentMessage($(this));
			});

			$('.board_list thead tr th').addClass("text-center");

			$('.board_list tbody tr').each(function(index){
				var crea_dtm = $(this).children('#crea_dtm').text();
				var read_dtm = $(this).children('#read_dtm').text();
				if(read_dtm != "읽지않음"){
					$(this).children('#read_dtm').text(fn_dateConverter.autoDate(read_dtm));
				}
				$(this).children('#crea_dtm').text(fn_dateConverter.autoDate(crea_dtm));
			});

			$('#delete').on("click", function(e){
				var messageIdx = new Array(); 
				$('input[name=delCheck]:checked').each(function(idx){
					messageIdx[idx] = $(this).val();
				});
				fn_deleteMessage(messageIdx);
			});

			$('input[name=allCheck]').on('click',function(){
				if($(this).is(":checked")){
					$('input[name=delCheck]').prop('checked', true);
				}else{
					$('input[name=delCheck]').prop('checked', false);
				}
			});
			
			
		});
		
		function fn_openMessageDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/message/openMessageDetail.do'/>");
			comSubmit.addParam("idx", obj.parent().parent().children().first().children().val());
			comSubmit.addParam("type", "S");
			comSubmit.addParam("page_idx","${pageIdx}");
			comSubmit.submit();
		}

		function fn_openSentMessage(obj){
			var comSubmit = new ComSubmit();
			var pageIdx = obj.html();
			var totalPage = Math.ceil(${count}/10);
			var previousPage = parseInt($(".pagination").children().children("a").eq(2).text())-1;
			var nextPage = parseInt($(".pagination").children().children("a").eq($(this).size()-4).text())+1;
			if(nextPage >= totalPage){
				nextPage = totalPage;
			}
			if(previousPage <= 0){
				previousPage = 1;
			}
			comSubmit.setUrl("<c:url value='/message/openSentMessage.do' />");
			comSubmit.addParam("myId", myId);
			if(pageIdx == "처음") {
				comSubmit.addParam("page_idx", "1");
			} else if (pageIdx == "끝") {
				comSubmit.addParam("page_idx", totalPage);
			} else if (pageIdx == "«") {
				comSubmit.addParam("page_idx", previousPage);
			} else if (pageIdx == "»") {
				comSubmit.addParam("page_idx", nextPage);
			} else {
				comSubmit.addParam("page_idx", pageIdx);
			}
			comSubmit.submit();
		}

		function fn_deleteMessage(obj){
			if(confirm("레알 삭제?")){
				$.ajax({
					url:'/first/message/deleteMessage.do',
					traditional: true,
					type:'post',
					data:{'messageIdx':obj,
							'type':'S'},
					success:function(){
						window.location.reload();
					}
				});
			} else {
				return;
			}
		}
	</script>	
</body>
</html>