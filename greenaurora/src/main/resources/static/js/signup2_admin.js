document.addEventListener('DOMContentLoaded', function() {
	const form = document.querySelector('.signup-form');
	const prevBtn = document.querySelector('.prev-btn');
	const checkBtn = document.querySelector('.check-btn');
	const memberIdInput = document.querySelector('input[name="memberId"]');
	const passwordInput = document.querySelector('input[name="memberPass"]');
	const confirmPasswordInput = document.querySelector('input[name="memberPass2"]');
	const passwordErrorSpan = document.getElementById('password-error');
	const inputs = form.querySelectorAll('input');
	
	let isIdChecked = false;
	
	// Add event listeners for password fields
	passwordInput.addEventListener('input', validatePasswords);
	confirmPasswordInput.addEventListener('input', validatePasswords);
	
	let passwordsMatch = false;

	    function validatePasswords() {
	        if (passwordInput.value !== confirmPasswordInput.value) {
	            passwordErrorSpan.textContent = '비밀번호가 일치하지 않습니다.';
	            passwordErrorSpan.style.display = 'block';
	            passwordsMatch = false;
	        } else {
	            passwordErrorSpan.textContent = '';
	            passwordErrorSpan.style.display = 'none';
	            passwordsMatch = true;
	        }
	    }


/*	prevBtn.addEventListener('click', function() {
		window.location.href = 'signup';
	});
*/

	checkBtn.addEventListener('click', function() {
		const memberId = memberIdInput.value;
		console.log("memberId>>>>", memberIdInput.value);
		if (!memberId) {
			alert('아이디를 입력해주세요.');
			return;
		}

		$.ajax({
			url: "/svc/admin/checkId",
			type: "post",
			dataType: "JSON",
			data: { memberId: memberId },
			success: function(data) {
				console.log(data);
				if (data.exists === true) {
					alert('이미 사용 중인 아이디입니다.');
					isIdChecked = false;
				} else {
					alert('사용 가능한 아이디입니다.');
					isIdChecked = true;
				}
			},
			error: function(xhr, status, error) {
				console.error('Error:', error);
				alert('중복 확인 중 오류가 발생했습니다.');
				isIdChecked = false;
			}
		});	
		
	});


	form.addEventListener('submit', function(e) {
		e.preventDefault();

		if (!isIdChecked) {
			alert('아이디 중복 확인을 해주세요.');
			return;
		}
		
		// Validate passwords match before submitting
		if (!passwordsMatch) {
		    passwordErrorSpan.textContent = '비밀번호가 일치하지 않습니다. 다시 확인해주세요.';
		    passwordErrorSpan.style.display = 'block';
		    return;
		}


		// 전화번호 조합
		var phone1 = document.getElementById('phone1').value;
		var phone2 = document.getElementById('phone2').value;
		var phone3 = document.getElementById('phone3').value;
		document.getElementById('memberPhone').value = phone1 + phone2 + phone3;

		// 주민번호 조합
		var residentNumber1 = document.getElementById('residentNumber1').value;
		var residentNumber2 = document.getElementById('residentNumber2').value;
		document.getElementById('memberNumber').value = residentNumber1 + residentNumber2;

		// 폼 유효성 검사
		if (validateForm()) {
			this.submit();
		}
	});

	    inputs.forEach(input => {
	        input.addEventListener('input', function() {
	            validateInput(this);
	        });
	    });

	    function validateInput(input) {
	        // 입력 유효성 검사 로직
	        if (input.type === 'password') {
	            // 비밀번호 유효성 검사
	        } else if (input.type === 'email') {
	            // 이메일 유효성 검사
	        }
	        // 기타 입력 필드에 대한 유효성 검사...
	    }

	    function validateForm() {
	        // 전체 폼 유효성 검사 로직
	        // 필요한 모든 필드가 올바르게 작성되었는지 확인
	        return true; // 모든 검사를 통과하면 true 반환
	    }
	});

