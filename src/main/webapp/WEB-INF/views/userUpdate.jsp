<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<%@ include file="/WEB-INF/include/header.jsp" %>
<link rel="stylesheet" href="/css/userUpdate.css">
<script src="/js/userUpdate.js"></script>
<script>
   $(document).ready(function() {
       const originalEmail = $("#email").val();
       const token = $("input[name='_csrf']").val(); // CSRF 토큰 값 추출
       const header = "X-CSRF-TOKEN"; // CSRF 헤더 이름

       $("#updateBtn").click(function(event) {
           event.preventDefault();
           var userData = gatherUserData();

           if (userData.email !== originalEmail) {
               checkDuplicateEmail(userData.email, function() {
                   checkPassword(userData);
               });
           } else {
               checkPassword(userData);
           }
       });

   });
</script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <form id="updateForm">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input type="hidden" name="id" id="id" value="${user.id}"/>
                <input type="hidden" name="username" id="username" value="${user.username}"/>
                <div class="form-group">
                    <label for="name">이름:</label>
                    <input type="text" name="name" id="name" value="${user.name}" class="form-control">
                </div>
                <div class="form-group">
                    <label for="email">메일:</label>
                    <input type="text" name="email" id="email" value="${user.email}" placeholder="ex) example@iotree.com" class="form-control">
                </div>
                <div class="form-group">
                    <label for="address">주소:</label>
                    <input type="text" name="address" id="address" value="${user.address}" class="form-control">
                </div>
                <div class="form-group">
                    <label for="phone">휴대폰:</label>
                    <input type="text" name="phone" id="phone" value="${user.phone}" placeholder="ex) 010-1234-5678" class="form-control">
                </div>
                <div class="form-group">
                    <label for="website">웹사이트:</label>
                    <input type="text" name="website" id="website" value="${user.website}" class="form-control">
                </div>
                <div class="form-group">
                    <label for="company">회사:</label>
                    <input type="text" name="company" id="company" value="${user.company}" class="form-control">
                </div>
                <div class="form-group">
                    <label for="password">비밀번호:</label>
                    <input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요!" class="form-control" required>
                </div>
                <button id="updateBtn" class="btn btn-primary">수정</button>
            </form>
        </div>
    </div>
</body>
</html>
