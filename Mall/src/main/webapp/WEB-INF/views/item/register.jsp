<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 등록</title>
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
  .button-container2 {
   text-align: right;
   margin-top: 50px;
  }
</style>
</head>
<body>
	<div class="content">
	<div class="heading">상품등록</div>
		<form action="register" method="post" enctype="multipart/form-data">
			<label for="title">메뉴명</label>
			<textarea name="title" id="title" placeholder="메뉴명을 입력하세요"></textarea>
			<label for="content">내용</label>
			<textarea name="content" id="content" placeholder="내용을 입력하세요" style="width:600px;height:150px;"></textarea>
			<label for="files">파일첨부</label>
			<input type="file" name="files" multiple>
			<label for="mainCategory">분류</label>
			<select id="mainCategory" name="mainCategory" onchange="selectSubCategory()">
					<option value="">선택</option>
					<option value="dress">DRESS</option>
					<option value="outer">OUTER</option>
					<option value="top">TOP</option>
					<option value="knit">KNIT</option>
					<option value="blouse">BLOUSE</option>
					<option value="skirt">SKIRT</option>
					<option value="pants">PANTS</option>
					<option value="training">TRAINING</option>
					<option value="homeWear">HOME WEAR</option>
					<option value="inner">INNER</option>
					<option value="shoes">SHOES</option>
					<option value="accBag">ACC/BAG</option>
			</select>
			<label for="price">가격</label>
			<textarea name="price" id="price"></textarea>
			<div class="button-container2">
				<input type="submit" value="등록" onclick="register();">
			</div>
		</form>
	</div>
	<script>
		function selectOption(selectElement, options){
			options.forEach(option => {
				const optionElement = document.createElement('option');
				optionElement.value = option;
				optionElement.textContent = option;
				selectElement.appendChild(optionElement);
			});
		}
		
		function register(){
			if(confirm("게시글을 등록하시겠습니까?")){
				location.href="/";
				alert("게시글이 등록되었습니다.");
			}			
		}
	</script>
</body>
</html>