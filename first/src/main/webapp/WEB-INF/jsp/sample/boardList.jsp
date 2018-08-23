<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<%@ include file="/WEB-INF/include/include-side.jspf" %>
	
		<div class="col-md-8 content">
			<hr/>
			<h2>게시판 목록</h2>
			<table class="board_list">
				<colgroup>
					<col width="10%"/>
					<col width="*"/>
					<col width="15%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col">글번호</th>
						<th scope="col">제목</th>
						<th scope="col">작성자</th>
						<th scope="col">조회수</th>
						<th scope="col">작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${fn:length(list) > 0}">
							<c:forEach items="${list }" var="row">
								<tr>
									<td>${row.idx}</td>
									<td class="title col-md-5">
										<a href="#this" id="title">${row.title}</a>
										<input type="hidden" id="idx" value="${row.idx}">
									</td>
									<td>${row.crea_id}</td>
									<td>${row.hit_cnt}</td>
									<td>${row.crea_dtm}</td>
								</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tr>
								<td colspan="5"></td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<br/>
			<span style='float:right'>
				<button href="#this" class="btn btn-default" id="write">글쓰기</button>
			</span>
			<div class="text-center">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="#this">처음</a></li>
					<li><a href="#this" aria-label="Previous">&laquo;</a></li>
					<c:choose>
						<c:when test="${pageIdx <= 4}">
							<c:forEach var="i" begin="1" end="${pageIdx}">
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
				fn_openBoardDetail($(this));
			});

			$(".pagination").children().children("a").on("click", function(e){
				e.preventDefault();
				fn_openBoardList($(this));
			});

			$('.board_list thead tr th').addClass("text-center");

			$('.board_list tbody tr').each(function(index){
				var crea_dtm = $(this).children().last().text();
				$(this).children().last().text(fn_dateConverter.autoDate(crea_dtm));
			});

			
		});
		
		function fn_openBoardDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardDetail.do' />");
			comSubmit.addParam("idx", obj.parent().find("#idx").val());
			comSubmit.submit();
		}

		function fn_openBoardList(obj){
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
			console.log("nextPage : " + nextPage);
			comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
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
	</script>	
</body>
</html>