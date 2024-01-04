<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="icon" href="/images/polarbear.ico" type="image/x-icon">
<style>
    body {
        background-color: #f5f5f5;
        color: #333;
        text-align: center;
        padding-top: 10%;
    }
    form {
        width: 400px;
        margin: auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
    }
    input, button {
        width: 100%;
        margin-bottom: 10px;
    }
    table {
        width: 100%;
    }
    th {
        text-align: left;
    }
    th, td {
        padding: 10px;
    }
</style>
<script>
    $(document).ready(function() {
        $("#registerBtn").click(function() {
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

            $.ajax({
                url: '/api/user/register',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(userData),
                success: function(response) {
                    switch(response.code) {
                       case 0:
                           Swal.fire({
                                icon: 'success',
                                title: '등록 성공',
                                text: '로그인 해주세요!',
                                confirmButtonText: '확인'
                            }).then(function() {
                                window.location.href = "/signin";
                            });
                           break;
                       case -2:
                           Swal.fire({
                                icon: 'warning',
                                title: '경고',
                                text: '유저네임과 이메일은 중복 되거나 빈 칸 일 수 없습니다.',
                                confirmButtonText: '확인'
                            }).then(function() {
                                window.location.reload();
                            });
                           break;
                       default:
                           Swal.fire({
                                icon: 'error',
                                title: '에러',
                                text: '에러 발생: ' + response.message,
                                confirmButtonText: '확인'
                            }).then(function() {
                                window.location.reload();
                            });
                   }
                },
                error: function(xhr, status, error) {
                    Swal.fire({
                        icon: 'error',
                        title: '등록 실패',
                        text: '등록 실패: ' + xhr.responseText,
                        confirmButtonText: '확인'
                    });
                }
            });
        });
    });
</script>
</head>
<body>
   <form id="registerForm">
                <div>
                    <table>
                        <tr>
                            <th>이름</th>
                            <td><input type="text" name="name" id="name" class="form-control"/></td>
                        </tr>
                        <tr>
                            <th>유저네임</th>
                            <td><input type="text" name="username" id="username" class="form-control" placeholder="추후에 변경하실 수 없습니다." required/></td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td><input type="password" name="password" id="password" class="form-control" required/></td>
                        </tr>
                        <tr>
                            <th>메일</th>
                            <td><input type="text" name="email" id="email" class="form-control" placeholder="ex) example@iotree.com" required/></td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td><input type="text" name="address" id="address" class="form-control"/></td>
                        </tr>
                        <tr>
                            <th>휴대폰</th>
                            <td>
                                <input type="text" name="phone" id="phone" class="form-control" placeholder="ex) 010-1234-5678"/>
                            </td>
                        </tr>
                        <tr>
                            <th>웹사이트</th>
                            <td><input type="text" name="website" id="website" class="form-control"/></td>
                        </tr>
                        <tr>
                            <th>회사</th>
                            <td><input type="text" name="company" id="company" class="form-control"/></td>
                        </tr>
                    </table>
                    <button id="registerBtn" class="btn btn-primary">등록</button>
                </div>
            </form>
</body>
</html>
