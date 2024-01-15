<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <meta charset="UTF-8">
    <title>Q&A 상세 정보</title>
    <style>
        .detail {
            width: 80%;
            max-width: 800px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 30px;
            margin-left: 400px;
            margin-bottom: 50px;
        }

        h3 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            text-align: left;
        }

        textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: none;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            resize: none;
            text-align: left;
        }

        textarea#content {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: none;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            resize: none;
            text-align: left;
            outline: none;
            height:80px;
        }
        
        textarea#answerContent {
            width: 90%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            resize: none;
            text-align: left;
            outline: none;
            height:80px;
        }
        
        textarea#answeredContent {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: none;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            resize: none;
            text-align: left;
            outline: none;
            height:40px;
            }

        form#answerForm {
            display: flex;
            flex-direction: column;
            margin-top:40px;
        }

        button, .cancel-btn {
            background-color: #ccc;
            margin-top: 10px;
            color: #fff;
            width: auto;
            display: inline-block;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
        }
        
        .answer-btn{
        	font-size: 11px;
		    color: #333;
		    padding: 5px 8px;
		    position: relative;
		    bottom: 55px;
		    left: 0;
		    margin-left: 740px;
        }

        button:hover, .cancel-btn:hover {
            background-color: #bbb;
        }
        
        p {
        font-size: 12px;
        }
        
		.answer-item {
		    margin-top: 20px;
		    border: none;
		    padding: 10px;
		    border-radius: 5px;
		    display: flex;
		    flex-direction: column;
		    height: 60px;
		    position: relative;
		    outline: none;
		}

        .answer-content {
            margin-bottom: 10px;
        }

		.created-date {
		    position: absolute;
		    bottom: 0;
		    align-self: flex-end;
		    font-size: 12px;
		    color: #888;
		    margin-right:150px;
		}
		
		.answerDelete-btn {
		    font-size: 11px;
		    color: #333;
		    padding: 3px 5px;
		    position: absolute;
		    bottom: 0;
		    left: 0;
		    margin-left: 700px;
		}
		
		.answerModify-btn {
		    font-size: 11px;
		    color: #333;
		    padding: 3px 5px;
		    position: absolute;
		    bottom: 0;
		    left: 0;
		    margin-left: 660px;
		}
		
		.answerSave-btn {
					    font-size: 11px;
		    color: #333;
		    padding: 3px 5px;
		    position: absolute;
		    bottom: 0;
		    left: 0;
		    margin-left: 700px;
		}
    </style>
