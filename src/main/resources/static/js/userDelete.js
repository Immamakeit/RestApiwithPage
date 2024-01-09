
   function deleteUserData() {
      return {
          id: $("#id").val(),
          username: $("#username").val(),
          password: $("#password").val(),
      };
   }

  function checkPassword(userData) {
       $.ajax({
           url: '/api/check/password',
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