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

import kr.co.greenaurora.dto.NoticeForm;
import kr.co.greenaurora.dto.NoticeResponse;
import kr.co.greenaurora.dto.QnaForm;
import kr.co.greenaurora.dto.QnaResponse;
import kr.co.greenaurora.entity.BoardEntity;
import kr.co.greenaurora.service.BoardSerivce;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class BoardController {

	private final BoardSerivce boardService;

    // 문의사항 작성 폼 (qform)
    @GetMapping("/qna/qform")
    public String qform(Model model, Principal principal) {
        QnaForm qnaForm = new QnaForm();
        
        // 로그인된 사용자 정보를 가져와서 qnaForm에 설정
        String memberId = principal.getName();
        qnaForm.setMemberId(memberId);

        model.addAttribute("qnaForm", qnaForm);
        return "qna/qform";
    }

    // 문의사항 작성 폼 처리 (qform)
    @PostMapping("/qna/qform")
    public String qformInsert(@ModelAttribute("qnaForm") QnaForm qnaForm, 
                              @RequestParam(value="filePath", required=false) MultipartFile file) {
        try {
            // Member ID 확인
            String memberId = qnaForm.getMemberId();
            if (memberId == null || memberId.isEmpty()) {
                throw new IllegalArgumentException("회원 ID가 누락되었습니다.");
            }

            // QnaForm을 BoardEntity로 변환
            BoardEntity boardEntity = BoardEntity.toBoardEntityFromQnaForm(qnaForm);
            boardEntity.setBoardKey(Long.toString(System.currentTimeMillis()));
            boardEntity.setCreateDt(new Date());
            boardEntity.setUpdateDt(new Date());

            // 파일 처리
            if (file != null && !file.isEmpty()) {
                String filePath = boardService.saveQnaFile(file); // 파일 저장
                boardEntity.setFilePath(filePath); // 파일 경로 설정
            }

            // 데이터 저장
            System.out.println("qform 저장: "+boardEntity.toString());
            boardService.save(boardEntity);
            return "redirect:/qna/qlist"; // 등록 후 목록 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/qna/qform"; // 오류 발생 시 작성 폼으로 리다이렉트
        }
    }

    // 문의사항 목록 (qlist)
    @GetMapping("/qna/qlist")
    public String qlist(@RequestParam(defaultValue = "0") int page, Model model, Principal principal) {
        int pageSize = 10;
        
        // Pageable을 사용하여 페이지와 정렬을 데이터베이스에서 처리
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by(Sort.Order.desc("createDt")));
        
        // JPA를 사용하여 페이징 및 정렬된 데이터 조회
        Page<BoardEntity> boardPage = boardService.findByCategory("문의사항", pageable);
        
        // Entity를 Response DTO로 변환
        List<QnaResponse> qnaList = boardPage.getContent().stream()
            .map(QnaResponse::toQnaResponseFromBoardEntity)
            .collect(Collectors.toList());

        // 모델에 데이터 전달
        model.addAttribute("principal", principal);
        model.addAttribute("qnaList", qnaList);
        model.addAttribute("totalCount", boardPage.getTotalElements());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", boardPage.getTotalPages());

        return "qna/qlist";
    }
    
    @GetMapping("/qna/qlist/{memberId}")
    public String myPageQList(@PathVariable String memberId, 
    						  @RequestParam(defaultValue = "0") int page, 
    						  Model model, 
    						  Principal principal) {
        int pageSize = 10;
        
        // Pageable을 사용하여 페이지와 정렬을 데이터베이스에서 처리
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by(Sort.Order.desc("createDt")));
        
        // JPA를 사용하여 페이징 및 정렬된 데이터 조회
        Page<BoardEntity> boardPage = boardService.findByCategoryAndMemberId("문의사항", memberId, pageable);
        
        // Entity를 Response DTO로 변환
        List<QnaResponse> qnaList = boardPage.getContent().stream()
            .map(QnaResponse::toQnaResponseFromBoardEntity)
            .collect(Collectors.toList());

        // 모델에 데이터 전달
        model.addAttribute("principal", principal);
        model.addAttribute("qnaList", qnaList);
        model.addAttribute("totalCount", boardPage.getTotalElements());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", boardPage.getTotalPages());
        
    	return "qna/qlist";
    }

    // 문의사항 자세히 보기 (qdetail)
    @GetMapping("/qna/qdetail/{boardkey}")
    public String qdetail(@PathVariable String boardkey, Model model, Principal principal) {
        BoardEntity boardEntity = boardService.findByBoardKey(boardkey);
        
        if (boardEntity != null) {
            // BoardEntity를 QnaResponse로 변환
            QnaResponse qnaResponse = QnaResponse.toQnaResponseFromBoardEntity(boardEntity);
            model.addAttribute("principal", principal);
            model.addAttribute("qna", qnaResponse); // 게시글 정보
        } else {
            model.addAttribute("errorMessage", "게시글을 찾을 수 없습니다.");
        }

        return "qna/qdetail";
    }

    // 문의사항 수정하기 (qupdate) - 수정 폼 보여주기
    @GetMapping("/qna/qupdate/{boardkey}")
    public String qupdate(@PathVariable String boardkey, Model model) {
        BoardEntity boardEntity = boardService.findByBoardKey(boardkey);

        if (boardEntity != null) {
            QnaResponse qnaResponse = QnaResponse.toQnaResponseFromBoardEntity(boardEntity);
            model.addAttribute("qna", qnaResponse);
        } else {
            model.addAttribute("errorMessage", "게시글을 찾을 수 없습니다.");
        }

        return "qna/qupdate";
    }

    // 문의사항 수정 처리 (qupdate)
    @PostMapping("/qna/qupdate/{boardkey}")
    public String qupdate(@PathVariable String boardkey, 
                          @ModelAttribute("qnaForm") QnaForm qnaForm, 
                          @RequestParam(value = "file", required = false) MultipartFile file) {
        try {
            // 기존 데이터 가져오기
            BoardEntity boardEntity = boardService.findByBoardKey(boardkey);

            // Member ID 확인
            String memberId = qnaForm.getMemberId();
            if (memberId == null || memberId.isEmpty()) {
                throw new IllegalArgumentException("회원 ID가 누락되었습니다.");
            }

            // QnaForm을 BoardEntity로 변환
            BoardEntity boardEntity2 = BoardEntity.toBoardEntityFromQnaForm(qnaForm);
            boardEntity2.setBoardKey(boardEntity.getBoardKey());
            boardEntity2.setCreateDt(boardEntity.getCreateDt());
            boardEntity2.setUpdateDt(boardEntity.getUpdateDt());

            // 파일 처리
            if (file != null && !file.isEmpty()) {
                String savedFilePath = boardService.saveQnaFile(file); // 파일 저장
                boardEntity2.setFilePath(savedFilePath); // 파일 경로 설정
            } else {
                // 파일이 없으면 기존 파일 경로 유지
                boardEntity2.setFilePath(boardEntity.getFilePath());
            }

            // 데이터 저장
            boardService.save(boardEntity2);

            return "redirect:/qna/qlist"; // 성공 시 목록 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/qna/qform"; // 오류 발생 시 작성 폼으로 리다이렉트
        }
    }

    // 문의사항 삭제 처리
    @GetMapping("/qna/qdelete/{boardKey}")
    public String qdelete(@PathVariable String boardKey) {
        boardService.deleteByBoardKey(boardKey);
        return "redirect:/qna/qlist"; // 삭제 후 목록 페이지로 리다이렉트
    }
    
    ////////////////////////////////////////////////////////////////
    
    // 공지사항 작성 폼 (nform)
    @GetMapping("/notice/nform")
    public String nform(Model model, Principal principal) {
        NoticeForm noticeForm = new NoticeForm();
        
        // 로그인된 사용자 정보를 가져와서 noticeForm에 설정
        String memberId = principal.getName();
        noticeForm.setMemberId(memberId);

        model.addAttribute("noticeForm", noticeForm);
        return "notice/nform";
    }

    // 공지사항 작성 폼 처리 (nform)
    @PostMapping("/notice/nform")
    public String nformInsert(@ModelAttribute("noticeForm") NoticeForm noticeForm, 
                               @RequestParam(value="filePath", required=false) MultipartFile file) {
        try {
            // Member ID 확인
            String memberId = noticeForm.getMemberId();
            if (memberId == null || memberId.isEmpty()) {
                throw new IllegalArgumentException("회원 ID가 누락되었습니다.");
            }

            // NoticeForm을 BoardEntity로 변환
            BoardEntity boardEntity = BoardEntity.toBoardEntityFromNoticeForm(noticeForm);
            boardEntity.setBoardKey(Long.toString(System.currentTimeMillis()));
            boardEntity.setCreateDt(new Date());
            boardEntity.setUpdateDt(new Date());

            // 파일 처리
            if (file != null && !file.isEmpty()) {
                String filePath = boardService.saveNoticeFile(file); // 파일 저장
                boardEntity.setFilePath(filePath); // 파일 경로 설정
            }

            // 데이터 저장
            boardService.save(boardEntity);
            return "redirect:/notice/nlist"; // 등록 후 목록 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/notice/nform"; // 오류 발생 시 작성 폼으로 리다이렉트
        }
    }

    // 공지사항 목록 (nlist)
    @GetMapping("/notice/nlist")
    public String nlist(@RequestParam(defaultValue = "0") int page, Model model, Principal principal) {
        int pageSize = 10;
        
        // Pageable을 사용하여 페이지와 정렬을 데이터베이스에서 처리
        Pageable pageable = PageRequest.of(page, pageSize, Sort.by(Sort.Order.desc("createDt")));
        
        // JPA를 사용하여 페이징 및 정렬된 데이터 조회
        Page<BoardEntity> boardPage = boardService.findByCategory("공지사항", pageable);
        
        // Entity를 Response DTO로 변환
        List<NoticeResponse> noticeList = boardPage.getContent().stream()
            .map(NoticeResponse::toNoticeResponseFromBoardEntity)
            .collect(Collectors.toList());

        // 모델에 데이터 전달
        model.addAttribute("principal", principal);
        model.addAttribute("noticeList", noticeList);
        model.addAttribute("totalCount", boardPage.getTotalElements());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", boardPage.getTotalPages());

        return "notice/nlist";
    }

    // 공지사항 자세히 보기 (ndetail)
    @GetMapping("/notice/ndetail/{boardkey}")
    public String ndetail(@PathVariable String boardkey, Model model, Principal principal) {
        BoardEntity boardEntity = boardService.findByBoardKey(boardkey);
        
        if (boardEntity != null) {
            // BoardEntity를 NoticeResponse로 변환
            NoticeResponse noticeResponse = NoticeResponse.toNoticeResponseFromBoardEntity(boardEntity);
            model.addAttribute("principal", principal);
            model.addAttribute("notice", noticeResponse); // 게시글 정보
        } else {
            model.addAttribute("errorMessage", "게시글을 찾을 수 없습니다.");
        }

        return "notice/ndetail";
    }

    // 공지사항 수정하기 (nupdate) - 수정 폼 보여주기
    @GetMapping("/notice/nupdate/{boardkey}")
    public String nupdate(@PathVariable String boardkey, Model model) {
        BoardEntity boardEntity = boardService.findByBoardKey(boardkey);

        if (boardEntity != null) {
            NoticeResponse noticeResponse = NoticeResponse.toNoticeResponseFromBoardEntity(boardEntity);
            model.addAttribute("notice", noticeResponse);
        } else {
            model.addAttribute("errorMessage", "게시글을 찾을 수 없습니다.");
        }

        return "notice/nupdate";
    }

    // 공지사항 수정 처리 (nupdate)
    @PostMapping("/notice/nupdate/{boardkey}")
    public String nupdate(@PathVariable String boardkey, 
                          @ModelAttribute("noticeForm") NoticeForm noticeForm, 
                          @RequestParam(value = "file", required = false) MultipartFile file) {
        try {
            // 기존 데이터 가져오기
            BoardEntity boardEntity = boardService.findByBoardKey(boardkey);

            // Member ID 확인
            String memberId = noticeForm.getMemberId();
            if (memberId == null || memberId.isEmpty()) {
                throw new IllegalArgumentException("회원 ID가 누락되었습니다.");
            }

            // NoticeForm을 BoardEntity로 변환
            BoardEntity boardEntity2 = BoardEntity.toBoardEntityFromNoticeForm(noticeForm);
            boardEntity2.setBoardKey(boardEntity.getBoardKey());
            boardEntity2.setCreateDt(boardEntity.getCreateDt());
            boardEntity2.setUpdateDt(boardEntity.getUpdateDt());

            // 파일 처리
            if (file != null && !file.isEmpty()) {
                String savedFilePath = boardService.saveNoticeFile(file); // 파일 저장
                boardEntity2.setFilePath(savedFilePath); // 파일 경로 설정
            } else {
                // 파일이 없으면 기존 파일 경로 유지
                boardEntity2.setFilePath(boardEntity.getFilePath());
            }

            // 데이터 저장
            boardService.save(boardEntity2);

            return "redirect:/notice/nlist"; // 성공 시 목록 페이지로 리다이렉트
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/notice/nform"; // 오류 발생 시 작성 폼으로 리다이렉트
        }
    }

    // 공지사항 삭제 처리
    @GetMapping("/notice/ndelete/{boardKey}")
    public String ndelete(@PathVariable String boardKey) {
        boardService.deleteByBoardKey(boardKey);
        return "redirect:/notice/nlist"; // 삭제 후 목록 페이지로 리다이렉트
    }
    
    ////////////////////////////////////////////////////////////////
    

}
