<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록</title>
<%@ include file="/WEB-INF/include/header.jsp" %>
<link rel="stylesheet" href="/css/signup.css">
<script src="/js/userRegister.js"></script>
<script>
    $(document).ready(function() {
        $("#registerBtn").click(function() {
            event.preventDefault();

            var password = $("#password").val();
            var confirmPassword = $("#confirmPassword").val();

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
                name: $("#name").val(),
                username: $("#username").val(),
                password: $("#password").val(),
                email: $("#email").val(),
                address: $("#address").val(),
                phone: $("#phone").val(),
                website: $("#website").val(),
                company: $("#company").val()
            };
            userRegister(userData);
        });
    });
</script>
</head>
<body>
   <form id="registerForm">
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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
                                <th>비밀번호 확인</th>
                                <td><input type="password" name="confirmPassword" id="confirmPassword" placeholder="한번 더 입력하세요!" class="form-control" /></td>
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
