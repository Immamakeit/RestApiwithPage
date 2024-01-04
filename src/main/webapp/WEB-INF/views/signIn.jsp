<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
        width: 300px;
        margin: auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 10px;
    }
    input, button {
        width: 100%;
        margin-bottom: 10px;
    }
</style>
<script>
    $(document).ready(function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            Swal.fire({
                icon: 'error',
                title: '오류',
                text: '존재하지 않는 유저 또는 비밀번호 입니다.',
                confirmButtonText: '확인'
            });
            const urlWithoutParams = window.location.protocol + "//" + window.location.host + window.location.pathname;
            window.history.pushState({path: urlWithoutParams}, '', urlWithoutParams);
        }
    });
</script>
</head>
<body>
   <form method="post" action="/login" class="bg-dark p-4 rounded">
    <h3 class="mb-3" style="color: gray;">로그인</h3>
    <input type="text" name="username" id="username" class="form-control" placeholder="사용자 이름"/><br>
    <input type="password" name="password" id="password" class="form-control" placeholder="비밀번호"/><br>
    <button class="btn btn-primary">로그인</button>
   </form>
</body>
</html>
