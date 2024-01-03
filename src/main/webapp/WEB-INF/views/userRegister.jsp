<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
                               alert("등록 성공, 로그인 해주세요!");
                               window.location.href = "/user/login";
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
            });
        });
    </script>
</head>
<body>
     <form id="registerForm">
                <div>
                    <table border="1">
                        <tr>
                            <th>이름</th>
                            <td><input type="text" name="name" id="name"/></td>
                        </tr>
                        <tr>
                            <th>닉네임</th>
                            <td><input type="text" name="username" id="username" required/></td>
                        </tr>
                        <tr>
                            <th>비밀번호</th>
                            <td><input type="password" name="password" id="password" required/></td>
                        </tr>
                        <tr>
                            <th>메일</th>
                            <td><input type="text" name="email" id="email" placeholder="ex) example@iotree.com" required/></td>
                        </tr>
                         <tr>
                            <th>주소</th>
                            <td><input type="text" name="address" id="address" /></td>
                        </tr>
                        <tr>
                            <th>휴대폰</th>
                            <td>
                                <input type="text" name="phone" id="phone" placeholder="ex) 010-1234-5678"/>
                            </td>
                        </tr>
                         <tr>
                            <th>웹사이트</th>
                            <td><input type="text" name="website" id="website"/></td>
                        </tr>
                        <tr>
                            <th>회사</th>
                            <td><input type="text" name="company" id="company"/></td>
                        </tr>
                    </table>
                    <button type="button" id="registerBtn">등록</button>
                </div>
            </form>
</body>
</html>