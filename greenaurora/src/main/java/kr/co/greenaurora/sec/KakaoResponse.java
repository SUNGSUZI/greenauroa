package kr.co.greenaurora.sec;

import java.util.Map;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class KakaoResponse implements OAuth2Response{
	
	private final Map<String, Object> attributes;

	public String getProvider() {
		// TODO Auto-generated method stub
		return "kakao";
	}

	@Override
	public String getProviderId() {
		Object id = attributes.get("id");
		return id != null ? id.toString() : null;
	}

	@Override
	public String getName() {
		@SuppressWarnings("unchecked")
		Map<String, Object> properties = (Map<String, Object>) attributes.get("properties");
		if (properties != null) {
			Object nickname = properties.get("nickname");
			return nickname != null ? nickname.toString() : null;
		}
		return null;
	}

	@Override
	public String getEmail() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getPhone() {
		// TODO Auto-generated method stub
		return null;
	}

}
