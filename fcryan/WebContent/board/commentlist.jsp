<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/include.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="reply_wrap_title">
		<span id="knboard_detail_rspan">댓글 ${replyList.size()}</span>
		<%-- <input type="hidden" id="hidden_replycnt" value="${boardview.replycnt}"> --%>
	</div>
	
	<div id="detail_reply">
		<c:if test="${replyList.size() == 0}">
			<div class="reply_list">
				<div class="reply_line2">
					등록된 댓글이 없습니다. 첫번째 댓글을 남겨주세요:)
				</div>
			</div>
		</c:if>	
		<c:forEach items="${replyList}" var="replyview">
			<div class="reply_list">
				<div class="reply_line1" style="width: 600px;">
					<a href="#" class="reply_writer">${replyview.writer}</a> 
					<c:if test="${sessionScope.loginUser.id == replyview.writer}">
						<a href="#" class="reply_del" data_num="${replyview.rno}">삭제</a>
					</c:if>
					<span id="replylist_date">
						<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${replyview.regdate}"/>
					</span>
				</div>
				<div class="reply_line2">
					<textarea class="replylist_textarea" name="replylist_textarea"
						id="replylist_textarea" rows="" cols="150" readonly="readonly">${replyview.content}</textarea>
				</div>
			</div>
		</c:forEach>
	</div>
</body>
</html>