<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="icon" href="/images/polarbear.ico" type="image/x-icon">
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
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .form-container input[type="text"],
    .form-container input[type="password"] {
        width: 100%;
        margin-bottom: 15px;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .form-container button {
        width: 100%;
        padding: 10px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    .form-group label {
        text-align: left;
        display: block;
        font-weight: bold;
    }
</style>
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
                   checkPasswordAndUpdate(userData);
               });
           } else {
               checkPasswordAndUpdate(userData);
           }
       });

   });

    function gatherUserData() {
       return {
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
    }

    function checkDuplicateEmail(email, callback) {
           $.ajax({
               url: '/api/check/duplicate/email',
               type: 'POST',
               contentType: 'application/json',
               data: JSON.stringify({ email: email }),
               success: function(response) {
                    switch(response.code) {
                       case 0:
                           callback();
                           break;
                       case -2:
                           Swal.fire({
                               icon: 'warning',
                               title: '이메일 중복',
                               text: '이미 사용중인 이메일 입니다.'
                           });
                           break;
                       default:
                           console.error("중복 이메일 검사 중 오류 발생:");
                   }
               },
               error: function(xhr, status, error) {
                   console.error("중복 이메일 검사 오류:", error);
               }
           });
    }

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
                        Swal.fire({
                            icon: 'warning',
                            title: '유저 식별 불가능',
                            text: '수정 하고자 하는 유저가 존재하지 않습니다.'
                        }).then(function() {
                            window.location.reload();
                        });
                        break;
                    case -2:
                        Swal.fire({
                            icon: 'warning',
                            title: '수정 오류',
                            text: '유저네임과 이메일은 중복 되거나 빈 칸 일 수 없습니다.'
                        }).then(function() {
                            window.location.reload();
                        });
                        break;
                    case -3:
                        Swal.fire({
                            icon: 'warning',
                            title: '비밀번호 불일치',
                            text: '비밀번호를 다시 입력해주세요.'
                        }).then(function() {
                            window.location.reload();
                        });
                        break;
                    default:
                        Swal.fire({
                            icon: 'error',
                            title: '수정 오류',
                            text: '오류 발생: ' + response.message
                        }).then(function() {
                            window.location.reload();
                        });
                }
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: '수정 오류',
                    text: '비밀번호 검증 중 에러'
                });
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
                        Swal.fire({
                            icon: 'success',
                            title: '수정 성공',
                            text: '수정이 성공적으로 완료되었습니다.'
                        }).then(function() {
                            window.location.href = "/user/detail";
                        });
                        break;
                    case -2:
                        Swal.fire({
                            icon: 'warning',
                            title: '수정 오류',
                            text: "유저이름과 이메일은 중복될 수 없습니다."
                        }).then(function() {
                            window.location.reload();
                        });
                        break;
                    default:
                        Swal.fire({
                            icon: 'error',
                            title: '수정 오류',
                            text: '수정 중 오류 발생: ' + response.message
                        }).then(function() {
                            window.location.reload();
                        });
                }
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    icon: 'error',
                    title: '수정 오류',
                    text: '수정 실패'
                });
            }
        });
    }
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
