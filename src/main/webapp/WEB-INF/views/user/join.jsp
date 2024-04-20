<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<%@include file="/WEB-INF/views/common/header.jsp"%>
<h3>회원 가입</h3>

<form 
    id="joinForm" 
    action="${root}/user?act=join" 
    method="post"
    onsubmit="return validateForm()">
    <input 
        type="hidden" 
        name="act" 
        value="join">
    <br>
    <b>ID</b>
    <input 
        class="form-control" 
        type="text" 
        name="userid"
        id="userid"
        oninput="validateUserId()">
    <div id="useridError" class="invalid-feedback">
        숫자와 영어 소문자로 5자리 이상 20자리 이하여야 합니다.
    </div>
    <br>
    <div class="d-flex align-items-center">
        <b class="me-2">PW</b>
        <div class="form-check d-flex align-items-center">
            <input 
                type="checkbox" 
                class="form-check-input" 
                id="showPasswordCheckbox" 
                onclick="togglePasswordVisibility()" />
            <label class="form-check-label" for="showPasswordCheckbox">비밀번호 보이기</label>
        </div>
    </div>
    <input 
        class="form-control" 
        type="password" 
        name="userpw" 
        id="userpw"
        oninput="validatePassword()">
    <div id="passwordError" class="invalid-feedback">
        숫자와 영어 소문자로 5자리 이상 20자리 이하여야 합니다.
    </div>
    <br>
    <br>
    <b>NAME</b>
    <input 
        class="form-control" 
        type="text"
        name="username"
        id="username"
        oninput="validateUsername()">
    <div id="usernameError" class="invalid-feedback">한글만 입력 가능합니다.</div>
    <br>
    <b>ADDRESS</b>
    <br>
    <div class="d-flex ">
        <input 
            type="text" 
            class="form-control" 
            id="sample4_postcode"
            placeholder="우편번호"
            readonly>
        <input type="button"
            class="form-control list-group-item-primary"
            onclick="sample4_execDaumPostcode()" 
            value="우편번호 찾기">
    </div>
    <div id="addressError" class="invalid-feedback">
        우편번호를 입력해주세요
    </div>
    <br>
    <input 
        type="text" 
        class="form-control"
        id="sample4_roadAddress" 
        placeholder="도로명주소" 
        name="address" 
        readonly>        
    <input 
        type="text" 
        class="form-control" 
        id="sample4_jibunAddress"
        placeholder="지번주소" 
        readonly>
    <input 
        class="form-control list-group-item-warning mt-3" 
        type="submit"
        value="JOIN">
</form>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    function togglePasswordVisibility() {
        var passwordInput = document.getElementById("userpw");
        var checkbox = document.getElementById("showPasswordCheckbox");

        if (checkbox.checked) {
            passwordInput.type = "text";
        } else {
            passwordInput.type = "password";
        }
    }

    // 도로명 주소 찾기 팝업창 열고 값 삽입
    function sample4_execDaumPostcode() {
        new daum.Postcode(
                {
                    oncomplete : function(data) {
                        var roadAddr = data.roadAddress;
                        var extraRoadAddr = '';

                        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                            extraRoadAddr += data.bname;
                        }
                        if (data.buildingName !== '' && data.apartment === 'Y') {
                            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }

                        document.getElementById('sample4_postcode').value = data.zonecode;
                        document.getElementById("sample4_roadAddress").value = roadAddr;
                        document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

                        var guideTextBox = document.getElementById("guide");
                        if (data.autoRoadAddress) {
                            var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                            document.getElementById("sample4_roadAddress").value = expRoadAddr;
                        } else if (data.autoJibunAddress) {
                            var expJibunAddr = data.autoJibunAddress;
                            document.getElementById("sample4_jibunAddress").value = expJibunAddr;
                        }
                    }
                }).open({
            autoClose : true
        });
    }

    // 아이디 유효성 검사
    function validateUserId() {
        var userid = document.getElementById("userid").value;
        var useridError = document.getElementById("useridError");
        
        if (!/^[a-z0-9]{5,20}$/.test(userid)) {
            useridError.style.display = 'block';
        } else {
            useridError.style.display = 'none';
        }
    }

    // 비밀번호 유효성 검사
    function validatePassword() {
        var userpw = document.getElementById("userpw").value;
        var passwordError = document.getElementById("passwordError");
        
        if (!/^[a-z0-9]{5,20}$/.test(userpw)) {
            passwordError.style.display = 'block';
        } else {
            passwordError.style.display = 'none';
        }
    }

    // 이름 유효성 검사
    function validateUsername() {
        var username = document.getElementById("username").value;
        var usernameError = document.getElementById("usernameError");
        
        if (!/^[가-힣]+$/.test(username)) {
            usernameError.style.display = 'block';
        } else {
            usernameError.style.display = 'none';
        }
    }

    // 우편번호, 도로명주소, 지번주소 유효성 검사
    function validateAddress() {
        var postcode = document.getElementById("sample4_postcode").value;
        var roadAddress = document.getElementById("sample4_roadAddress").value;
        var jibunAddress = document.getElementById("sample4_jibunAddress").value;
        var addressError = document.getElementById("addressError");
        
        if (postcode === '' || roadAddress === '' || jibunAddress === '') {
            addressError.style.display = 'block';
        } else {
            addressError.style.display = 'none';
        }
    }

    // 폼 유효성 검사
    function validateForm() {
        validateUserId();
        validatePassword();
        validateUsername();
        validateAddress();

        // 폼 전체 유효성 검사
        if (document.querySelectorAll('.invalid-feedback[style="display: block;"]').length > 0) {
            return false; // 유효성 검사에 실패한 항목이 있으면 제출을 막음
        }
        return true;
    }
</script>
