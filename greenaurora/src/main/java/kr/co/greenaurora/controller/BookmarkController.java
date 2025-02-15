package kr.co.greenaurora.controller;

import java.security.Principal;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpSession;
import kr.co.greenaurora.entity.BookmarkEntity;
import kr.co.greenaurora.service.BookmarkService;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("bookmark")
@RequiredArgsConstructor
public class BookmarkController {

	private final BookmarkService bookmarkService;
	
	// 북마크 추가
	@PostMapping("/insert")
	@ResponseBody
	public boolean insert(@RequestParam String stationNumber, Principal principal) {

		if (principal.getName()!=null) {
			BookmarkEntity info =  BookmarkEntity.builder()
									.memberId(principal.getName())
									.stationNumber(stationNumber)
									.build();
			try {
				bookmarkService.save(info);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
			return true;
        } else {
		    return false;
		    
		}
	}
	
	// 북마크 제거
	@PostMapping("/delete")
	@ResponseBody
	public Boolean delete(@RequestParam String stationNumber, Principal principal) {

		if (principal.getName()!=null) {
			BookmarkEntity info =  BookmarkEntity.builder()
									.memberId(principal.getName())
									.stationNumber(stationNumber)
									.build();
			
			try {
				bookmarkService.delete(info);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return false;
			}
			return true;
        } else {
        	return false;
        }
		
	}
	
	// 북마크 조회
	@PostMapping("/select")
	@ResponseBody
	public boolean select(@RequestParam String stationNumber, Principal principal) {
		
		System.out.println(":::::::::::::::::::::66666666666::::::");
		System.out.println(principal.getName());
		System.out.println("::::::::::::::::::::666666666666:::::::");
		if (principal.getName()!=null) {
			return bookmarkService.findByMemberIdAndStationNumber(stationNumber, principal.getName());
        } else {
		    return false;
		    
		}
		
	}
	
}
