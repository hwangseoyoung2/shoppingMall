<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet">
<style>
    body {
        position: relative;
        text-align: center;
        background-color: #f5f5f5;
        padding: 0;
    }

    .category-container {
        background-color: #D3D3D3;
        padding: 10px;
    }

    .category-list {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
    }

    .category-item {
        margin: 0 10px;
        position: relative;
    }

    .category-item a {
        color: #333;
        text-decoration: none;
        font-weight: bold;
        font-size: 18px;
        transition: color 0.3s;
    }

    .category-item a:hover {
        color: #ff5722;
    }

    .category-item:hover .sub-category {
        display: block;
    }

    .button-container {
        position: absolute;
        top: 10px;
        right: 10px;
        display: flex;
        gap: 10px;
        float: right;
    }

    .button-container input[type="button"] {
        background-color: #333;
        color: #fff;
        border: none;
        padding: 5px 10px;
        font-size: 8px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .button-container input[type="button"]:hover {
        background-color: #555;    
        
    }

    .sidebar {
        width: 250px;
        height: 100%;
        background-color: #D3D3D3;
        position: fixed;
        top: 0;
        left: -250px;
        overflow-y: auto;
        display: none;
        transition: left 0.3s;
    }

    .sidebar-menu {
        list-style: none;
        padding: 0;
        margin-top: 150px;
    }

    .sidebar-menu li {
        margin-top: 10px;
        padding: 0;
    }

    .sidebar-menu li a {
        display: block;
        padding: 10px 20px;
        color: #333;
        text-decoration: none;
        transition: background-color 0.3s;
    }

    .sidebar-menu li a:hover {
        background-color: #ff5722;
    }

    .sidebar-button {
        background-color: transparent;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
        color: #333; /* Dark text */
        margin-top: 60px;
    }

    .sidebar-button:hover {
        background-color: #ff5722;
    }
    
    .search-button {
	    background-image: url('/image/search.png');
	    width: 24px;
	    height: 24px;
	    border: none;
	    cursor: pointer;
	    background-size: cover;
	    margin-right:20px;
	    margin-left:5px;
		}
	.search-container {
	    display: flex;
	    margin-right: 20px;
	}
	
	#showNotice {
	    position: absolute;
	    top: 10px;
	    left: calc(100% - 1650px);
	    cursor: pointer;
	    padding: 10px;
	    font-size:12px;
	    background-color: transparent;
    	border: none;
    	color:black;
	}
	
	#showQnA {
	    position: absolute;
	    top: 10px;
	    left: calc(100% - 1590px);
	    cursor: pointer;
	    padding: 10px;
	    font-size:12px;
	    background-color: transparent;
    	border: none;
    	color: black;
	}

	#showNotice:hover,
	#showQnA:hover {
	    background-color: #eee;
	}
</style>

