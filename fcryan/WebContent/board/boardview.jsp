<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>
<%
	String referer = request.getHeader("referer");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	a {
		text-decoration: none;
	}
	
	#board_wrap {
		width: 800px;
		border: 1px solid black;
		margin: 230px auto 40px;
		border-radius: 5px;
		box-sizing: border-box;
		border-top: 20px solid #2C3E50 !important;
		padding: 20px;
		padding-bottom: 40px;
		box-shadow: 0 4px 10px 0 rgba(0,0,0,0.2), 0 4px 20px 0 rgba(0,0,0,0.19);
	}
	
	.box-title {
		margin: 0px;
		margin-bottom: 10px;
	}
	
	#content {
		resize: none;
	}
	
	#reply_wrap {
		margin: 0 auto 40px;
		border: 1px solid black;
		width: 800px;
		box-sizing: border-box;
		border-radius: 4px;
		box-shadow: 0 4px 10px 0 rgba(0,0,0,0.2), 0 4px 20px 0 rgba(0,0,0,0.19);
	}
	
	#reply_wrap_title {
		height: 30px;
		margin: 0px;
		border-bottom: 1px solid black;
		background-color: #2C3E50;
	}
	
	#knboard_detail_rspan {
		color: white;
		font-size: 15px;
		line-height: 30px;
		padding-left: 10px;
	}
	
	#detail_reply {
		width: 799px;
		padding: 20px;
		box-sizing: border-box;
	}
	
	.box {
		margin: 10px;
	}
	
	.reply_list {
		border: 1px solid black;
		border-radius: 4px;
		padding: 10px;
		background-color: white;
	}
	
	.reply_writer {
		color: black;
		font-weight: bold;
		font-size: 16px;
		text-decoration: none;
	}
	
	#replylist_date {
		float: right;
		color: black;
	}
	
	.replylist_textarea {
		padding: 5px;
		width: 718px;
		resize: none;
		border-radius: 4px;
		box-sizing: border-box;
		border: 1px solid #BBBBBB;
		font-size: 13px;
	}
	
	.reply_login {
		border-top: 1px solid black;
		padding-left: 10px;
	}
	
	#reply_nologin {
		
	}
	
	.reply_nologin_span {
		width: 14px;
		line-height: 40px;
		font-size: 12px;
	}
	#reply_btn {
		background-color: #F39C12;
		display: inline-block;
		margin-top: 10px;
	}
	#reply_btn:hover {
		background-color: #FF5E00;
	}
	.reply_btn {
		background-color: #3498DB;
		padding: 7px 15px;
	    font-size: 14px;
	    border-radius: 25px;
	    color: white;
	    outline: none;
	    border: 0px;
	    cursor: pointer
	}
	.reply_btn:hover {
		box-shadow: 0 4px 10px 0 rgba(0,0,0,0.2), 0 4px 20px 0 rgba(0,0,0,0.19);
	}
	.reply_del {
		font-size: 14px;
		color: red;
	}
	.btn-warning {
		background-color: #F39C12;
		margin-left: 5px;
	}
	.btn-danger {
		background-color: #e12e1c;
	}
	.btn-primary {
		float: right;
	}
	#download {
		background-color: white;
		font-size: 17px;
	}
	#answer_btn {
		color: white;
		background-color: #18BC9C;
		margin-right: 10px;
	}
	#smart_form {
		background-color: white;
		border: 1px solid #2C3E50;
		border-radius: 5px;
		padding: 10px;
	}
	.form-group {
		border-radius: 5px;
		border: 1px solid #2C3E50;
		padding: 10px;
		margin-bottom: 10px;
	}
	.form-control {
		font-size: 20px;
		display: block;
		outline: none;
		border: 0px;
	}
	.category_text {
		font-size: 15px;
		display: block;
		margin-bottom: 5px;
		font-style:italic;
		color: #F39C12;
	}
	
	table {
		width: 738px;
		border-collapse: collapse;
		border-radius: 4px;
		border-top: 2px solid black;
		border-bottom: 2px solid black;
		border-left: 0px;
		border-right: 0px;
		margin-bottom: 10px;
		font-size: 17px;
	}
	th, td {
		border: 1px solid black;
		padding-left: 15px;
	}
	th {
		background-color: #2C3E50 !important;
		color: white;
		height: 35px;
		text-align: left;
		width: 20%;
	}
	td {
		height: 35px;
		background-color: white;
	}
	#detailContent {
		padding: 20px;
	}
	i {
		display: inline-block;
		padding-left: 10px;
	}
	i.fa-eye {
		color: #3498DB;
	}
	i.fa-heart {
		color: #e12e1c;
	}
	.reply_logina {
		font-size: 15px;
		font-weight: bold;
		color: #3498DB;
	}
	#frm_reply {
		margin: 0px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		/* comment_list(); */
	});
	
	
	function comment_list() {
		var bno = ${boardview.bno};
		$.ajax({
			type: "post",
			url: "commentlist.bizpoll",
			data: "bno=" + bno,
			success: function(result) {
				$("#commentList").html(result);
			}
		});
	}
	
	$(document).on("click", ".reply_del", function(){
		var rno = $(this).attr("data_num");
		
		$.ajax({
			url: "replydelete.bizpoll",
			type: "POST",
			dataType: "json",
			data: "rno=" + rno,
			success: function() {
				comment_list();
			},
			error: function() {
				alert("System Error!!!");
			}
		});
	});
	
	$(document).on("click", "#reply_btn", function(){
		$("#frm_reply").submit();
	});
	
	$(document).on("click", ".btn-danger", function(){
		var bno = $("#bno").val();
		var replycnt = $("#hidden_replycnt").val();
		
		if(replycnt > 0) {
			alert("댓글이 있는 글은 삭제하실수 없습니다.");
			$("#knboard_detail_rspan").focus();
			return false;
		} else {
			location.href="boarddelete.bizpoll?boardnum="+ bno;	
		}
	});
	$(document).on("click", "#answer_btn", function(){
		location.href="answer.bizpoll?bno=${boardview.bno}";
	});
	$(document).on("click", "#returnGo", function(){
		location.href = "<%=referer%>";
	});
