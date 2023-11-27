<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Content Page</title>
    <style>
    	body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0px;
            text-align: center;
        }
    	
	    img {
	        max-width: 100%;
	        height: auto;
	        display: block;
	        margin: 0 auto;
	        margin-bottom: 15px;
	        margin-top: 100px;
	        width: 300px;
	    }

        .product-info {
            font-size: 18px;
            margin-bottom: 15px;
            text-align: right;
            margin-right: 110px;
            margin-top:100px;
        }

        .addCartForm input[type="button"] {
            font-size: 16px;
            color: white;
            padding: 3px 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 3px;
            background-color: #D3D3D3;
        }

        .button-container {
            text-align: center;
        }
        .consistent-image {
	        max-width: 100%;
	        height: auto;
	        display: block;
	        margin: 0 auto;
	        margin-bottom: 15px;
	        margin-top: 100px;
	        width: 300px;
    	}
    	
	    .image-container {
	        text-align: center;
	        position: relative;
	    }

	    .consistent-image {
	        width: 400px;
	        margin-bottom: 5px;
	    }

	    .button-spacing {
  		    margin-right: 10px;
		}
		
		.quantity-input {
		    width: 30px;
		    text-align: center;
		    -moz-appearance: textfield;
		    margin-right: 10px;
		    margin: 0 5px;
		}
	    .quantity-container {
	        display: flex;
	        align-items: center;
	        justify-content: right;
	        margin-top: 50px;
	        margin-bottom: 10px;
	        margin-right:200px;
	    }
		
		.quantity-button {
		    font-size: 16px;
		    color: white;
		    padding: 5px 10px;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    background-color: #D3D3D3;
		    margin: 0 5px;
		}
		
		.quantity-input::-webkit-inner-spin-button,
		.quantity-input::-webkit-outer-spin-button {
		    appearance: none;
		    margin: 0;
		}
		
		.action-button {
            font-size: 16px;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
        }
		
		#qaButton {
		    font-size: 16px;
            color: white;
            padding: 3px 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 3px;
            background-color: #D3D3D3;
            margin-top: 100px;
            margin-left: 10px;
            
        }
    </style>
</head>
<body>
	<form action="addCart" method="post" class="addCartForm">
		<input type="hidden" id="id" name="id" value="${item.id }">
		<div class="product-info">
		<p style="margin-top:50px; margin-right:80px; font-size:18px;">상품명: ${item.title}</p>
		<p style="margin-right:80px; font-size:18px;">가격 : ${item.price}원</p>
		</div>
        <p style="font-size: 14px; white-space: pre-line; text-align:cen">${item.content}</p>
        <div class="quantity-container">
		    <button class="quantity-button" type="button" onclick="decreaseQuantity()">-</button>
		    <input type="number" id="amount" name="amount" value="1" min="1" class="quantity-input">
		    <button class="quantity-button" type="button" onclick="increaseQuantity()">+</button>
		</div>
		    <br>
		    <input type="button" value="목록" onclick="backList()" style="margin-left:1150px;">
        	<input type="button" value="장바구니" onclick="addToCart()">
        	<input type="button" value="삭제" onclick="deleteItem()" style="visibility: <%= displayStyle %>; margin-left: 1150px; margin-top:10px;" class="button-spacing" id="deleteButton">
		    <input type="button" value="수정" onclick="location.href='modify?id='+${item.id}" style="visibility: <%= displayStyle %>;" class="button-spacing" id="modifyButton">
	<div class="image-container">
	<button id="qaButton" type="button" onclick="location.href='itemQnA?id='+${item.id}">Q&A</button>
	    <c:forEach var="image" items="${item.images}">
	        <img src="/files/${image.fileName}" alt="Image" class="consistent-image">
	    </c:forEach>
	</div>
	</form>
	
	
    <script>
    	//삭제 버튼
        function deleteItem() {
            if (confirm("게시글을 삭제하시겠습니까?")) {
                location.href = "deleteItem?id=" + ${item.id};
                alert("게시글이 삭제되었습니다");
            }
        }
		
    	//목록 버튼
        function backList() {
            if (${sessionScope.btnNum} == '1') {
                history.go(-1);
            } else if (${sessionScope.btnNum} == '2') {
                history.go(-2);
            } else if (${sessionScope.btnNum} == '3') {
                history.go(-3);
            }
        }

        // 수량 버튼
        function increaseQuantity() {
            const quantityInput = document.getElementById("amount");
            const currentQuantity = parseInt(quantityInput.value);
            quantityInput.value = currentQuantity + 1;
        }

        // 수량 버튼
        function decreaseQuantity() {
            const quantityInput = document.getElementById("amount");
            const currentQuantity = parseInt(quantityInput.value);
            if (currentQuantity > 1) {
                quantityInput.value = currentQuantity - 1;
            }
        }
        
    	// 장바구니버튼
        function addToCart() {
            if (confirm("장바구니에 추가하시겠습니까?")) {
                fetch('/addCart', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'id=${item.id}&amount=' + document.getElementById('amount').value,
                })
                .then(function(response) {
                    if (response.ok) {
                        alert("장바구니에 추가되었습니다.");
                        if (confirm("장바구니로 이동하시겠습니까?")) {
                            location.href = "/myCart";
                        }
                    } else {
                        alert("로그인 후 이용 가능한 서비스입니다.");
                    }
                })
                .catch(function(error) {
                    console.error('Error:', error);
                });
                
                return true;
            } else {
                return false;
            }
        }

        var displayStyle = "<%= displayStyle %>";
        if (displayStyle === 'none') {
            document.getElementById("deleteButton").style.visibility = "hidden";
            document.getElementById("modifyButton").style.visibility = "hidden";
        }
    </script>
</body>
</html>
