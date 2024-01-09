<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저상세</title>
<%@ include file="/WEB-INF/include/header.jsp" %>
<link rel="stylesheet" href="/css/userDetail.css">
<script>
    $(document).ready(function() {
        $("#logoutBtn").click(function() {
            event.preventDefault();

            Swal.fire({
                title: '로그아웃',
                text: '정말 로그아웃 하시겠습니까?',
                icon: 'question',
                showCancelButton: true,
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then(function(result) {
                if (result.isConfirmed) {
                    logoutForm.submit();
                }
            });
        });
    });
</script>
</head>
<body class="bg-light">
    <div class="logout-container">
        <form id="logoutForm" action="/logout" method="POST">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <button type="button" id="logoutBtn" class="btn btn-secondary">로그아웃</button>
        </form>
    </div>
    <div class="container mt-5">
        <h2 class="text-center user-info-title">사용자 상세 정보</h2>
        <table class="table table-bordered">
            <tr>
                <th>이름</th>
                <td><c:out value="${user.name}" /></td>
            </tr>
            <tr>
                <th>유저네임</th>
                <td><c:out value="${user.username}" /></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><c:out value="${user.email}" /></td>
            </tr>
            <tr>
                <th>주소</th>
                <td><c:out value="${user.address}" /></td>
            </tr>
            <tr>
                <th>휴대폰</th>
                <td><c:out value="${user.phone}" /></td>
            </tr>
            <tr>
                <th>웹사이트</th>
                <td><c:out value="${user.website}" /></td>
            </tr>
            <tr>
                <th>회사</th>
                <td><c:out value="${user.company}" /></td>
            </tr>
        </table>

        <a href="/user/update" class="btn btn-primary">수정</a>
        <a href="/user/delete" class="btn btn-danger">탈퇴</a>
    </div>
</body>
</html>
