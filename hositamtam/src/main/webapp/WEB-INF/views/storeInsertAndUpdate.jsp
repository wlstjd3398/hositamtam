<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
System.out.println("JOKE storeInsertAndUpdate.jsp");
String slat = request.getParameter("slat");
String slng = request.getParameter("slng");
String mno = request.getParameter("mno");
%>
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
    
    <link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">
	<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous"></script>

    <!-- Font Awesome -->
    <script
      src="https://kit.fontawesome.com/89490613c7.js"
      crossorigin="anonymous"
    ></script>

    <!-- CSS -->
    <link rel="stylesheet" href="../css/loginHeader.css" />
    <link rel="stylesheet" href="../css/footer2.css" />
    <link rel="stylesheet" href="../css/storeInsertAndUpdate.css" />
    <!-- <link rel="stylesheet" href="../css/storeDetail.css" /> -->

    <!-- JavaScript -->
    <script defer src="../js/storeInsertAndUpdate.js"></script>
  </head>
  <body>
    <!-- Header -->
	<%@ include file="navi.jsp" %>
    <!-- Main -->
    <!-- Store Insert And Update -->
  	<section id="store__update" class="section">

		<div class="max-container">
			<div class="storeDetail__info">
				<c:choose>
					<c:when test="${update eq true}">
						<!-- 수정화면 -->
						<form id="store__update__form" class="store__update" action="/finalProject/storeUpdate" method="POST">
							<input type="hidden" name="mno" value="<%=mno%>" />
							<input type="hidden" name="sno" value="${store.sno}"/>
								<label for="store__name" class="store__label"> 
									<input
										class="store__input" type="text" id="store__name" name="sname" value="${store.sname}"
										placeholder="점포의 이름을 지어주세요 !"
									/>
									<button class="change__location">위치 수정</button>
								</label>
							<div class="store__update__form">
								<section class="store__type">
									<h2 class="store__type__title siau__h2">점포 형태</h2>
									<div class="store__type__update">
										<input type="radio" name="stype" value="좌판" <c:if test="${store.stype eq '좌판'}">checked="checked"</c:if> id="storeUpdate__type1"><label for="storeUpdate__type1">좌판</label> &nbsp;&nbsp;&nbsp;
								    	<input type="radio" name="stype" value="매장" <c:if test="${store.stype eq '매장'}">checked="checked"</c:if> id="storeUpdate__type2"><label for="storeUpdate__type2">매장</label>
									</div>
								</section>
								
								<section class="store__payment">
									<h2 class="store__payment__title siau__h2">결제 방식</h2>
									<!-- 모든 결제 방식 리스트 -->
									<div class="store__payment__update">
										<c:forEach var="payment" items="${paymentList}">
					       					<input type="checkbox" name="paytype" value="${payment.payno}">${payment.paytype} &nbsp;&nbsp;&nbsp;
				        				</c:forEach>
									</div>
								</section>
								
								<section class="store__category">
									<h2 class="store__category__title siau__h2">취급 품목</h2>
									<label for="store__category__contents" class="category__label">
										<input
											class="category__input__update"
											type="text"
											id="store__category__contents"
											name="scategory"
											placeholder="점포의 취급품목을 알려주세요 !"
											value="${store.scategory}"
										/>
									</label>
								</section>
								
								<section class="store__photo">
									<h2 class="store__photo__title siau__h2">점포 사진</h2>
									<div>
					        			<!-- 등록된 점포 사진 -->
					        			<img src="../images/${store.sphoto}" class="storeUpdate__photo"/>
					      			</div>
								</section>
							</div>
					        
					        <div class="insertUpdate__error" id="msg"></div>
							<input type="submit" class="store__update__button" value="수정하기">
						</form>
					</c:when>
					
					<c:otherwise>
						<!-- 등록화면 -->
						<form id="store__update__form" class="store__insert" action="/finalProject/storeInsert" method="POST">
							<input type="hidden" name="mno" value="<%=mno%>" />
							<input type="hidden" name="slat" value="<%=slat%>" />
							<input type="hidden" name="slng" value="<%=slng%>" />
								<label for="store__name" class="store__label">
									<input
										class="store__input"
										type="text" id="store__name"
										name="sname"
										placeholder="점포의 이름을 지어주세요 !"
									/>
									<button class="change__location">위치 수정</button>
								</label>
							<div class="store__update__form">
								<section class="store__type">
									<h2 class="store__type__title siau__h2">점포 형태</h2>
									<div class=storeType__radio>
										<input type="radio" name="stype" value="좌판" id="storeType1"><label for="storeType1" class="storeType__label1">좌판</label>
									</div>
									<div class=storeType__radio>
										<input type="radio" name="stype" value="매장" id="storeType2"><label for="storeType2" class="storeType__label2">매장</label>
									</div>
								</section>
								
								<section class="store__payment">
									<h2 class="store__payment__title siau__h2">결제 방식</h2>
									<div class=paymentType__checkbox>
										<input type="checkbox" name="paytype" value="1" id="storePayment1"><label for="storePayment1" class="paymentType__label1">현금</label>
									</div>
									<div class=paymentType__checkbox>
										<input type="checkbox" name="paytype" value="2" id="storePayment2"><label for="storePayment2" class="paymentType__label2">카드</label>
									</div>
									<div class=paymentType__checkbox2>
										<input type="checkbox" name="paytype" value="3" id="storePayment3"><label for="storePayment3" class="paymentType__label3">계좌이체</label>
									</div>
								</section>
								
								<section class="store__category">
									<h2 class="store__category__title siau__h2">취급 품목</h2>
									<label for="store__category__contents" class="category__label">
										<input
											class="category__input"
											type="text"
											id="store__category__contents"
											name="scategory"
											placeholder="점포의 취급품목을 알려주세요 !"
										/>
									</label>
								</section>
								
								<section class="store__photo">
									<h2 class="store__photo__title siau__h2">점포 사진</h2>
									<label class="store__photo__label">
										<input
											type="file"
											name="sphoto"
											class="store__photo__input"
										/>
									</label>
								</section>
							</div>
							<div class="insertUpdate__error" id="msg"></div>
							<input type="submit" class="store__insert__button" value="등록하기">
						</form>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>

    <!-- Footer -->
<!--     <footer id="information" class="section"> -->
<!--       <div class="information__located"> -->
<!--         <div class="max-container"> -->
<!--           <h2 class="information__title">&copy; TMI - All rights reserved</h2> -->
<!--           <div class="information__contents"> -->
<!--             <p class="information__title"> -->
<!--               Creator <br />팀장: 안효철 &nbsp;&nbsp; 팀원: 김동영 <br /> -->
<!--               팀원: 김진성 &nbsp;&nbsp; 팀원: 남경인 <br /> -->
<!--               팀원: 석신성 &nbsp;&nbsp; 팀원: 주영진 -->
<!--             </p> -->
<!--             <p class="information__title"> -->
<!--               <br /> -->
<!--               <i class="fa-brands fa-github"></i> -->
<!--               https://github.com/wlstjd3398/TMI.git -->
<!--             </p> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
<!--     </footer> -->
<%-- <%@ include file="footer.jsp" %> --%>
  </body>
</html>
