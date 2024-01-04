<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
           alert('존재하지 않는 유저 또는 비밀번호 입니다.');

           const urlWithoutParams = window.location.protocol + "//" + window.location.host + window.location.pathname;
           window.history.pushState({path: urlWithoutParams}, '', urlWithoutParams);
       }
    });
</script>
</head>
<body>
   <form method="post" action="/login">
    <input type="text" name="username" id="username"/><br>
    <input type="password" name="password" id="password"/><br>
    <button>로그인</button>
   </form>
</body>
</html>