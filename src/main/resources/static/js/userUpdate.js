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

function checkPassword(userData) {
    $.ajax({
        url: '/api/check/password',
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