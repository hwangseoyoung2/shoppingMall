<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/resources/header.jsp" %>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }

    .container {
      width: 60%;
      margin: 0 auto;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
      border-radius: 10px;
      margin-top: 70px;
    }

    h1 {
      text-align: center;
      color: #000000;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
      align-content: center;
      margin-left:25px;
    }

    th, td {
      border: 1px solid #ccc;
      padding: 10px;
      text-align: left;
    }

    th {
      background-color: #f2f2f2;
    }

    .container input[type="text"] {
      width: 50%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      border: none;
    }

   .container input[type="button"] {
     background-color: #B0B0B0;
     color: #fff;
     border: none;
     padding: 10px 20px;
     cursor: pointer;
     border-radius: 5px;
     margin-top: 30px;
     float: right;
     margin-left: 10px;
   }
    .container input[type="button"]:hover {
      background-color: #C0C0C0;
    }

   .product-container {
     display: flex;
     align-items: center;
     margin-bottom: 10px;
   }
   
   .product-container img {
     max-width: 100px;
     max-height: 100px;
     margin-right: 10px;
   }
   
   .product-name {
     font-weight: bold;
   }
  </style>
</head>
<body>
     <div class="container">
       <h1>주문 정보</h1>
       <table>
         <tr>
           <th>이름</th>
           <td><input type="text" id="name" name="name" value="${member.name }"></td>
         </tr>
         <tr>
           <th>주소</th>
           <td><input type="text" id="address" name="address" value="${member.address }" readonly /></td>
         </tr>
         <tr>
           <th>상세주소</th>
           <td><input type="text" id="detailAddress" name="detailAddress" value="${member.detailAddress }"></td>
         </tr>
         <tr>
           <th>주문 상품</th>
           <td id="orderedProducts"></td>
           <td style="border: none;"><div id="imageContainer"></div></td>
         </tr>
         <tr>
           <th>결제 금액</th>
           <td id="totalPrice"></td>
         </tr>
         <tr>
           <th>총 수량</th>
           <td id="totalQuantity"></td>
         </tr>
       </table>
       <input type="button" onclick="location.href='/'" value="홈으로 이동">
       <input type="button" onclick="requestPay()" value="주문하기">
     </div>
     <c:forEach var="cartItem" items="${itemList }">
        <tr>
           <th></th>
        </tr>
        <tr>
           <td>
              <input type="hidden" name="cartId" value="${cartItem.cart.id }">
              <input type="hidden" name="itemId" value="${cartItem.item.id }">
           </td>
        </tr>
     </c:forEach>
     <input type="hidden" id="memberId" name="memberId" value="${member.memberId }">
</body>
<script>
   document.addEventListener("DOMContentLoaded", function() {
       var urlParams = new URLSearchParams(window.location.search);

       var orderedProductsElement = document.getElementById("orderedProducts");
       var productNames = urlParams.getAll("productName");
       var totalPrice = 0;
       var productImages = urlParams.getAll("imageURL");
       var itemIds = urlParams.getAll("id");

       for (var i = 0; i < productNames.length; i++) {
           var productName = productNames[i];
           var productImage = productImages[i];

           var productContainer = document.createElement("div");
           productContainer.classList.add("product-container");

           var productImageElement = document.createElement("img");
           productImageElement.alt = productName;
           productImageElement.width = 100;
           productImageElement.height = 100;

           var productNameElement = document.createElement("span");
           productNameElement.textContent = productName;

           productImageElement.onload = (function (imageElement, price, quantity) {
               return function () {
                   totalPrice += parseFloat(price) * parseInt(quantity);

                   var totalPriceElement = document.getElementById("totalPrice");
                   totalPriceElement.textContent = formatPriceToWon(totalPrice);

                   productContainer.appendChild(imageElement);
                   productContainer.appendChild(productNameElement);

                   orderedProductsElement.appendChild(productContainer);
               };
           })(productImageElement, urlParams.getAll("price")[i], urlParams.getAll("quantity")[i]);

           productImageElement.onerror = function () {
               console.error("이미지 로드 오류");
           };

           productImageElement.src = productImage;
       }

       var totalQuantityElement = document.getElementById("totalQuantity");
       totalQuantityElement.textContent = urlParams.getAll("quantity").reduce(function(acc, quantity) {
           return acc + parseInt(quantity);
       }, 0);
   });

   function formatPriceToWon(price) {
       return price.toLocaleString('ko-KR') + '원';
   }
   
      var IMP = window.IMP;
      IMP.init('imp25867251');
      
      var email = "${member.email}"
      var tel = "${member.phone}"
      

         function requestPay() {
          var userName = document.getElementsByName("name")[0].value;
          var userAddress = document.getElementById("address").value;
          var detailAddress = document.getElementById("detailAddress").value;
          var totalAmount = parseInt(document.getElementById("totalPrice").textContent.replace(/[^\d]/g, ''), 10);
          var userId = document.getElementById("memberId").value;

          var urlParams = new URLSearchParams(window.location.search);
          
          var productNames = urlParams.getAll("productName");
          var productName = productNames.join(', ');
          
          var itemIds = urlParams.getAll("id");
          var quantities = urlParams.getAll("quantity");

          var cartItems = [];
          var cartItemElements = document.querySelectorAll("input[name='cartId']");
          var itemElements = document.querySelectorAll("input[name='itemId']");
          
          for (var i = 0; i < itemIds.length; i++) {
        	  var itemId = parseInt(itemIds[i], 10);
              var quantity = quantities[i];
              var cartId = parseInt(cartItemElements[i].value, 10);
              var itemId2 = parseInt(itemElements[i].value, 10);

              cartItems.push({
                  id: itemId,
                  quantity: quantity,
                  cart: {
                      id: cartId,
                  },
                  item: {
                      id: itemId2,
                  }
              });
          }

          IMP.request_pay({ 
              pg: 'html5_inicis',
              pay_method: 'card',
              merchant_uid: 'merchant_' + new Date().getTime(),
              name: productName,
              amount: totalAmount,
              buyer_name: userName,
              buyer_email: email,
              buyer_tel: tel,
              buyer_addr: userAddress + ' ' + detailAddress,
              
          }, function (rsp) {
              if (rsp.success) {
                  var imp_uid = rsp.imp_uid;
                
                  var paymentData = {
                      pg: 'html5_inicis',
                      pay_method: 'card',
                      merchant_uid: 'merchant_' + new Date().getTime(),
                      name: productName,
                      amount: totalAmount,
                      buyer_name: userName,
                      buyer_email: email,
                      buyer_tel: tel,
                      buyer_addr: userAddress + ' ' + detailAddress,
                      imp_uid: imp_uid,
                      buyer_id: userId,
                      cartItems: cartItems,
                      
                  };
                  $.ajax({
                      type: "POST",
                      url: "/payment/save",
                      contentType: "application/json",
                      data: JSON.stringify(paymentData),
                      success: function (createdPayment) {
                          var paymentId = createdPayment.id;
                          console.log("paymentId", paymentId);
                          if (rsp.paid_amount == paymentData.amount) {
                              alert("결제 완료");
                              $.ajax({
                                  type: "POST",
                                  url: "/cart/remove/" + paymentId,
                                  contentType: "application/json",
                                  data: JSON.stringify(itemIds),
                                  success: function (response) {
                                 	 window.location.href="/payedItemList";
                                  },
                                  error: function () {
                                  }
                              });
                              
                          } else {
                              alert('결제에 실패했습니다.');
                          }
                      },
                      error: function () {
                      }	
                  });
              }
          });
      }
</script>
</html>