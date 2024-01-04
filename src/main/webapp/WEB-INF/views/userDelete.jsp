<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>탈퇴</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<link rel="icon" href="/images/polarbear.ico" type="image/x-icon">
<style>
    body {
        background-color: #f5f5f5;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    .form-group label {
        font-size: 16px;
    }

    .form-control {
        width: 100%;
        padding: 15px;
        margin-bottom: 20px;
        font-size: 16px;
    }
</style>
<script>
    $(document).ready(function() {
        $("#deleteBtn").click(function() {
            event.preventDefault();

            var password = $("#password").val();
            var confirmPassword = $("#confirmPassword").val();

            Swal.fire({
                title: '정말 탈퇴하시겠습니까?',
                text: '탈퇴한 계정은 복구할 수 없습니다.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '예',
                cancelButtonText: '아니오'
            }).then((result) => {
                if (result.isConfirmed) {
                    if (password !== confirmPassword) {
                        Swal.fire({
                            icon: 'warning',
                            title: '비밀번호 / 비밀번호 확인 불일치',
                            text: '비밀번호 / 비밀번호 확인란을 확인해주세요.'
                        });
                        $("#password").val("");
                        $("#confirmPassword").val("");
                        return;
                    }

                    var userData = {
                        id: $("#id").val(),
                        username: $("#username").val(),
                        password: $("#password").val(),
                    };
                    checkPasswordAndDelete(userData);
                }
            });
        });
    });

    function checkPasswordAndDelete(userData) {
        $.ajax({
            url: '/api/user/check/password',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({username: userData.username, password: userData.password}),
            success: function (response) {
                switch (response.code) {
                    case 0:
                        deleteUser(userData);
                        break;
                    case -3:
                        Swal.fire({
                            icon: 'warning',
                            title: '비밀번호 불일치',
                            text: '비밀번호를 다시 입력해주세요.'
                        }).then(function () {
                            window.location.reload();
                        });
                        break;
                    default:
                        Swal.fire({
                            icon: 'error',
                            title: '탈퇴 오류',
                            text: '오류 발생: ' + response.message
                        }).then(function () {
                            window.location.reload();
                        });
                }
            },
            error: function (xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: '탈퇴 오류',
                    text: '비밀번호 검증 실패'
                });
            }
        });
    }

    function deleteUser(userData) {
        $.ajax({
            url: '/api/user/delete',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({id: userData.id}),
            success: function (response) {
                switch (response.code) {
                    case 0:
                        Swal.fire({
                            icon: 'success',
                            title: '탈퇴 확인',
                            text: '탈퇴가 완료되었습니다.'
                        }).then(function () {
                            window.location.href = "/";
                        });
                        break;
                    case -1:
                        Swal.fire({
                            icon: 'warning',
                            title: '탈퇴 오류',
                            text: '탈퇴 하고자 하는 유저가 존재하지 않습니다.'
                        }).then(function () {
                            window.location.reload();
                        });
                        break;
                    default:
                        Swal.fire({
                            icon: 'error',
                            title: '탈퇴 오류',
                            text: '탈퇴 중 오류 발생: ' + response.message
                        }).then(function () {
                            window.location.reload();
                        });
                }
            },
            error: function (xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: '탈퇴 오류',
                    text: '탈퇴 실패'
                });
            }
        });
    }
</script>
</head>
<body>
    <div class="col-md-6">
        <form id="deleteForm">
            <input type="hidden" name="id" id="id" value="${user.id}" />
            <input type="hidden" name="username" id="username" value="${user.username}" />
            <div class="form-group">
                <label for="password">비밀번호:</label>
                <input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요!" class="form-control" />
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인:</label>
                <input type="password" name="confirmPassword" id="confirmPassword" placeholder="비밀번호를 한번 더 입력하세요!" class="form-control" />
            </div>
            <div class="form-group text-center">
                <button id="deleteBtn" class="btn btn-danger">탈퇴</button>
            </div>
        </form>
    </div>
</body>
</html>
