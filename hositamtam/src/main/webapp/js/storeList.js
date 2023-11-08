let xhr = new XMLHttpRequest();
let locations = [];
let mapOptions;
let map;
let markers = [];
let currentMno;
let currentId = null;
let currentSno;
let mname;




// mno 값을 매개변수로 해당 시장의 중심좌표, 시장명 반환
function latLngAjaxHandler() {
	if (xhr.readyState === 4 && xhr.status === 200) {
		
		const latLng = JSON.parse(xhr.responseText);
		
		
			
		
        // storeErrorMsg 값(내용)을 가져옵니다.
        const storeErrorMsg = latLng[0].storeErrorMsg;
        
        // 에러 메시지가 있는지 확인하고 화면에 표시
        if (storeErrorMsg) {
			
			// 기존 jsp에 있던 div 태그들 숨기기
			document.querySelector("#map").style.display = "none";
            document.querySelector("#marketName").style.display = "none";
            document.querySelector("#manyReview").style.display = "none";
            document.querySelector("#manyRating").style.display = "none";
            document.querySelector("#manyStoreLike").style.display = "none";
            document.querySelector("#storeContent").style.display = "none";
			
            // 에러 메시지를 표시할 요소 선택
            document.querySelector("#storeErrorMsg").innerHTML = storeErrorMsg;
            
            // 마커 및 기존 컨텐츠를 지우기
            removeMarker();
        }
		
		
	
		
		
		mlat = latLng[0].mlat;
		mlng = latLng[0].mlng;
		mname = latLng[0].mname;
		
		// 페이지가 로드되자마자 mlat, mlng 값으로 지도 중심을 설정
        //map.setCenter(new naver.maps.LatLng(mlat, mlng));
        
        
        // 지도 생성 (+ 일반, 위성 지도 선택할 수 있도록 토글 버튼 생성)
		mapOptions = {
		    center: new naver.maps.LatLng(mlat, mlng), // 초기 좌표 설정
		    zoom: 16,
		    mapTypeControl: false, // 위성 지도 토글 버튼을 표시
		    mapTypeControlOptions: {
		        style: naver.maps.MapTypeControlStyle.BUTTON,
		        position: naver.maps.Position.BOTTOM_LEFT
		    }
		};
		
		map = new naver.maps.Map('map', mapOptions);

		markers = [];
        
        // 지도 생성 후, 해당 시장명 + 해당 시장 커뮤니티 버튼 생성
        document.querySelector('#marketName').innerHTML ='<div class="searchResultName"><h4>' + mname + '</h4>'+ '  <div id="toPost"><a href="/finalProject/views/postMain?mno='+ currentMno +'">시끌시끌</a></div></div>';
        
        getStoreInfo();
    }
}




// mno로 점포 정보들을 요청하는 함수
function getStoreInfo() {
	xhr.onreadystatechange = storeAjaxHandler;
	
    let param = '?command=getStoreInMarket&mno=' + currentMno;
    xhr.open('GET', '../ajaxController/toAjaxController.jsp' + param, true);
    xhr.send();
}








