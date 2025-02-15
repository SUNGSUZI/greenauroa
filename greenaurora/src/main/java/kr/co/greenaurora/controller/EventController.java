package kr.co.greenaurora.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.co.greenaurora.dto.EventForm;
import kr.co.greenaurora.dto.EventResponse;
import kr.co.greenaurora.entity.EventEntity;
import kr.co.greenaurora.service.EventService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EventController {

	private final EventService eventService;
	
	// 이벤트 작성 폼 (eform)
	@GetMapping("/event/eform")
	public String eform(Model model, Principal principal) {
		EventForm eventForm = new EventForm();
		
		model.addAttribute("eventForm", eventForm);
		return "event/eform";
	}
	
	// 이벤트 작성 폼 처리 (eform)
	@PostMapping("/event/eform")
	public String eformInsert(@ModelAttribute("eventForm") EventForm eventForm,
							  @RequestParam(value="eventThumb", required=false) MultipartFile file) {
        try {
            // EventForm을 EventEntity로 변환
        	EventEntity eventEntity = EventEntity.toEventEntityFromEventForm(eventForm);
        	eventEntity.setEventKey(Long.toString(System.currentTimeMillis()));
        	eventEntity.setCreateDt(new Date());

            // 파일 처리
            if (file != null && !file.isEmpty()) {
                String filePath = eventService.saveFile(file); // 파일 저장
                eventEntity.setEventThumb(filePath); // 파일 경로 설정
            }

            // 데이터 저장
            System.out.println("eform 저장: "+eventEntity.toString());
            eventService.save(eventEntity);
            return "redirect:/event/elist"; // 등록 후 목록 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/event/eform"; // 오류 발생 시 작성 폼으로 리다이렉트
        }
	}

	// 이벤트 목록 (elist)
	@GetMapping("/event/elist")
	public String elist(@RequestParam(defaultValue = "0") int page, Model model, Principal principal) {
		int pageSize = 9;
		
        // Pageable을 사용하여 페이지와 정렬을 데이터베이스에서 처리
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by(Sort.Order.desc("createDt")));
       
        // JPA를 사용하여 페이징 및 정렬된 데이터 조회
        Page<EventEntity> eventPage = eventService.findAll(pageable);
		
        // Entity를 Response DTO로 변환
        List<EventResponse> eventList = eventPage.getContent().stream()
        		.map(EventResponse::toEventResponseFromEventEntity)
        		.collect(Collectors.toList());
        
        // 모델에 데이터 전달
        model.addAttribute("principal", principal);
        model.addAttribute("eventList", eventList);
        model.addAttribute("totalCount", eventPage.getTotalElements());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", eventPage.getTotalPages());
		
		return "event/elist";
	}

	// 이벤트 자세히 보기 (edetail)
	@GetMapping("/event/edetail/{eventkey}")
	public String edetail(@PathVariable String eventkey, Model model, Principal principal) {
		EventEntity eventEntity = eventService.findByEventKey(eventkey);
		
		if (eventEntity != null) {
			// EventEntity를 EventResponse로 변환
			EventResponse eventResponse = EventResponse.toEventResponseFromEventEntity(eventEntity);
			model.addAttribute("principal", principal);
			model.addAttribute("event", eventResponse);
		} else {
			model.addAttribute("errorMessage", "게시글을 찾을 수 없습니다.");
		}
		
		return "event/edetail";
	}
	
	// 이벤트 수정하기 (eupdate) - 수정 폼 보여주기
	@GetMapping("/event/eupdate/{eventkey}")
	public String eupdate(@PathVariable String eventkey, Model model) {
		EventEntity eventEntity = eventService.findByEventKey(eventkey);
		
		if (eventEntity != null) {
			EventResponse eventResponse = EventResponse.toEventResponseFromEventEntity(eventEntity);
			model.addAttribute("event", eventResponse);
		} else {
			model.addAttribute("errorMessage", "게시글을 찾을 수 없습니다.");
		}
		
		return "event/eupdate";
	}
	
	// 이벤트 수정 처리 (eupdate)
	@PostMapping("/event/eupdate/{eventkey}")
	public String eupdate(@PathVariable String eventkey,
						  @ModelAttribute("eventForm") EventForm eventForm,
						  @RequestParam(value = "file", required =false) MultipartFile file) {
		try {
			// 기존 데이터 가져오기
			EventEntity eventEntity = eventService.findByEventKey(eventkey);
			
			// EventForm을 EventEntity로 변환
			EventEntity eventEntity2 = EventEntity.toEventEntityFromEventForm(eventForm);
			eventEntity2.setEventKey(eventEntity.getEventKey());
			eventEntity2.setCreateDt(eventEntity.getCreateDt());
			
            // 파일 처리
            if (file != null && !file.isEmpty()) {
                String filePath = eventService.saveFile(file); // 파일 저장
                eventEntity.setEventThumb(filePath); // 파일 경로 설정
            } else {
				eventEntity2.setEventThumb(eventEntity.getEventThumb());
			}
			
			// 데이터 저장
			System.out.println(eventEntity2.toString());
			eventService.save(eventEntity2);
			
			return "redirect:/event/elist";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/event/eform";
		}
	}
	
	// 이벤트 삭제 처리
	@GetMapping("/event/edelete/{eventKey}")
	public String edelete(@PathVariable String eventKey) {
		eventService.deleteByEventKey(eventKey);
		return "redirect:/event/elist"; // 삭제 후 목록 페이지로 리다이렉트
	}

}
