document.addEventListener('DOMContentLoaded', function() {
    console.log('Document is fully loaded');

    const loginForm = document.querySelector('.login-form');
    const naverButton = document.querySelector('.sns-btn.naver');
    const kakaoButton = document.querySelector('.sns-btn.kakao');
    const googleButton = document.querySelector('.sns-btn.google');
    const wechatButton = document.querySelector('.sns-btn.wechat');

    if (naverButton) naverButton.addEventListener('click', handleNaverLogin);
    if (kakaoButton) kakaoButton.addEventListener('click', handleKakaoLogin);
    if (googleButton) googleButton.addEventListener('click', handleGoogleLogin);
    if (wechatButton) wechatButton.addEventListener('click', handleWechatLogin);

    if (loginForm) {
        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();
            console.log('로그인 폼 제출');

            const username = loginForm.querySelector('input[type="text"]').value;
            const password = loginForm.querySelector('input[type="password"]').value;
            const csrfInput = loginForm.querySelector('input[name="${_csrf.parameterName}"]');
            const csrfToken = csrfInput ? csrfInput.value : '';

            if (!username || !password) {
                console.log('사용자 이름 또는 비밀번호가 비어 있습니다');
                alert('아이디와 비밀번호를 입력해주세요.');
                return;
            }

            console.log('Username:', username);
            console.log('CSRF Token:', csrfToken);
            console.log('로그인 요청 전송');

            $.ajax({
                url: '/auth/loginProc',
                type: 'POST',
                contentType: 'application/x-www-form-urlencoded',
                data: {
                    memberId: username,
                    memberPass: password,
                    [csrfInput ? csrfInput.name : '_csrf']: csrfToken
                },
                success: function(response) {
                    console.log('서버 응답:', response);

                    if (typeof response === 'string' && response.startsWith('redirect:')) {
                        console.log('리다이렉트 처리:', response);
                        const redirectPath = response.replace('redirect:', '').trim();
                        window.location.href = redirectPath === '/' ? '/main' : redirectPath;
                    } else if (response && response.success) {
                        console.log('로그인 성공, main 페이지로 이동 준비');
                        window.location.href = '/main';
                    } else {
                        console.error('로그인 실패:', response ? response.message : '알 수 없는 오류');
                        alert(response && response.message ? response.message : '로그인에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('로그인 요청 실패:', error);
                    alert('로그인 중 오류가 발생했습니다. 다시 시도해주세요.');
                }
            });
        });
    }
});

function handleNaverLogin() {
    console.log('Initiating Naver login');
    window.location.href = '/oauth2/authorization/naver';
}

function handleKakaoLogin() {
    console.log('Initiating Kakao login');
    window.location.href = '/oauth2/authorization/kakao';
}

function handleGoogleLogin() {
    console.log('Initiating Google login');
    window.location.href = '/oauth2/authorization/google';
}

/*function handleWechatLogin() {
    console.log('Initiating WeChat login');
    window.location.href = '/oauth2/authorization/wechat';
}
*/
window.onerror = function(message, source, lineno, colno, error) {
    console.error('잡히지 않은 오류:', message, error);
};
