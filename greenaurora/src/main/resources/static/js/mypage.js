

function makeListTag(data, setNum){
	let content = ``;
	
	for(row of data.content){
		content += `<tr>
	                <th scope="row" class="notice_num">1</td>
	                <td scope="row" class="notice_num">${row.state}</td>
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
}