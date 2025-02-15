package kr.co.greenaurora.sec;

import java.util.Map;


public class NaverResponse implements OAuth2Response{
   
   private final Map<String, Object> attributes;

   @SuppressWarnings("unchecked")
   public NaverResponse(Map<String, Object> attributes) {
      System.out.println(attributes);
      this.attributes = (Map<String, Object>)attributes.get("response");
   }

   @Override
   public String getProvider() {
      return "naver";
   }

   @Override
   public String getProviderId() {
      return attributes.get("id").toString();
   }

   @Override
   public String getEmail() {
      return attributes.get("email").toString();
   }

   @Override
   public String getName() {
      return attributes.get("name").toString();
   }

   @Override
	public Integer getPhone() {
		// TODO Auto-generated method stub
		return null;
}
}
