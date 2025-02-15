document.addEventListener('DOMContentLoaded', function() {
    const logoutBtn = document.getElementById('logoutBtn');
    logoutBtn.addEventListener('click', function() {
        // 서버에 로그아웃 요청 보내기
        fetch('/auth/logout', {
            method: 'POST',
            credentials: 'same-origin' // 세션이 올바르게 종료되도록 자격 증명 포함
        }).then(response => {
            if (response.ok) {
                // 로그아웃 성공 후 인덱스 페이지로 리다이렉트
                window.location.href = '/index';
            } else {
                console.error('로그아웃 실패');
            }
        }).catch(error => {
            console.error('로그아웃 과정에서 오류 발생:', error);
        });
    });
});

function makeListTag(data, setNum){
	let content = ``;
	let rnum = 5* (setNum-1);
	for(row of data.content){
		rnum++;
		content += `<tr>
	                <th scope="row" class="notice_num">${rnum}</td>
					<td scope="row" class="notice_num">${row.state ==="NR"?"안읽음":"읽음"}</td>
					<td class="title" onClick="detailPage(${row.notiKey})">
	                    ${row.title}
	                </td>
					
	                <td class="sender">${row.sender}</td>
	                <td class="createDt">'${row.createDt}</td>
	            </tr>`
	}
	return content;
}

function pageSetting(page, data){
	let content = ``;
	const currentPage = page; 
	content = 	`<button class="page-button" onClick="setNotifiList(${currentPage - 1 <= 0 ? 1 : currentPage - 1})">
			                        &laquo;
			     </button>`
	for(var i = 1; i <= data.totalPages; i++){
			content += `<button class="page-button ${currentPage == i ? 'active' : ''}" onClick="setNotifiList(${i})">${i}</button>`
		}	
		
	content += 	`<button class="page-button" onClick="setNotifiList(${currentPage+1 >= data.totalPages ?data.totalPages : currentPage + 1})">
		                        &raquo;
			     </button>`
	return content;
}



function closeNotificationDetailModal() {
  // 모달과 배경 숨기기
  const modal = document.getElementById("notification-detail-modal");
  const backdrop = document.getElementById("notification-detail-modal-backdrop");

  modal.style.display = "none";
  backdrop.style.display = "none";
  setNotifiList(1)
}