function init() {

	// 로컬스토리지에서 파라미터 mno값 읽어오기
	const mnoToStore = window.localStorage.getItem('mnoToStore');
	const currentmno = JSON.parse(mnoToStore);
	
	currentMno = currentmno.mno;
	let errMsg = currentmno.msg;
	
	if(errMsg) {
		// 기존 jsp에 있던 div 태그들 숨기기
		document.querySelector("#map").style.display = "none";
        document.querySelector("#marketName").style.display = "none";
        document.querySelector("#manyReview").style.display = "none";
        document.querySelector("#manyRating").style.display = "none";
        document.querySelector("#manyStoreLike").style.display = "none";
        document.querySelector("#storeContent").style.display = "none";
        document.querySelector("#storeErrorMsg").style.display = "none";
		
        // 에러 메시지를 표시할 요소 선택
        document.querySelector("#errMsg").innerHTML = errMsg;
        
        // 마커 및 기존 컨텐츠를 지우기
        removeMarker();
	}
	
	
	
	// 로그인되어 있는지 아닌지 세션스토리지 존재 유무로 판단하기
	const memberId = window.sessionStorage.getItem('memberId');
	const member = JSON.parse(memberId);
	   
	if (member) {
	    currentId = member.id;
	    console.log("현재 접속한 사용자의 id: " + currentId);
	} else {
	    console.log('현재 접속한 사용자는 비회원입니다.');
	}

	
	
	
	
	
	xhr.onreadystatechange = latLngAjaxHandler;
	
	let param = '?command=getMarketLatLng&mno=' + currentMno;
	xhr.open('GET', '../ajaxController/toAjaxController.jsp' + param, true);
	xhr.send();




    document.querySelector('#manyReview').addEventListener('click', function(){
		xhr.onreadystatechange = storeAjaxHandler;
		
		let param = '?command=getManyReview&mno=' + currentMno;
        xhr.open('GET', '../ajaxController/toAjaxController.jsp' + param, true);
        xhr.send();
	});
	
	
    document.querySelector('#manyRating').addEventListener('click', function(){
		xhr.onreadystatechange = storeAjaxHandler;
		
	    let param = '?command=getManyRating&mno=' + currentMno;
        xhr.open('GET', '../ajaxController/toAjaxController.jsp' + param, true);
        xhr.send();
	});
	
	
    document.querySelector('#manyStoreLike').addEventListener('click', function(){
		xhr.onreadystatechange = storeAjaxHandler;
		
	    let param = '?command=getManyStoreLike&mno=' + currentMno;
        xhr.open('GET', '../ajaxController/toAjaxController.jsp' + param, true);
        xhr.send();
	});




	// '새 점포 등록' 버튼 클릭 이벤트
	document.querySelector('#insertStore').addEventListener('click', insertStoreHandler);
	
	
    // 점포 정보 클릭 시, 해당 점포와 연동된 지도 상의 인포윈도우창 띄우기
    document.querySelector('#storeContent').addEventListener('click', function(event) {
        if (event.target.getAttribute('class') === 'personalScontent') {
			currentSno = event.target.getAttribute('id');
            
            openInfo();
        }
    });
  
}
	


// 해당 점포 정보에 연동된 인포윈도우창을 지도 상에서 띄우기
function openInfo() {
	
    for (var i = 0; i < locations.length; i++) {
        if (parseFloat(currentSno) === locations[i].sno) {
			
            let marker = markers[i]; // 이미 생성된 마커를 가져옵니다.
            

	        let infowindow = new naver.maps.InfoWindow({	// 상세페이지로, 등록(수정)페이지로 이동하는 a태그는 해당 페이지들을 제어하는 컨트롤러로 보내기
	            content: '<div class="infoContent"><div id="'+ locations[i].sno +'" class="personalInfowindowScontent"><h4>점포명: ' + locations[i].sname + '</h4>' +
                   '<p>취급품목: ' + locations[i].scategory + '</p>' +
                   '<p>점포형태: ' +  locations[i].stype + '</p>' +
                   '<div class="countContainer">' +
                   '<img src="../images/2b50.png" alt="평균별점">' + locations[i].savgrating + '(' + locations[i].sreviewcount + ')' +
                   '<i class="fa-solid fa-heart"></i>: ' +  locations[i].sfavoritecount +
                   '</div>' +
                   '<div class="imgContainer">' +
                   '<img src="' + locations[i].sphoto  + '">' +
                   '</div></div>' +
                   '<div class="btnContainer">' +
                   '<a href="/finalProject/views/storeDetail?sno=' + locations[i].sno  + '">점포 상세</a>' +
                   '<a href="/finalProject/views/storeUpdate?sno=' +locations[i].sno  + '">점포 수정</a>' +
                   '</div></div>'   });

	        
            infowindow.open(map, marker);
            
            naver.maps.Event.addListener(map, "click", function (mouseEvent) {
                infowindow.close();
            });
            infowindow.open(map, marker);
        }
    }
}







