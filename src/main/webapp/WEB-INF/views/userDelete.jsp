<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#deleteBtn").click(function() {
            event.preventDefault();

            var password = $("#password").val();
            var confirmPassword = $("#confirmPassword").val();
            var isConfirmed = confirm("정말 탈퇴하시겠습니까?");

            if(password !== confirmPassword) {
                alert("비밀번호 확인란을 확인해주세요.");
                $("#password").val() = "";
                $("#confirmPassword").val() = "";
                return;
            }

            if(!isConfirmed) {
                return;
            }

            var userData = {
                id: $("#id").val(),
                username : $("#username").val(),
                password: $("#password").val(),
            };
            checkPasswordAndDelete(userData);
        });
    });

     function checkPasswordAndDelete(userData) {
                $.ajax({
                    url: '/api/user/check/password',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({username : userData.username, password : userData.password}),
                    success: function(response) {
                        switch(response.code) {
                                case 0:
                                    deleteUser(userData);
                                    break;
                                case -3:
                                    alert("비밀번호를 일치하지 않습니다. 비밀번호를 다시 입력해주세요");
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

            function deleteUser(userData) {
                $.ajax({
                    url: '/api/user/delete',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({id : userData.id}),
                    success: function(response) {
                        switch(response.code) {
                           case 0:
                               alert("삭제 성공");
                               window.location.href = "/";
                               break;
                           case -1:
                               alert("삭제 하고자 하는 유저가 존재하지 않습니다.");
                               window.location.reload();
                               break;
                           default:
                               alert("삭제 중 오류 발생: " + response.message);
                               window.location.reload();
                       }
                    },
                    error: function(xhr, status, error) {
                        alert("삭제 실패: " + xhr.responseText);
                    }
                });
            }
</script>
</head>
<body>
    <form id="deleteForm">
         <input type="hidden" name="id" id="id" value="${user.id}" />
         <input type="hidden" name="username" id="username" value="${user.username}" />
         비밀번호 : <input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요!" />
         <br><br>
         비밀번호 확인: <input type="password" name="confirmPassword" id="confirmPassword" placeholder="비밀번호를 한번 더 입력하세요!" />
         <br><br>
         <button type="button" id="deleteBtn">삭제</button>
    </form>
</body>
</html>