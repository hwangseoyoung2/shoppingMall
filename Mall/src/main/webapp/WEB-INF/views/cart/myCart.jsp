<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <meta charset="UTF-8">
    <title>My Cart</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h1{
            color: #333;
            text-align: center;
            margin-top: 50px;
        }

       .total-section input[type="button"] {
            display: inline-block;
            margin: 5px;
            padding: 10px 20px;
            background-color: #B0B0B0;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            border: none; /* 테두리 없음 */
            cursor: pointer; /* 커서 모양 변경 */
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: auto;
            background-color: #fff;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
<body>
    <h1>장바구니</h1>
    <table>
        <tr>
            <th>상품명</th>
            <th></th>
            <th>수량</th>
            <th>가격</th>
            <th></th>
        </tr>
        <c:forEach var="cartItem" items="${itemList2}">
            <tr>
                <td data-product-name="${cartItem.item.title}">${cartItem.item.title}</td>
	                <td>
	                    <img class="item-image" src="/files/${cartItem.item.images[0].fileName}" alt="Image" width="100" height="100">
	                </td>
                <td>${cartItem.quantity}</td>
                <td>${cartItem.item.price}</td>
                <td>
                    <input type="checkbox" class="item-checkbox" value="${cartItem.id}" onchange="updateTotals()">
                    <input type="hidden" class="item-id" value="${cartItem.id}">
                </td>
            </tr>
        </c:forEach>
    </table>
    
    <div class="total-section" style="text-align: right; margin-right: 150px; margin-top:20px;">
        <input type="button" value="주문하기" onclick="checkHowLogin()">
        <input type="button" value="목록" onclick="location.href='/itemList'">
        <p>총 수량: <span id="totalQuantity">0</span></p>
        <p>총 가격: <span id="totalPrice">0</span></p>
        <input type="button" value="삭제" onclick="deleteSelectedItems()">
        <!-- 주문 시 카카오로그인인지 확인을 위해 -->
        <% boolean isKakaoLogin = (boolean) request.getAttribute("isKakaoLogin"); %>
      <input type="hidden" id="isKakaoLogin" value="<%= isKakaoLogin %>" />
        
    </div>
    
<script>   
   //총 가격, 갯수 체크박스
   function formatPriceToWon(price) {
       return price.toLocaleString('ko-KR') + '원';
   }
   
   function getSelectedItemID(productName) {
	    var checkboxes = document.querySelectorAll('.item-checkbox');
	    var itemId = null;

	    checkboxes.forEach(function (checkbox) {
	        var productNameElement = checkbox.parentElement.parentElement.querySelector('td[data-product-name]');

	        if (productNameElement.getAttribute('data-product-name') === productName) {
	            itemId = checkbox.parentElement.parentElement.querySelector('.item-id').value;
	        }
	    });

	    return itemId;
	}
   
   var selectedProductImages = []; // 이미지 URL을 저장하는 배열
   
   function updateTotals() {
	    var checkboxes = document.querySelectorAll('.item-checkbox');
	    var totalQuantity = 0;
	    var totalPrice = 0;
	    var selectedProductNames = [];
	    
	    selectedProductImages = [];

	    checkboxes.forEach(function(checkbox) {
	        if (checkbox.checked) {
	            var quantityElement = checkbox.parentElement.parentElement.querySelector('td:nth-child(3)');
	            var priceElement = checkbox.parentElement.parentElement.querySelector('td:nth-child(4)');
	            var productNameElement = checkbox.parentElement.parentElement.querySelector('td[data-product-name]');
	            var itemId = checkbox.parentElement.parentElement.querySelector('.item-id').value;
	            
	            var quantity = parseInt(quantityElement.textContent);
	            var price = parseFloat(priceElement.textContent);
	            
	            var imageElement = checkbox.parentElement.parentElement.querySelector('.item-image');
	            var imageURL = imageElement.src;

	            totalQuantity += quantity;
	            totalPrice += quantity * price;
	            selectedProductNames.push(productNameElement.getAttribute('data-product-name'));
	            
	            // 2. 이미지 URL을 배열에 추가
	            var imageElement = checkbox.parentElement.parentElement.querySelector('.item-image');
	            var imageURL = imageElement.src;
	            selectedProductImages.push(imageURL);
	        }
	    });
   
       document.getElementById('totalQuantity').textContent = totalQuantity;
   
       var formattedPrice = formatPriceToWon(totalPrice);
       document.getElementById('totalPrice').textContent = formattedPrice;
       
       
   }
 
   //삭제 버튼
    function deleteBtn(itemId){
       console.log(itemId)
       if(confirm("아이템을 삭제하시겠습니까?")){
          location.href="/deleteCartItem?id="+ itemId
          alert("아이템이 삭제되었습니다");
       } else {
          location.href="/myCart";
       }
    }
    
    function deleteUncheckCartMenu(selectedIds) {
        return fetch('/deleteCartMenu', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(selectedIds),
        })
        .then(function(response) {
            if (!response.ok) {
                throw new Error('선택한 상품을 삭제하는 데 실패했습니다.');
            }
        });
    }
    
    function deleteSelectedItems() {
        var checkboxes = document.querySelectorAll('.item-checkbox:checked');
        var selectedIds = [];

        checkboxes.forEach(function(checkbox) {
            selectedIds.push(checkbox.value);
        });

        if (selectedIds.length === 0) {
            alert("선택된 상품이 없습니다.");
            return;
        }

        if (confirm("선택한 상품을 삭제하시겠습니까?")) {
            var selectedIdsJSON = JSON.stringify(selectedIds);

            fetch('/deleteCartMenu', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: selectedIdsJSON,
            })
            .then(function(response) {
                if (response.ok) {
                    alert("선택한 상품이 삭제되었습니다.");
                    location.reload();
                } else {
                    alert("상품 삭제 중 오류가 발생했습니다.");
                }
            });
        } else {
        }
    }
    
   var IMP = window.IMP;
   IMP.init('imp25867251');
   var name = "${member.name}"
   var email = "${member.email}"
   var tel = "${member.phone}"
   var addr = "${member.address}"
    
   var kakaoName = "${kakaoUser.name}"
   
   var loginMethod = "${loginMethod}"; // 서버에서 전달한 로그인 방법
   
   function getSelectedProductData() {
       var checkboxes = document.querySelectorAll('.item-checkbox:checked');
       var selectedProductData = [];

       checkboxes.forEach(function (checkbox) {
           var productNameElement = checkbox.parentElement.parentElement.querySelector('td[data-product-name]');
           var priceElement = checkbox.parentElement.parentElement.querySelector('td:nth-child(4)');
           var quantityElement = checkbox.parentElement.parentElement.querySelector('td:nth-child(3)');
           var idElement = checkbox.parentElement.parentElement.querySelector('.item-id');
           
           var productName = productNameElement.getAttribute('data-product-name');
           var price = parseFloat(priceElement.textContent);
           var quantity = parseInt(quantityElement.textContent);
           var id = idElement.value;

           selectedProductData.push({ id: id, name: productName, price: price, quantity: quantity });
       });

       return selectedProductData;
   }
   
   //총 가격
   function calculateTotalPrice(selectedProductData) {
       var totalPrice = 0;

       for (var i = 0; i < selectedProductData.length; i++) {
           var product = selectedProductData[i];
           totalPrice += product.price * product.quantity;
       }

       return totalPrice;
   }

   //로그인 방법에 확인
   function checkHowLogin() {
      var selectedProductData = getSelectedProductData();
       var totalPrice = calculateTotalPrice(selectedProductData);
       
       var selectedProductNames = selectedProductData.map(function(product) {
           return product.name;
       });

       var queryParams = "?";

       for (var i = 0; i < selectedProductData.length; i++) {
           queryParams += "productName=" + encodeURIComponent(selectedProductData[i].name) + "&";
           queryParams += "price=" + encodeURIComponent(selectedProductData[i].price) + "&";
           queryParams += "quantity=" + encodeURIComponent(selectedProductData[i].quantity) + "&";
           
           if (selectedProductImages[i]) {
               queryParams += "imageURL=" + encodeURIComponent(selectedProductImages[i]) + "&";
           }
           
           var itemId = getSelectedItemID(selectedProductData[i].name);
           queryParams += "id=" + encodeURIComponent(itemId) + "&";
       }
       
       queryParams += "totalPrice=" + encodeURIComponent(totalPrice);

       if (loginMethod === "member") {
           location.href = "/checkMemberInfo" + queryParams;
       } else if (loginMethod === "kakao") {
           location.href = "/checkKakaoInfo" + queryParams;
       }
   }
   
    function getSelectedItems() {
        var checkboxes = document.querySelectorAll('.item-checkbox:checked');
        var selectedItems = [];

        checkboxes.forEach(function (checkbox) {
            var itemId = checkbox.value;
            var quantityElement = checkbox.parentElement.parentElement.querySelector('td:nth-child(3)');
            var priceElement = checkbox.parentElement.parentElement.querySelector('td:nth-child(4)');

            var item = {
                id: itemId,
                quantity: parseInt(quantityElement.textContent),
                price: parseFloat(priceElement.textContent)
            };

            selectedItems.push(item);
        });

        return selectedItems;
    }
   
   function getSelectedProductNames() {
       var checkboxes = document.querySelectorAll('.item-checkbox:checked');
       var selectedProductNames = [];

       checkboxes.forEach(function (checkbox) {
           var productNameElement = checkbox.parentElement.parentElement.querySelector('td[data-product-name]');

           selectedProductNames.push(productNameElement.getAttribute('data-product-name'));
       });

       return selectedProductNames;
   }
</script>

</body>
</html>