// '새 점포 등록' 버튼 클릭 시
function insertStoreHandler() {
	
	// 회원이라면 새 점포 등록 버튼 이용 가능
	if(currentId !== null) {
		

	    //마커 생성
	    var marker = new naver.maps.Marker({
	        position: new naver.maps.LatLng(37.3595894, 127.105399),
	        map: map,
	    });
	
	    var marker; // 클릭 이벤트로 생성한 마커를 저장할 변수
	    var infowindow; // 인포윈도우 컨텐츠를 저장할 변수
	    var prevClickCoord; // 이전 클릭한 위치를 저장할 변수
	    var clickEventListener; // 클릭 이벤트 리스너
	
	    // 클릭 이벤트 핸들러
	    function handleMapClick(e) {
	        if (marker) {
	            marker.setMap(null); // 이전 마커 삭제
	            if (infowindow) {
	                infowindow.close(); // 이전 인포윈도우 닫기
	            }
	        }
	        marker = new naver.maps.Marker({
	            position: e.coord,
	            map: map
	        });
	        prevClickCoord = e.coord;
	
	        // 마커를 클릭했을 때 인포윈도우를 생성하고 표시(위도, 경도 값 a태그 파라미터로 넣어주기)
	        var latitude = e.coord.lat();
	        var longitude = e.coord.lng();
	        var iwContent = '<div class="iwContent" style="padding:5px;">' +
	            '<a href="../ajaxController/toAjaxController.jsp?command=insertStore&slat=' + latitude + '&slng=' + longitude + '" target="_self"><div class="up"><i class="bi bi-shop"></i></div><div class="down">등록하기</div></a></div>';
	        infowindow = new naver.maps.InfoWindow({
	            content: iwContent
	        });
	        infowindow.open(map, marker);
	    }
	
	    // 마우스 우클릭 이벤트 처리
	    naver.maps.Event.addListener(map, 'rightclick', function (e) {
	        if (clickEventListener) {
	            // 클릭 이벤트 리스너가 존재하면 삭제
	            naver.maps.Event.removeListener(clickEventListener);
	            clickEventListener = null;
	        }
	        if (marker) {
	            marker.setMap(null); // 클릭 이벤트로 생성한 마커 삭제
	            if (infowindow) {
	                infowindow.close(); // 인포윈도우 닫기
	            }
	            marker = null;
	        }
	    });
	
	    // 클릭 이벤트 리스너 등록
	    clickEventListener = naver.maps.Event.addListener(map, 'click', handleMapClick);
	
	
	    
    } 
    // 비회원이라면 새 점포 등록 버튼 이용 못하고 로그인 페이지로 리디렉션
    else {
		alert('로그인 하시면 새 점포 등록이 가능합니다!');
		window.location.href = '/finalProject/views/login';
	}
}









function storeAjaxHandler() {
    if (xhr.readyState === 4 && xhr.status === 200) {
        // 기존 마커들을 모두 제거
        removeMarker();

        const allStoreList = JSON.parse(xhr.responseText);


        let storeContents ='';
        
        
        if (allStoreList.length === 0) {
            storeContents = '점포 정보가 없습니다!';
        } 
        
        
		for(let i=0; i < allStoreList.length; i++) {
			storeContents += '<div class="mkcontainer row">' +
'<div id="' + allStoreList[i].sno + '" class="personalScontent">' +
    '<p>'+
    '점포명: ' + allStoreList[i].sname +
    '</p>' +
    '<p>취급품목: ' + allStoreList[i].scategory + '</p>' +
    '<p>점포형태: ' +  allStoreList[i].stype + '</p>' +
    '<img src="../images/2b50.png" alt="평균별점">' + allStoreList[i].savgrating + '(' + allStoreList[i].sreviewcount + ')' +
    ' <i class="fa-solid fa-heart"></i>: ' + allStoreList[i].sfavoritecount +
    '<div class="imgContainer">' +
    '<img src="' + allStoreList[i].sphoto  + '">' +
    '</div>'+
'</div>'+
'</div>';

		}
		
		document.querySelector('#storeContent').innerHTML = storeContents;





        for (let i in allStoreList) {
			const savgrating = parseFloat(allStoreList[i].savgrating);
			const sreviewcount = parseFloat(allStoreList[i].sreviewcount);
            const sno = parseFloat(allStoreList[i].sno);
            const sname = allStoreList[i].sname;
            const slat = parseFloat(allStoreList[i].slat);
            const slng = parseFloat(allStoreList[i].slng);
            const stype = allStoreList[i].stype;
            const sphoto = allStoreList[i].sphoto;
            const sfavoritecount = parseFloat(allStoreList[i].sfavoritecount);
            const scategory = allStoreList[i].scategory;
            const nickname = allStoreList[i].nickname;

            const slocation = {
				savgrating: savgrating,
				sreviewcount: sreviewcount,
                sno: sno,
                sname: sname,
                slat: slat,
                slng: slng,
                stype: stype,
                sphoto: sphoto,
                sfavoritecount: sfavoritecount,
                scategory: scategory,
                nickname: nickname
            };

            locations.push(slocation);
        }
        
        // 마커를 다시 생성하고 표시
        showMarkers();
    }
}









