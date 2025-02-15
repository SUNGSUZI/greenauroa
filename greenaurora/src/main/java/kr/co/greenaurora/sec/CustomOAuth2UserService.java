package kr.co.greenaurora.sec;

import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import kr.co.greenaurora.entity.MemberEntity;
import kr.co.greenaurora.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {
   
   private final MemberRepository memberRepository;

   @Override
   public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
      OAuth2User oAuth2User = super.loadUser(userRequest);
      
      String registrationId = userRequest.getClientRegistration().getRegistrationId();
      
      OAuth2Response oAuth2Response;
      
      if (registrationId.equals("naver")) {
         oAuth2Response = new NaverResponse(oAuth2User.getAttributes());
      }else if(registrationId.equals("kakao")) {
          oAuth2Response = new KakaoResponse(oAuth2User.getAttributes());
      }else if(registrationId.equals("google")) {
          oAuth2Response = new GoogleResponse(oAuth2User.getAttributes());
      }else if(registrationId.equals("wechat")) {
          oAuth2Response = new GoogleResponse(oAuth2User.getAttributes());
      } else {
         throw new OAuth2AuthenticationException("Unsupported OAuth provider: " + registrationId);
      }
      
      String role = "ROLE_USER"; // Changed from ROLE_ADMIN to ROLE_USER for security best practices
      
      String username = oAuth2Response.getProvider() + "___greenaurora___" + oAuth2Response.getProviderId();
      
      MemberEntity dbUserEntity = memberRepository.findByMemberId(username).orElse(null);

      
      String email = oAuth2Response.getEmail();
      String name = oAuth2Response.getName();
      
      if (dbUserEntity == null) {
         dbUserEntity = MemberEntity.builder()
               .memberId(username)
               .memberEmail(email)
               .memberName(name)
               .role(role)
               .build();
      } else {
         dbUserEntity.setMemberEmail(email);
         dbUserEntity.setMemberName(name); // Changed from username to name
      }
      
      memberRepository.save(dbUserEntity);
      
      return new CustomOAuth2User(oAuth2Response, role);
   }
}
