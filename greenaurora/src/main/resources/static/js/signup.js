document.addEventListener('DOMContentLoaded', function() {
    const allAgreeCheckbox = document.getElementById('allAgree');
    const termsCheckboxes = document.querySelectorAll('.terms-item input[type="checkbox"]');
    const nextButton = document.querySelector('.next-btn');

    // allAgreeCheck
    allAgreeCheckbox.addEventListener('change', function() {
        termsCheckboxes.forEach(checkbox => {
            checkbox.checked = allAgreeCheckbox.checked;
        });
    });

    // checkRequiredTerms
    function checkRequiredTerms() {
        const requiredCheckboxes = Array.from(termsCheckboxes).slice(0, 3); // 필수
        return requiredCheckboxes.every(checkbox => checkbox.checked);
    }

    // termsCheckboxes
    termsCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            // allChecked 
            const allChecked = Array.from(termsCheckboxes).every(cb => cb.checked);
            allAgreeCheckbox.checked = allChecked;
        });
    });

    // nextButton
	nextButton.addEventListener('click', function(event) {
	    event.preventDefault(); 
	    if (checkRequiredTerms()) {
	        window.location.href ='signup2';
	    } else {
	        alert('필수 약관에 모두 동의해주세요.');
	    }
	});

});

