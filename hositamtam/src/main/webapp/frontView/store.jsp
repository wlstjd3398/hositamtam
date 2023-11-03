<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>점포리스트</title>
    <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=51l0xj0874"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
     <!-- Favicon -->
     <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon" />

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
     <link rel="stylesheet" href="../css/loginHeader.css" />
     <link rel="stylesheet" href="../css/footer.css" />
     <link rel="stylesheet" href="../css/storeList.css" />
 
     <!-- JavaScript -->
     <script defer src="../js/storeList.js"></script>
</head>
<body>
    <header class="mainHeader">
        <div class="mainHeader__logo">
          <img class="mainHeader__logo__img" src="../images/logo.ico" alt="logo" />
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
            <li><a class="mainHeader__menu__item">서비스안내</a></li>
            <li><a class="mainHeader__menu__item">시끌시끌</a></li>
            <li><a class="mainHeader__menu__item">카테고리</a></li>
          </ul>
        </nav>
      </header>
      <!-- header 끝 -->
<div class="section">
    <div class="app">
        <div id="map" >
          <button id="insertStore" class="plusStore"><i class="bi bi-plus-circle-fill"></i></button>

        </div>
        
        <div class="right">
            <div class="searchResultName">
                <h4>부평깡통시장</h4>
                <button id="toPost">시끌시끌</button>
            </div>
            <div class="btnSort">
                <button>리뷰 많은순</button><button>별점 높은 순</button><button>찜 많은 순</button>
            </div>
            <div id="mkListResult" class="row">
                <div class="mkcontainer" class="row">
                    <div id="mkImg" class="col-3">
                        <img src="../images/거인통닭.jpg" >
                    </div>
                    <div class="col-9">
                        <p id="mkName">거인통닭</p>
                        <p id="mkaddr">부평1길 39</p>
                        
                        <img src="../images/review.png">리뷰개수
                        <img src="../images/2b50.png" >별점
                        
                        <i class="fa-solid fa-heart"></i>찜개수
                    </div>
                    
                </div>
                <div class="mkcontainer" class="row">
                  <div id="mkImg" class="col-3">
                      <img src="../images/거인통닭.jpg" >
                  </div>
                  <div class="col-9">
                      <p id="mkName">거인통닭</p>
                      <p id="mkaddr">부평1길 39</p>
                      
                      <img src="../images/review.png" alt="">리뷰개수
                      <img src="../images/2b50.png" alt="">별점
                      
                      <i class="fa-solid fa-heart"></i>찜개수
                  </div>
                  
                </div>
                <!-- mk -> store 로 바꾸기 -->
                <div class="mkcontainer" class="row">
        
                    <div id="mkImg" class="col-3">
                        <img src="../images/돼지갈비후라이드.jpg">
                    </div>
                    <div class="col-9">
                        <p id="mkName">국제시장</p>
                        <p id="mkaddr">중구로 43</p>
                        <img src="../images/review.png" alt="">리뷰개수
                        <img src="../images/2b50.png" alt="">별점
                        <i class="fa-solid fa-heart"></i>찜개수
                       
                    </div>
                </div>
                <div class="mkcontainer" class="row">
        
                    <div id="mkImg" class="col-3">
                        <img src="../images/이가네떡볶이.jpg" >
                    </div>
                    <div class="col-9">
                        <p id="mkName">자갈치시장</p>
                        <p id="mkaddr">자갈치해안로 52</p>
                        <img src="../images/review.png" alt="">리뷰개수
                        <img src="../images/2b50.png" alt="">별점
                        <i class="fa-solid fa-heart"></i>찜개수
                       
                    </div>
                </div>
            </div>
            
        </div>
        
    </div>
    
      
        
       </div>
       <footer id="information">
        <div class="information__located">
          <div class="max-container">
            <h2 class="information__title">&copy; TMI - All rights reserved</h2>
            <div class="information__contents">
              <p class="information__title">
                Creator <br />팀장: 안효철 &nbsp;&nbsp; 팀원: 김동영 <br />
                팀원: 김진성 &nbsp;&nbsp; 팀원: 남경인 <br />
                팀원: 석신성 &nbsp;&nbsp; 팀원: 주영진
              </p>
              <p class="information__title">
                <br />
                <i class="fa-brands fa-github"></i>
                https://github.com/wlstjd3398/TMI.git
              </p>
            </div>
          </div>
        </div>
      </footer> 
         

</body>
</html>