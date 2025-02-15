package kr.co.greenaurora.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.greenaurora.service.PointService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/point")
public class PointController {

	private final PointService pointService;
	
	@PostMapping("/select")
	@ResponseBody
	public Map<String, Integer> select(Principal principal) {
		Integer result = pointService.findMemberPoint(principal.getName());
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("result", result);
		return map;
	}
}
 