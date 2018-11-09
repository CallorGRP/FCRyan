<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		<div id="reply_wrap_title">
			<span id="knboard_detail_rspan">댓글 ${replyview.size()}</span>
			<input type="hidden" id="hidden_replycnt" value="${replyview.size()}">
		</div>
		
		<div id="detail_reply">
		<c:if test="${replyview.size() == 0}">
			<div class="reply_list">
				<div class="reply_line2">
					등록된 댓글이 없습니다. 댓글을 등록해주세요.
				</div>
			</div>
		</c:if>	
			<c:forEach items="${replyview}" var="replyview">
				<div class="reply_list">
					<div class="reply_line1">
						
						<a href="#" class="reply_writer">${replyview.writer}</a> 
						
						
						<c:if test="${sessionScope.loginUser.mid == replyview.writer}">
							<a href="#" class="reply_del" data_num="${replyview.rno}">삭제</a>
						</c:if>
						
						
						<span id="replylist_date">${replyview.regdate}</span>
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