// GPS 기능 구현
{
    let latitude;
    let longitude;

    // 현재 나의 위치에 GPS전용 마커 생성
    const gpsMarker = new naver.maps.Marker({
        position: new naver.maps.LatLng(latitude, longitude),
        map: map,
        icon: {
            content: '<div style="background-color: red; width: 10px; height: 10px; border-radius: 50%;"></div>',
            anchor: new naver.maps.Point(15, 15)
        }
    });

    // GPS 위치 업데이트 함수
    function updateLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(success, error);
        }

        function success(position) {
            latitude = position.coords.latitude;
            longitude = position.coords.longitude;
            const newLatLng = new naver.maps.LatLng(latitude, longitude);
            gpsMarker.setPosition(newLatLng);
        }

        function error() {
            // 에러 처리
        }
    }

    // 일정 주기로 GPS 위치 업데이트
    setInterval(updateLocation, 2000); // 2초마다 업데이트
}





// 지도 위에 마커를 표시하는 함수
function showMarkers() {
	
    for (var i = 0; i < locations.length; i++) {
        var marker = new naver.maps.Marker({
            map: map,
            position: new naver.maps.LatLng(locations[i].slat, locations[i].slng)
        });

        var infowindow = new naver.maps.InfoWindow({	// 상세페이지로, 등록(수정)페이지로 이동하는 a태그는 해당 페이지들을 제어하는 컨트롤러로 보내기


            content: '<div class="infoContent"><div id="'+ locations[i].sno +'" class="personalInfowindowScontent"><h4>점포명: ' + locations[i].sname + '</h4>' +
                   '<p>취급품목: ' + locations[i].scategory + '</p>' +
                   '<p>점포형태: ' +  locations[i].stype + '</p>' +
                   '<div class="countContainer">' +
                   '<img src="../images/2b50.png" alt="평균별점">' + locations[i].savgrating + '(' + locations[i].sreviewcount + ')' +
                   '<i class="fa-solid fa-heart"></i>: ' +  locations[i].sfavoritecount +
                   '</div>' +
                   '<div class="imgContainer">' +
                   '<img src="' + locations[i].sphoto  + '">' +
                   '</div></div>' +
                   '<div class="btnContainer">' +
                   '<a href="/finalProject/views/storeDetail?sno=' + locations[i].sno  + '">점포 상세</a>' +
                   '<a href="/finalProject/views/storeUpdate?sno=' +locations[i].sno  + '">점포 수정</a>' +
                   '</div></div>'
        });

        (function (marker, infowindow) {
		    naver.maps.Event.addListener(marker, "click", function (e) {
		        infowindow.open(map, marker);
		    });

            naver.maps.Event.addListener(map, "click", function (mouseEvent) {
                infowindow.close();
            });
        })(marker, infowindow);

        markers.push(marker);
    }
}





// 지도 위에 표시되고 있는 마커를 모두 제거하는 함수
function removeMarker() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
}

window.addEventListener('load', init);