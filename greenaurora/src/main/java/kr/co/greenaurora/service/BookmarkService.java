package kr.co.greenaurora.service;

import java.util.Optional;

import org.springframework.stereotype.Service;

import kr.co.greenaurora.entity.BookmarkEntity;
import kr.co.greenaurora.repository.BookmarkRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookmarkService {

	
	private final BookmarkRepository bookmarkRepository;
	
	public void save(BookmarkEntity info) throws Exception{
			bookmarkRepository.save(info);
	}

	public boolean findByMemberIdAndStationNumber(String stationNumber, String name) {
		Optional<BookmarkEntity> opt = bookmarkRepository.findByMemberIdAndStationNumber(name, stationNumber);
		if(opt.isPresent()) {
			return true;
		}else {
			return false;
		}
	}

	public void delete(BookmarkEntity info) throws Exception{
			bookmarkRepository.deleteByMemberIdAndStationNumber(info.getMemberId(), info.getStationNumber());
	}

}
