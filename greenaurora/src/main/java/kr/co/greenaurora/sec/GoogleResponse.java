package kr.co.greenaurora.sec;

import java.util.Map;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class GoogleResponse implements OAuth2Response {
	
	private final Map<String, Object> attributes;

	@Override
	public String getProvider() {
		// TODO Auto-generated method stub
		return "google";
	}

	@Override
	public String getProviderId() {
		// TODO Auto-generated method stub
		return attributes.get("sub").toString();
	}

	@Override
	public String getEmail() {
		// TODO Auto-generated method stub
		return attributes.get("email").toString();
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return attributes.get("name").toString();
	}

	@Override
	public Integer getPhone() {
		// TODO Auto-generated method stub
		return null;
	}

}
