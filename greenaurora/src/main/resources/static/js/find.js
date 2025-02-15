document.addEventListener('DOMContentLoaded', function() {
    // ID찾기
    document.getElementById('findIdForm').addEventListener('submit', function(e) {
        e.preventDefault();

		// Use more specific selectors to get the correct values
		const residentNumber1 = document.querySelector('.resident-number-container input[type="text"]').value;
		const residentNumber2 = document.querySelector('.resident-number-container input[type="password"]').value;
		const name = document.querySelector('#findIdForm input[name="memberName"]').value;
				
		if (!residentNumber1 || !residentNumber2 || !name) {
            alert('모든 필드를 입력해주세요.');
            return;
        }

        $.ajax({
            url: '/api/findId',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                memberNumber: residentNumber1 + residentNumber2,
                memberName: name
            }),
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content'));
            },
            success: function(data) {
                if (data.success) {
                    $('#idResult').html(`<strong>* ID는 ${data.id} 입니다. *</strong>`);
                } else {
                    $('#idResult').html(`<strong>* ${data.message} *</strong>`);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });

    // 비밀번호 찾기
    document.getElementById('findPwdForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const userId = document.querySelector('#findPwdForm input[type="text"]').value;
        const name = document.querySelector('#findPwdForm input[name="name"]').value;

        if (!userId || !name) {
            alert('모든 필드를 입력해주세요.');
            return;
        }

        $.ajax({
            url: '/api/findPwd',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                memberId: userId,
                memberName: name
            }),
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[name="_csrf"]').attr('content'));
            },
            success: function(data) {
                if (data.success) {
                    $('#pwdResult').html(`<strong>* ${data.message} *</strong>`);
                } else {
                    $('#pwdResult').html(`<strong>* ${data.message} *</strong>`);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
});
