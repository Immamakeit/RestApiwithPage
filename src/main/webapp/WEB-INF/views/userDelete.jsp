<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴</title>
<%@ include file="/WEB-INF/include/header.jsp" %>
<link rel="stylesheet" href="/css/userDelete.css">
<script src="/js/userDelete.js"></script>
<script>
       $(document).ready(function() {
           $("#deleteBtn").click(function(event) {
               event.preventDefault();

               var password = $("#password").val();
               var userData = deleteUserData();

               Swal.fire({
                   title: '정말 탈퇴하시겠습니까?',
                   text: '탈퇴한 계정은 복구할 수 없습니다.',
                   icon: 'warning',
                   showCancelButton: true,
                   confirmButtonText: '예',
                   cancelButtonText: '아니오'
               }).then((result) => {
                   if (result.isConfirmed) {
                       checkPassword(userData);
                   }
               });
           });
       });
</script>
</head>
<body>
    <div class="col-md-6">
        <form id="deleteForm">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <input type="hidden" name="id" id="id" value="${user.id}" />
            <input type="hidden" name="username" id="username" value="${user.username}" />
            <div class="form-group">
                <label for="password">비밀번호:</label>
                <input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요!" class="form-control" />
            </div>
            <div class="form-group text-center">
                <button id="deleteBtn" class="btn btn-danger">탈퇴</button>
            </div>
        </form>
    </div>
</body>
</html>
