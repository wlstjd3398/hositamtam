<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>호시탐탐</title>

    <!-- Favicon -->
    <link rel="shortcut icon" href="/finalProject/images/favicon.ico" type="image/x-icon" />

    <!-- G-Market Fonts -->
    <link
      href="https://webfontworld.github.io/gmarket/GmarketSans.css"
      rel="stylesheet"
    />

    <!-- Font Awesome -->
    <script
      src="https://kit.fontawesome.com/89490613c7.js"
      crossorigin="anonymous"
    ></script>

    <!-- CSS -->
    <link rel="stylesheet" href="/finalProject/css/loginHeader.css" />
    <link rel="stylesheet" href="/finalProject/css/footer.css" />
    <link rel="stylesheet" href="/finalProject/css/join.css" />

    <!-- JavaScript -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    
    <script src="/finalProject/js/join.js" charset="UTF-8"></script>
    <script>
    
	    // 검색어 입력 필드에서 Enter 키를 눌렀을 때 검색 실행
	    document.getElementById("searchInput").addEventListener("keyup", function (event) {
	        if (event.key === "Enter") { // Enter 키가 눌렸을 때
	        
	            const searchInput = document.querySelector("#searchInput").value;
	            const encodedSearchInput = encodeURIComponent(searchInput);
	            const newURL = "market.jsp?command=search&query=" + encodedSearchInput;
	            window.location.href = newURL;
	        }
	  	  });
		}

		window.addEventListener('load', init);
    
    </script>
  </head>
  <body>
  
  
  <%@ include file="navi.jsp" %>
  
  
<!-- 기존의 동영님 코드  네비바? 
    <header class="mainHeader">
      <div class="mainHeader__logo">
        <img class="mainHeader__logo__img" src="/finalProject/images/logo.ico" alt="logo" />
      </div>

      <form id="searchForm" method="get" action="SearchController">
        <div class="market__search">
          <input
            type="text"
            class="market__searchInput"
            name="market"
            id="searchInput"
            placeholder="   궁금한 시장 이름을 입력하세요. Ex.부평깡통시장"
          />
          <button
            class="market__searchButton"
            type="submit"
            name="action"
            value="search"
          >
            <i class="fa-solid fa-magnifying-glass"></i>
          </button>
        </div>
      </form>

      <nav class="mainHeader__nav">
        <ul class="mainHeader__menu">
          <li><a class="mainHeader__menu__item" href="#">서비스안내</a></li>
          <li><a class="mainHeader__menu__item" href="#">시끌시끌</a></li>
          <li><a class="mainHeader__menu__item" href="#">카테고리</a></li>
        </ul>
      </nav>
    </header>
 -->
 
 
    <!-- Main -->
    <!-- Sign Up -->
    <section id="join" class="section">
      <div class="max-container">
        <div class="join">
          <form method="POST" id="join__form" action="/finalProject/views/joinMember">
            <div class="join__form">
              <label for="id" class="join__label">
                <input
                  class="join__input"
                  type="text"
                  id="id"
                  name="id"
                  placeholder="아이디" required
                />
                <button type="button" class="duplication__check" id="id_check" onclick="checkIdDuplicate()">중복확인</button>
              </label>
              
              <label for="nickname" class="join__label">
                <input
                  class="join__input"
                  type="text"
                  id="nickname"
                  name="nickname"
                  maxlength="8"
                  placeholder="닉네임" required
                />
                <button type="button" class="duplication__check" id="nickname_check" onclick="checkNicknameDuplicate()">중복확인</button>
              </label>

              <label for="passwd" class="join__label">
                <input
                  class="join__input"
                  type="password"
                  id="passwd"
                  name="passwd"
                  placeholder="비밀번호" required
                />
              </label>

              <label for="repasswd" class="join__label">
                <input
                  class="join__input"
                  type="password"
                  id="repasswd"
                  name="repasswd"
                  placeholder="비밀번호 확인" required
                />
              </label>

              <label for="birthdate" class="join__label">
                <input
                  class="join__input"
                  type="date"
                  id="birthdate"
                  name="birthdate"
                  placeholder="생년월일" required
                />
              </label>

              <label for="gender" class="join__label">
                <input type="radio"  id="genderm" name="gender" value="남" checked/>남
                <input type="radio" id="genderw" name="gender" value="여" />여
              </label>
            </div>

            <div class="join__error" id="msg">${msg}</div>

            <button class="join__button" type="submit" id="join_button">회원가입</button>
          </form>
        </div>
      </div>
    </section>

	<%@ include file="footer.jsp" %>
  </body>
</html>
