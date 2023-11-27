<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f7f7f7;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
  }
  
  .content {
    width: 80%;
    max-width: 600px;
    background-color: #fff;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.1);
  }

  .heading {
    font-size: 24px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
  }

  form label {
    font-weight: bold;
    display: block;
    margin-bottom: 5px;
  }

  input[type="text"],
  select,
  textarea {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
  }

  select {
    height: 40px;
  }

  input[type="file"] {
    margin-bottom: 15px;
  }

  input[type="submit"] {
    background-color: #007bff;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }
  
  #title, #price {
    height: 29px;
  }
  
  #title,
  #price,
  #content {
    resize: none;
  }
  .button-container {
   text-align: right;
  }
</style>
</head>
<body>
	<div class="content">
	<div class="heading">상품 수정</div>
		<form action="modify" method="post" enctype="multipart/form-data">
			<input type="hidden" id="id" name="id" value="${modify.id }">
			메뉴명 : <textarea name="title" id="title">${modify.title }</textarea>
			내용 : <textarea name="content" id="content" style="width:600px;height:150px;">${modify.content }</textarea>
			파일 첨부 : <input type="file" name="files" multiple>
			
	         <select id="mainCategory" name="mainCategory" onchange="selectSubCategory()">
	               <option value="">선택</option>
	               <option value="dress" ${previousCategory == 'dress' ? 'selected' : ''}>DRESS</option>
	               <option value="outer" ${previousCategory == 'outer' ? 'selected' : ''}>OUTER</option>
	               <option value="top" ${previousCategory == 'top' ? 'selected' : ''}>TOP</option>
	               <option value="knit" ${previousCategory == 'knit' ? 'selected' : ''}>KNIT</option>
	               <option value="blouse" ${previousCategory == 'blouse' ? 'selected' : ''}>BLOUSE</option>
	               <option value="skirt" ${previousCategory == 'skirt' ? 'selected' : ''}>SKIRT</option>
	               <option value="pants" ${previousCategory == 'pants' ? 'selected' : ''}>PANTS</option>
	               <option value="training" ${previousCategory == 'training' ? 'selected' : ''}>TRAINING</option>
	               <option value="homeWear" ${previousCategory == 'homeWear' ? 'selected' : ''}>HOME WEAR</option>
	               <option value="inner" ${previousCategory == 'inner' ? 'selected' : ''}>INNER</option>
	               <option value="shoes" ${previousCategory == 'shoes' ? 'selected' : ''}>SHOES</option>
	               <option value="accBag" ${previousCategory == 'outer' ? 'selected' : ''}>ACC/BAG</option>
	         </select>
			가격
			<textarea name="price" id="price">${modify.price }</textarea>
			<div class="button-container">
				<input type="submit" value="등록" onclick="modify();">
			</div>
		</form>
	</div>
	<script>
		let previousCategory;
		
		function selectOption(selectElement, options){
			options.forEach(option => {
				const optionElement = document.createElement('option');
				optionElement.value = option;
				optionElement.textContent = option;
				selectElement.appendChild(optionElement);
			});
		}
		
		function modify() {
		    const formData = new FormData(document.querySelector('form'));

		    $.ajax({
		        url: '/modify',
		        type: 'POST',
		        data: formData,
		        processData: false,
		        contentType: false,
		        success: function (response) {
		            if (response === '게시글이 수정되었습니다.') {
		            	alert(response);
		            	window.location.replace("/");

		            }
		        },
		        error: function () {
		            alert('서버 오류가 발생했습니다.'	);
		        }
		    });
		}

	</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>