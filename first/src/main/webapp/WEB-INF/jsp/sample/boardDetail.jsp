<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-header.jspf" %>
</head>
<body>
	<div class="container">
		<hr/>
		<div class="row">
			<div class="col-md-10">
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
							<td>${map.idx }</td>
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
							<td colspan="4"><div style="min-height:300px; padding:10px;">${map.contents }</div></td>
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
				<div>
					<a href="#this" class="btn btn-default" id="list">목록으로</a>
					<a href="#this" class="btn btn-default" id="update">수정하기</a>
				</div>
				<div>
					<table id="commentTable" class="table table-condensed"></table>
                    <table class="table table-condensed">
                        <tr>
                            <td>
                            	<div class="empty_row"></div>
                                <div class="form-inline" role="form">
									<div class="form-group">
									    <input type="text" id="commentParentName" name="commentParentName" class="form-control col-lg-2" data-rule-required="true" placeholder="이름" maxlength="10">
									</div>
									<div class="form-group">
									    <input type="password" id="commentParentPassword" name="commentParentPassword" class="form-control col-lg-2" data-rule-required="true" placeholder="패스워드" maxlength="10">
									</div>
									<div class="form-group">
									    <button type="button" id="commentParentSubmit" name="commentParentSubmit" class="btn btn-default">확인</button>
									</div><div class="empty_row"></div>
									<textarea id="commentParentText" class="form-control col-lg-12" style="width:100%" rows="4"></textarea>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <table class="table table-condensed">
                        <thead>
                            <tr>
                                <td>
                                    <span style='float:right'>
                                        <button type="button" id="list" class="btn btn-default">목록</button>
                                        <button type="button" id="modify" class="btn btn-default">수정</button>
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
		$(document).ready(function(){
			$("#list").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openBoardList();
			});
			
			$("#update").on("click", function(e){ //수정하기 버튼
				e.preventDefault();
				fn_openBoardUpdate();
			});
			$("a[name='file']").on("click", function(e){ //파일 이름
	        	e.preventDefault();
	        	fn_downloadFile($(this));
	     	});
		});
		
		function fn_openBoardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardList.do' />");
			comSubmit.submit();
		}
		
		function fn_openBoardUpdate(){
			var idx = "${map.idx}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/sample/openBoardUpdate.do' />");
			comSubmit.addParam("idx", idx);
			comSubmit.submit();
		}

		function fn_downloadFile(obj){
	        var idx = obj.parent().find("#idx").val();
	        var comSubmit = new ComSubmit();
	        comSubmit.setUrl("<c:url value='/common/downloadFile.do' />");
	        comSubmit.addParam("idx", idx);
	        comSubmit.submit();
	    }


		$(function(){
            //제일 하단에 있는 depth1의 댓글을 다는 이벤트
            $("#commentParentSubmit").click(function( event ) {
                   
                //ajax로 저장하고 성공하면 저장한 데이터를 가져와 넣어야 하는데 여기서는 테스트라 그냥 입력값을 가져옴
                var pName = $("#commentParentName");
                var pPassword = $("#commentParentPassword");//패스워드를 노출 시켰는데 저장하고 나서 저장한 날짜를 보여줄 예정
                var pText = $("#commentParentText");
                   
                if($.trim(pName.val())==""){
                    alert("이름을 입력하세요.");
                    pName.focus();
                    return;
                }else if($.trim(pPassword.val())==""){
                    alert("패스워드를 입력하세요.");
                    pPassword.focus();
                    return;
                }else if($.trim(pText.val())==""){
                    alert("내용을 입력하세요.");
                    pText.focus();
                    return;
                }
                   
                var commentParentText = '<tr id="r1" name="commentParentCode">'+
                                            '<td colspan=2>'+
                                                '<strong>'+pName.val()+'</strong> '+pPassword.val()+' <a style="cursor:pointer;" name="pAdd">답글</a> | <a style="cursor:pointer;" name="pDel">삭제</a><p>'+pText.val().replace(/\n/g, "<br>")+'</p>'+
                                            '</td>'+
                                        '</tr>';
                   
                //테이블의 tr자식이 있으면 tr 뒤에 붙인다. 없으면 테이블 안에 tr을 붙인다.
                if($('#commentTable').contents().size()==0){
                    $('#commentTable').append(commentParentText);
                }else{
                    $('#commentTable tr:last').after(commentParentText);
                }
                   
                $("#commentParentName").val("");
                $("#commentParentPassword").val("");
                $("#commentParentText").val("");
                   
            });
               
            //댓글의 댓글을 다는 이벤트
            $(document).on("click","#commentChildSubmit", function(){
                   
                var cName = $("#commentChildName");
                var cPassword = $("#commentChildPassword");
                var cText = $("#commentChildText");
                   
                if($.trim(cName.val())==""){
                    alert("이름을 입력하세요.");
                    cName.focus();
                    return;
                }else if($.trim(cPassword.val())==""){
                    alert("패스워드를 입력하세요.");
                    cPassword.focus();
                    return;
                }else if($.trim(cText.val())==""){
                    alert("내용을 입력하세요.");
                    cText.focus();
                    return;
                }
                   
                var commentChildText = '<tr name="commentChildCode">'+
                                            '<td style="width:1%"><span class="glyphicon glyphicon-arrow-right"></span></td>'+
                                            '<td style="width:99%">'+
                                                '<strong>'+cName.val()+'</strong> '+cPassword.val()+' <a style="cursor:pointer;" name="cAdd">답글</a> | <a style="cursor:pointer;" name="cDel">삭제</a>'+
                                                '<p>'+cText.val().replace(/\n/g, "<br>")+'</p>'+
                                            '</td>'+
                                        '</tr>';
                                           
                //앞의 tr노드 찾기
                var prevTr = $(this).parent().parent().parent().parent().prev();
                //댓글 적는 에디터 삭제
                $("#commentEditor").remove();//여기에서 삭제를 해줘야 에디터tr을 안 찾는다.
                   
                //댓글을 타고 올라가며 부모 tr을 찾음
                while(prevTr.attr("name")!="commentParentCode"){
                    prevTr = prevTr.prev();
                }
                //while를 타는지 체크
                var check = false;
                //다음 노드가 댓글(depth1)의 댓글인지 찾기위해 next
                var nextTr = prevTr.next();
                //뒤에 댓글(depth1)의 댓글(depth2_1)이 없다면 바로 붙인다.
                if(nextTr.attr("name")!="commentChildCode"){
                    prevTr.after(commentChildText);
                }else{
                    //댓글(depth1)의 댓글(depth2_n)이 있는경우 마지막까지 찾는다.
                    while(nextTr.attr("name")=="commentChildCode"){
                        nextTr = nextTr.next();
                        check = true;
                    }
                }
                   
                if(check){//댓글(depth1)의 댓글(depth2_n)이 있다면 그 댓글(depth2_n) 뒤에 댓글(depth2_n+1) 추가
                    nextTr = nextTr.prev();//while문에서 검색하느라 next로 넘거갔던거 다시 앞으로 돌려줌
                    nextTr.after(commentChildText);
                }
                   
            });
               
            //답글링크를 눌렀을때 에디터 창을 뿌려주는 이벤트, 삭제링크를 눌렀을때 해당 댓글을 삭제하는 이벤트
            $(document).on("click","table#commentTable a", function(){//동적으로 버튼이 생긴 경우 처리 방식
                   
                if($(this).attr("name")=="pDel"){
                    if (confirm("답글을 삭제 하시면 밑에 답글도 모두 삭제 됩니다. 정말 삭제하시겠습니까?") == true){    //확인
                           
                        var delComment = $(this).parent().parent();
                        var nextTr = delComment.next();
                        var delTr;
                        //댓글(depth1)의 댓글(depth2_1)이 있는지 검사하여 삭제
                        while(nextTr.attr("name")=="commentCode"){
                            nextTr = nextTr.next();
                            delTr = nextTr.prev();//삭제하고 넘기면 삭제되서 없기 때문에 다음값을 가져오기 어려워 다시 앞으로 돌려서 찾은 다음 삭제
                            delTr.remove();
                        }
                           
                        delComment.remove();
                           
                    }else{   //취소
                        return;
                    }
                }else if($(this).attr("name")=="cDel"){
                    if (confirm("정말 삭제하시겠습니까??") == true){    //확인
                        $(this).parent().parent().remove();
                    }else{   //취소
                        return;
                    }
                }else{
                    //자기 부모의 tr을 알아낸다.
                    var parentElement = $(this).parent().parent();
                    //댓글달기 창을 없앤다.
                    $("#commentEditor").remove();
                    //부모의 하단에 댓글달기 창을 삽입
                    var commentEditor = '<tr id="commentEditor">'+
                                            '<td style="width:1%"> </td>'+
                                            '<td>'+
                                                '<span class="form-inline" role="form">'+
                                                    '<p>'+
                                                        '<div class="form-group">'+
                                                            '<input type="text" id="commentChildName" name="commentChildName" class="form-control col-lg-2" data-rule-required="true" placeholder="이름" maxlength="10">'+
                                                        '</div>'+
                                                        '<div class="form-group">'+
                                                            ' <input type="password" id="commentChildPassword" name="commentChildPassword" class="form-control col-lg-2" data-rule-required="true" placeholder="패스워드" maxlength="10">'+
                                                        '</div>'+
                                                        '<div class="form-group">'+
                                                            '<button type="button" id="commentChildSubmit" class="btn btn-default">확인</button>'+
                                                        '</div>'+
                                                    '</p>'+
                                                        '<textarea id="commentChildText" name="commentChildText" class="form-control" style="width:98%" rows="4"></textarea>'+
                                                '</span>'+
                                            '</td>'+
                                        '</tr>';
                                           
                    parentElement.after(commentEditor); 
                }
                   
            });
               
            $( "#list" ).click(function( event ) {
                location.href='/community/notice';
            });
            $( "#modify" ).click(function( event ) {
                location.href='/community/modify/notice/${community.id}';
            });
            $( "#delete" ).click(function( event ) {
                location.href='/community/delete/notice/${community.id}';
            });
            $( "#write" ).click(function( event ) {
                location.href='/community/notice/edit';
            });
        });
	</script>
</body>
</html>