<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="jakarta.tags.core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors" />
    <meta name="generator" content="Hugo 0.101.0" />
    <title>CozyHouse</title>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.2/examples/pricing/" />
    <link href="${root}/css/bootstrap.min.css" rel="stylesheet" />
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5cf74bfffafe691f545e91665afcc8c2&libraries=services"
    ></script>

    <script>
      <c:if test="${!empty msg}">alert("${msg}");</c:if>;
    </script>

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, 0.1);
        border: solid rgba(0, 0, 0, 0.15);
        border-width: 1px 0;
        box-shadow: inset 0 0.5em 1.5em rgba(0, 0, 0, 0.1),
          inset 0 0.125em 0.5em rgba(0, 0, 0, 0.15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -0.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
    </style>
    <!-- Custom styles for this template -->
    <link href="./css/pricing.css" rel="stylesheet" />
  </head>
  <body>
    <div class="container py-3">
      <header>
        <!-- 상단 네비게이션 바 -->
        <div class="d-flex flex-column flex-md-row align-items-center pb-3 mb-4 border-bottom">
          <span class="fs-4"
            ><a href="${root}/index.jsp" class="text-decoration-none">CozyHouse</a></span
          >
          <nav class="d-inline-flex mt-2 mt-md-0 ms-md-auto">
            <c:if test="${empty sessionScope.loginInfo}">
              <a
                class="me-3 py-2 text-dark text-decoration-none"
                href="${root}/user?act=loginForm"
              >
                [로그인]
              </a>
              <a class="me-3 py-2 text-dark text-decoration-none" href="${root }/user?act=joinForm">
                [회원가입]
              </a>
            </c:if>

            <c:if test="${not empty sessionScope.loginInfo }">
              <b style="margin-right: 10px; margin-top: 7px">${loginInfo.name}님 반갑습니당^_^ </b>
              <a class="me-3 py-2 text-dark text-decoration-none" href="${root}/board?action=list">
                [공지 사항]
              </a>
              <a
                class="me-3 py-2 text-dark text-decoration-none"
                href="${root }/user?act=mypage&userId="
                ${loginInfo.id}
              >
                [마이페이지]
              </a>
              <a class="me-3 py-2 text-dark text-decoration-none" href="${root }/user?act=logout">
                [로그아웃]
              </a>
            </c:if>
          </nav>
        </div>

        <!-- 상단 메인 -->
        <div class="pricing-header p-3 pb-md-4 mx-auto text-center">
          <h5 class="display-6 fw-normal">전국 아파트 실거래 정보 검색서비스</h5>
          <p class="fs-6 text-muted">
            동별, 아파트별 거래 가격을 확인해보세요.<br />키워드 검색을 통해 주변의 인프라 시설도
            검색해보세요 !!
          </p>
          <p class="fs-6 text-muted"></p>
        </div>
      </header>
    </div>
  </body>
</html>
