<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>

    <form id="deleteForm">
         비밀번호 : <input type="password" name="password" placeholder="비밀번호를 입력하세요!" />
         <br><br>
         <button type="button" id="deleteBtn">삭제</button>
    </form>
</body>
</html>