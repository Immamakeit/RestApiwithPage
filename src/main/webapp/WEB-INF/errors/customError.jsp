<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>에러페이지</title>
    <script>
        window.onload = function() {
            setTimeout(function() {
                window.location.href = "/";
            }, 5000);
        };
    </script>
</head>
<body>
    <h1>불편을 드려 죄송합니다.</h1>
    <p>관리자에게 문의해주세요. 이 페이지는 곧 메인 페이지로 이동합니다.</p>
    <a href="/">바로 이동하기</a>
</body>
</html>
