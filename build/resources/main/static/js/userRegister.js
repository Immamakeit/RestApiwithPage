function userRegister(userData) {
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
}