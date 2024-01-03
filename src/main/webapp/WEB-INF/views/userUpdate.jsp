<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $("#updateBtn").click(function() {
                event.preventDefault();

                var userData = {
                    name: $("#name").val(),
                    username: $("#username").val(),
                    password: $("#password").val(),
                    email: $("#email").val(),
                    address: $("#address").val(),
                    phone: $("#phone").val(),
                    website: $("#website").val(),
                    company: $("#company").val()
                };
                    checkPasswordAndUpdate(userData);
            });
        });

        function checkPasswordAndUpdate(userData) {
            $.ajax({
                url: '/api/user/check/password',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({username: userData.username, password: userData.password}),
                success: function(response) {
                    switch(response.code) {
                            case 0:
                                updateUser(userData);
                                break;
                            case -3:
                                alert(response.message);
                                window.location.reload();
                                break;
                            default:
                                alert("오류 발생: " + response.message);
                                window.location.reload();
                        }
                },
                error: function(xhr, status, error) {
                    alert("비밀번호 검증 실패: " + xhr.responseText);
                }
            });
        }

        function updateUser(userData) {
            $.ajax({
                url: '/api/user/update',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(userData),
                success: function(response) {
                    switch(response.code) {
                       case 0:
                           alert("수정 성공");
                           window.location.href = "/user/detail";
                           break;
                       case -2:
                           alert(response.message);
                           window.location.reload();
                           break;
                       default:
                           alert("오류 발생: " + response.message);
                           window.location.reload();
                   }
                },
                error: function(xhr, status, error) {
                    alert("등록 실패: " + xhr.responseText);
                }
            });
        }

    </script>
</head>
<body>
 <form id="updateForm">
        이름 : <input type="text" name="name" id="name" value="${user.name}">
        <br><br>
        닉네임 : <input type="text" name="username" id="username" value="${user.username}">
        <br><br>
        메일 : <input type="text" name="email" id="email" value="${user.email}" placeholder="ex) example@iotree.com">
        <br><br>
        주소 : <input type="text" name="address" id="address" value="${user.address}">
        <br><br>
        휴대폰 : <input type="text" name="phone" id="phone" value="${user.phone}" id="userPhone" placeholder="ex) 010-1234-5678">
        <br><br>
        웹사이트 : <input type="text" name="website" id="website" value="${user.website}">
        <br><br>
        회사 : <input type="text" name="company" id="company" value="${user.company}">
        <br><br>
        비밀번호 : <input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요!" required />
        <br><br>
        <button type="button" id="updateBtn">수정</button>
   </form>
</body>
</html>