</head>
<body>
	<h1 id="mallTitle" style="font-family: 'Open Sans', sans-serif; margin-top:30px;">Shopping Mall</h1>
	<div class="category-container">
	   <!-- 관리자 계정만 사이드바 보이게 -->
	   <div>
	      <%
	         String memberId = (String) session.getAttribute("memberId");
	         String displayStyle = (memberId != null && memberId.equals("admin"))? "block" : "none";
	      %>
		   <input type="button" class="sidebar-button" value=">" onclick="toggleSidebar()" 
		   style="position: absolute; top: 0; left: 0; display: <%= displayStyle %>" >
	   </div>
	<ul class="category-list">
	        <li class="category-item">
	            <a href="dress">DRESS</a>
	        </li>
	        <li class="category-item">
	            <a href="outer">OUTER</a>
	        </li>
	        <li class="category-item">
	            <a href="top">TOP</a>
	        </li>
	        <li class="category-item">
	            <a href="knit">KNIT</a>
	        </li>
	        <li class="category-item">
	            <a href="blouse">BLOUSE</a>
	        </li>
	        <li class="category-item">
	            <a href="skirt">SKIRT</a>
	        </li>
	        <li class="category-item">
	            <a href="pants">PANTS</a>
	        </li>
	        <li class="category-item">
	            <a href="training">TRAINING</a>
	        </li>
	        <li class="category-item">
	            <a href="homeWear">HOME WEAR</a>
	        </li>
	        <li class="category-item">
	            <a href="inner">INNER</a>
	        </li>
	        <li class="category-item">
	            <a href="shoes">SHOES</a>
	        </li>
	        <li class="category-item">
	            <a href="accBag">ACC/BAG</a>
	        </li>
	    </ul>
	</div>
	<div>
		<button id="showNotice" class="showNotice" onclick="location.href='/notice'">NOTICE</button>
		<button id="showQnA" class="showQnA" onclick="location.href='/allQuestion'">Q&A</button>
	</div>
	
    <div class="button-container">
    <div id="search-container">
        <form action="/products" method="get">
	        <input type="text" name="keyword" placeholder="검색어를 입력하세요">
	        <input type="submit" class="search-button" value="">
    	</form>
    </div>
        <input type="button" id="loginBtn" class="loginBtn" value="로그인">
        <input type="button" id="myPageBtn" class="myPageBtn" value="마이페이지" onclick="location.href='/myPage'">
        <input type="button" id="myCartBtn" class="myCartBtn" value="장바구니" onclick="location.href='/myCart'">
    </div>
    
    <div id="products-container"></div>
    
    
    <!-- 사이드바 내용 -->
	<div class="sidebar">
	    <ul class="sidebar-menu">
	    	<li>
	            <button class="sidebar-button" onclick="handleSidebarButtonClick()"><</button>
	        </li>
	        <li><a href="allPayedList">주문 내역</a></li>
	        <li><a href="allRefundList">주문 취소 내역</a></li>
	        <li><a href="adminCheckMember">회원 관리</a></li>
	        <li><a href="/register">메뉴 등록</a></li>
	    </ul>
	</div>
<script>
    // 페이지 로드 시 실행되는 함수
    window.onload = function() {
        updateButtons();
    }
    
    var sidebarOpen = false;
    
 // 버튼 상태 업데이트 함수
    function updateButtons() {
        var loggedIn = <%= session.getAttribute("memberId") != null ? "true" : "false" %>;
        var accessToken = '<%= session.getAttribute("access_token") != null ? "true" : "false" %>';
        var loginButton = document.getElementById("loginBtn");
        var myPageButton = document.getElementById("myPageBtn");
        var sidebar = document.querySelector('.sidebar');
        
        console.log("accessToken: " + accessToken);
        
        if (loggedIn) {
            loginButton.value = "로그아웃";
            loginButton.onclick = function() {
                location.href = '/logout';
            };
            
            var memberId = '<%= session.getAttribute("memberId") %>';
            if (memberId === 'admin' && sidebar) {
                sidebar.style.display = 'block';
            }
            
        } else if (accessToken === "true") {
            loginButton.value = "로그아웃";
            loginButton.onclick = function() {
                location.href = '/kakaoLogout';
            };
        } else {
            loginButton.value = "로그인";
            myPageButton.style.display = "none";
            loginButton.onclick = function() {
                location.href = '/login';
            };
        }
    }


    function toggleSidebar() {
        var sidebar = document.querySelector('.sidebar');
        var buttonContainer = document.querySelector('.button-container');
        if (sidebarOpen) {
            sidebar.style.left = '-250px';
            sidebar.style.display = 'none';
            buttonContainer.style.float = 'right';
        } else {
            sidebar.style.left = '0';
            sidebar.style.display = 'block';
            buttonContainer.style.float = 'left';
        }
        sidebarOpen = !sidebarOpen;
    }
    
    function handleSidebarButtonClick() {
        toggleSidebar();
    }
    
    document.getElementById("mallTitle").style.cursor = "pointer";
    document.getElementById("mallTitle").onclick = function() {
      window.location.href = "/";
    };

    
    document.addEventListener("DOMContentLoaded", function () {
        var showNotice = document.getElementById("showNotice");
        var showQnA = document.getElementById("showQnA");

        window.addEventListener("scroll", function () {
            var scrollPosition = window.scrollY || document.documentElement.scrollTop;

            // 스크롤 위치에 따라 고정 스타일 적용
            if (scrollPosition > 30) {
                showNotice.classList.add("fixed");
                showQnA.classList.add("fixed");
            } else {
                showNotice.classList.remove("fixed");
                showQnA.classList.remove("fixed");
            }
        });
    });
</script>
</body>
</html>