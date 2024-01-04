<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    body {
        background-color: #f5f5f5;
        color: #333;
        text-align: center;
        padding-top: 5%;
    }
    .form-container {
        width: 400px;
        margin: 0 auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
    }
    .form-container input[type="text"],
    .form-container input[type="password"] {
        width: 100%;
        margin-bottom: 10px;
    }
    .form-container button {
        width: 100%;
    }
    .error-message {
        color: red;
        margin-top: 10px;
    }
    .form-group label {
        text-align: left;
        display: block;
    }
</style>
<script>
    $(document).ready(function() {
        $("#updateBtn").click(function() {
            event.preventDefault();

            var userData = {
                id: $("#id").val(),
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
                        case -1:
                            alert("수정 하고자 하는 유저가 존재하지 않습니다.");
                            window.location.reload();
                            break;
                        case -2:
                            alert("유저네임과 이메일은 중복 되거나 빈 칸 일 수 없습니다.");
                            window.location.reload();
                            break;
                        case -3:
                            alert("비밀번호가 일치하지 않습니다. 비밀번호를 다시 입력해주세요");
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
                       alert("수정 중 오류 발생: " + response.message);
                       window.location.reload();
               }
            },
            error: function(xhr, status, error) {
                alert("수정 실패: " + xhr.responseText);
            }
        });
    }
</script>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <form id="updateForm">
                <input type="hidden" name="id" id="id" value="${user.id}"/>
                <div class="form-group">
                    <label for="name">이름:</label>
                    <input type="text" name="name" id="name" value="${user.name}" class="form-control">
                </div>
                <div class="form-group">
                    <label for="username">닉네임:</label>
                    <input type="text" name="username" id="username" value="${user.username}" class="form-control">
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
                <button type="button" id="updateBtn" class="btn btn-primary">수정</button>
                <div class="error-message" id="error-message"></div>
            </form>
        </div>
    </div>
</body>
</html>
