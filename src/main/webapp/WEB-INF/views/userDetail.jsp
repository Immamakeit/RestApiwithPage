<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detail</title>
</head>
<body>
    <h2>사용자 상세 정보</h2>
    <table border="1">
        <tr>
            <th>이름</th>
            <td><c:out value="${user.name}" /></td>
        </tr>
        <tr>
            <th>닉네임</th>
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

    <a href="/user/update">수정</a>
    <br>
    <a href="/user/delete">삭제</a>
</body>
</html>