</head>
<body>
    <div class="detail">
        <h3>상품 : ${question.item.title}</h3>
        <div>
            <label for="category">질문 유형</label>
            <textarea id="category" name="category" readonly>${question.category}</textarea>
        </div>
        <div>
            <label for="content">질문 내용</label>
            <textarea id="content" name="content" rows="8" readonly>${question.content}</textarea>
        </div>
        <br>
       <h3>답변 목록</h3>
        <c:if test="${not empty answers}">
			<c:forEach var="answer" items="${answers}" varStatus="loopStatus">
			    <div class="answer-item">
			        <div class="answer-content">
			            <textarea id="answeredContent${loopStatus.index}" name="answeredContent" readonly>${answer.content}</textarea>
			        </div>
			        <p class="created-date">${answer.createdDate}</p>
			        <form action="/updateAnswer/${answer.id}" method="post">
			            <input type="hidden" name="answerId" value="${answer.id}">
			            <input type="hidden" id="answerId_${loopStatus.index}" value="${answer.id}">
			            <button type="button" class="answerModify-btn" onclick="modifyAnswer('${loopStatus.index}')">수정</button>
			            <button type="submit" class="answerSave-btn" style="display:none;">저장</button>
			        </form>
			        <button type="button" class="answerDelete-btn" onclick="deleteAnswer(${question.id}, ${answer.id})">삭제</button>
			    </div>
			</c:forEach>
            <div id="answerList"></div>
        </c:if>
        <c:set var="answerId" value="${answers[index].id}" />
		<form id="answerForm" action="/addAnswer" method="post">
		    <input type="hidden" name="questionId" value="${question.id}">
		    <label for="answerContent">답변</label>
		    <textarea id="answerContent" name="answerContent" rows="8" required></textarea>
		    <button type="submit" class="answer-btn">등록</button>
		</form>
		<div>
		    <button type="button" onclick="location.href='/itemQnA?id=${question.item.id}'" class="cancel-btn">뒤로 가기</button>
		    <button type="button" class="questionDelete-btn" onclick="deleteQuestion(${question.id}, ${question.item.id})">삭제</button>
		</div>
		
	</div>
	<script>
	$(document).ready(function () {

	    registerClickEvent();
	    
	    var memberId = "${sessionScope.memberId}";
        var isAdmin = "${memberId == 'admin'}";
        
        var itemId = "${question.item.id}";
        
        if (isAdmin === 'false') {
            $('.answerModify-btn').hide();
            $('.answerDelete-btn').hide();
            $('.created-date').css('margin-right', '10px');
            $('#answerForm').hide();
        }
        
        if(isAdmin === 'true') {
        	$('.questionDelete-btn').hide();
        }

    	
	    $("#answerForm").submit(function (e) {
	        e.preventDefault();

	        $.ajax({
	            type: "POST",
	            url: "/addAnswer",
	            contentType: "application/json;charset=UTF-8",
	            data: JSON.stringify({
	                questionId: "${question.id}",
	                content: $("#answerContent").val()
	            }),
	            success: function (data) {
	                alert("답변이 성공적으로 작성되었습니다.");

	                var newAnswer = '<div class="answer-item">' +
	                    '<div class="answer-content">' +
	                    '<textarea class="answeredContent" name="answeredContent" rows="8" readonly>' + data.content + '</textarea>' +
	                    '</div>' +
	                    '<p class="created-date">' + data.createdDate + '</p>' +
	                    '</div>';

	                $(".answerList").append(newAnswer);

	                $("#answerContent").val("");

	                registerClickEvent();
	            },
	            error: function (error) {
	                alert("답변 작성 중 오류가 발생했습니다.");
	                console.log("Error:", error);
	            }
	        });
	    });

	    function registerClickEvent() {
	        $(".answeredContent").on("click", function () {
	            alert("클릭된 답변: " + $(this).val());
	        });
	    }
	});

	
	function deleteAnswer(questionId, answerId) {
	    if (confirm("정말로 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "DELETE",
	            url: "/deleteAnswer/" + answerId,
	            success: function () {
	                alert("삭제되었습니다.");
	                window.location.href = "/itemQnADetail?id=" + questionId;
	            },
	            error: function (error) {
	                alert("삭제 중 오류가 발생했습니다.");
	                console.log("Error:", error);
	            }
	        });
	    }
	}
	
	function modifyAnswer(index) {
	    $('#answeredContent' + index).prop('readonly', false);
	    
	    $('#answeredContent' + index).css('height', '70px');
	    
	    $('.answerModify-btn:eq(' + index + ')').hide();
	    $('.answerSave-btn:eq(' + index + ')').show();
	    $('.answerDelete-btn:eq(' + index + ')').hide();
	    
	    var answerId = $('#answerId_' + index).val();
	    console.log("answerId:", answerId);

	}
	
	$(".answerSave-btn").on("click", function () {
	    var index = $(".answerSave-btn").index(this);
	    var answerId = $('#answerId_' + index).val();
	    
	    console.log("answerId:", answerId);
	
	    $('#answeredContent${index}').css('height', 'auto');
	    $('#answeredContent${index}').prop('readonly', true);
		
	    $.ajax({
	        type: "POST",
	        url: '/updateAnswer/'+ answerId,
	        contentType: "application/json;charset=UTF-8",
	        data: JSON.stringify({
	        	content: $('#answeredContent' + index).val()
	        }),
	        success: function (response) {
	            alert("답글이 수정되었습니다.");
	            location.reload();
	        },
	        error: function (error) {
	            alert("답글 수정 중 오류가 발생했습니다.");
	            console.log("Error:", error);
	        }
	    });

	    $('.answerModify-btn:eq(${index})').show();

	    $('.answerSave-btn:eq(${index})').hide();
	});
	
	function deleteQuestion(questionId, itemId) {
	    if (confirm("정말로 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "DELETE",
	            url: "/deleteQuestion/" + questionId + "/" + itemId,
	            success: function () {
	                alert("삭제되었습니다.");
	                window.location.href = "/itemQnA?id=" + itemId;
	            },
	            error: function (error) {
	                alert("삭제 중 오류가 발생했습니다.");
	                console.log("Error:", error);
	            }
	        });
	    }
        console.log("questionId: ",questionId);
        console.log("itemId: ", itemId);
	}

	</script>
	
</body>
</html>