package kr.co.greenaurora.sec;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import kr.co.greenaurora.entity.MemberEntity;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class CustomUserDetails implements UserDetails{
	
	private static final long serialVersionUID = 1L;
	
	private final MemberEntity memberEntity;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		Collection<GrantedAuthority> collection= new ArrayList<GrantedAuthority>();
		
		collection.add(new GrantedAuthority() {			
			
			private static final long serialVersionUID = 1L;
			
			@Override
			public String getAuthority() {
				// TODO Auto-generated method stub
				return memberEntity.getRole();
			}
		});
		
		return collection;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return memberEntity.getMemberPass();
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return memberEntity.getMemberId();
	}
	
	public String getRole() {
		return memberEntity.getRole();
	}
	
	public String getName() {
		return memberEntity.getMemberName();
	}
	


}