</script>
</head>
<body>
	<div id="board_wrap">
		<div class="box box-primary">
			<div class="box-header">
				<h3 class="box-title">질문 게시판</h3>
			</div>
			<!-- form속성에 action을 지정하지 않으면 현재 경로를 그대로 action의 대상 경로로 설정 -->
			<form role="form" method="post" id="frm1">
				<input type="hidden" name="bno" id="bno" value="${boardview.bno}">
			</form>

			<div class="box-body">
				<table>
					<tr>
						<th style="border-left: 0px">제목</th>
						<td colspan="3" style="border-right: 0px">
							<span class="category_text">${boardview.bno}번째 글</span>
							<span id="title" class="form-control" >${boardview.title}</span>
						</td>
					</tr>
					<tr>
						<th style="border-left: 0px">작성일</th>
						<td style="width: 30%;"><fmt:formatDate pattern="yyyy-MM-dd" value="${boardview.regdate}" /></td>
						<th style="border-left: 0px;">작성자</th>
						<td style="width: 30%; border-right: 0px;">${boardview.writer}</td>
					</tr>
					<tr>
						<th style="border-left: 0px">첨부파일</th>
						<td colspan="2" style="border-right:0px">
							<c:if test="${boardview.filesize > 0}">
								<div id="download">
								
								<a href="download.bizpoll?file=${boardview.filename}">${boardview.filename}
																			   (<fmt:formatNumber type="number" pattern="0.0" value="${boardview.filesize / 1024}"></fmt:formatNumber> kb)</a></div>
							</c:if>
						</td>
						<td style="border-left: 0px; border-right: 0px; text-align: center;"><i class="fa fa-eye"></i> ${boardview.viewcnt} <i class="fa fa-heart"></i> ${boardview.goodcnt}</td>
					</tr>
					<tr>
						<td id="detailContent" colspan="4" style="border-left: 0px; border-right: 0px;">
							${boardview.content}
							<!-- <textarea class="form-control" id="content" name="content" rows="3"
						cols="" readonly="readonly"></textarea> -->
						</td>
					</tr>
				</table>
			</div>
			
			<div id="user_btn">
				<button type="button" id="returnGo" class="reply_btn">게시판 목록</button>
				<button id="answer_btn" class="reply_btn">답변</button>
				
				<c:if test="${sessionScope.loginUser.id == boardview.writer}">
					<button type="submit" class="reply_btn btn-warning btn-primary">수정</button>
					<button type="submit" class="reply_btn btn-danger btn-primary">삭제</button>
				</c:if>
			</div>
		</div>
	</div>

	<div id="reply_wrap">
		
		<div id="commentList">
			<div id="reply_wrap_title">
				<span id="knboard_detail_rspan">댓글 ${boardview.replycnt}</span>
				<input type="hidden" id="hidden_replycnt" value="${boardview.replycnt}">
			</div>
			
			<div id="detail_reply">
			<c:if test="${boardview.replycnt == 0}">
				<div class="reply_list">
					<div class="reply_line2">
						등록된 댓글이 없습니다. 첫번째 댓글을 남겨주세요:)
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
		</div>
		<c:choose>
			<c:when test="${empty sessionScope.loginUser}">
				<div class="reply_login" id="reply_nologin">
					<span class="reply_nologin_span"><a href="login.bizpoll"
						class="reply_logina">로그인</a>을 하시면 댓글을 등록할 수 있습니다.</span>
				</div>
			</c:when>
			<c:otherwise>
				<form action="replyinsert.bizpoll" method="POST" name="frm_reply" id="frm_reply">
					<div id="detail_reply" class="reply_login">
						<div class="reply_list">
							<div class="reply_line1">
								<a href="#" class="reply_writer">작성자: ${boardview.writer}</a>
							</div>
							<div class="reply_line2">
								<textarea class="replylist_textarea" name="re_textarea"
									id="replylist_textarea" rows="" cols="150"
									placeholder="댓글을 남겨보세요."></textarea>
								<a href="#" class="reply_btn" id="reply_btn">댓글등록</a>
								
								<input type="hidden" name="re_writer" value="${sessionScope.loginUser.id}">
								<input type="hidden" name="re_bno" value="${boardview.bno}">
							</div>
						</div>
					</div>
				</form>
			</c:otherwise>
		</c:choose>


	</div>
</body>
<%@ include file="../include/footer.jsp" %> 
</html>