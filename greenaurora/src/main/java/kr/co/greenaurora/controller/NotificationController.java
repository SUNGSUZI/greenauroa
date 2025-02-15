package kr.co.greenaurora.controller;

import java.security.Principal;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.repository.query.Param;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.greenaurora.entity.NotificationEntity;
import kr.co.greenaurora.service.NotificationService;
import lombok.RequiredArgsConstructor;
import reactor.core.publisher.Flux;

@RestController
@RequiredArgsConstructor
@RequestMapping("/notifi")
public class NotificationController {

	private final NotificationService notificationService;
	
//	@GetMapping(value = "/list/{page}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
//	public Flux<Object> pageList(@PathVariable("page") Integer pageParam, Principal principal){
//		final int page = Math.max(pageParam - 1, 0);  // page가 음수가 되지 않도록 보장
//		
//		return Flux.interval(Duration.ofSeconds(5)) //5초 간격으로 알림 스트리밍
//				.takeUntilOther(Flux.create(emitter -> {
//		            // 클라이언트가 연결을 종료하면 스트림도 종료
//		            emitter.onDispose(() -> {
//		                System.out.println("Client 연결종료");
//		            });
//				}))
//				.flatMap(sequence -> {
//					try {
//	            	   // 알림 페이지를 가져옴.
//	                   Page<NotificationEntity> notifications = notificationService.pageList(page, principal.getName());
//
//	                   // 데이터를 Map 형태로 변환
//	                   Map<String, Object> response = new HashMap<>();
//	                   response.put("content", notifications.getContent());
//	                   System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>");
//	           		   System.out.println(pageParam);
//	                   response.put("page", pageParam);
//	                   response.put("totalPages", notifications.getTotalPages());
//	                   response.put("totalElements", notifications.getTotalElements());
//
//	                   // Map을 Flux로 래핑하여 전송
//	                   return Flux.just(response);
//					} catch (Exception e) {
//                       // 에러 발생 시 빈 Flux 반환
//                       System.err.println("Error occurred: " + e.getMessage());
//                       return Flux.empty();
//                    }
//	           });
//	}
	
	@PostMapping(value = "/list")
	public Map<String, Object> pageList(@RequestParam Integer pageParam, Principal principal){
		final int page = Math.max(pageParam - 1, 0);  // page가 음수가 되지 않도록 보장
		Page<NotificationEntity> notifications = notificationService.pageList(page, principal.getName());

        // 데이터를 Map 형태로 변환
        Map<String, Object> response = new HashMap<>();
        response.put("content", notifications.getContent());
        System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>");
		System.out.println(pageParam);
        response.put("page", pageParam);
        response.put("totalPages", notifications.getTotalPages());
        response.put("totalElements", notifications.getTotalElements());
        
        return response;
	}
	
	@PostMapping("/detail")
	public NotificationEntity detail(@RequestParam Long notiKey) {
		return notificationService.findByNotiKey(notiKey);
	}
	
	@GetMapping(value = "/new/Cnt", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	public Flux<Object> newCnt(Principal principal) {
		if(principal.getName()!=null) {
			return Flux.interval(Duration.ofSeconds(1))
	                .map(sequence -> {
	                	try {
		                	Integer count = notificationService.countByStateAndMemberId(principal.getName());
		                    Map<String, Object> response = new HashMap<>();
		                    response.put("count", count);
		                    return response;
	                	}catch (Exception e) {
	                		// 에러 발생 시 빈 Flux 반환
	                        System.err.println("Error occurred: " + e.getMessage());
	                        return Flux.empty();
						}
	                });
		}
		return Flux.empty();
	}
	
	
	@PostMapping("/insert")
	public void insert() {
	}
}

