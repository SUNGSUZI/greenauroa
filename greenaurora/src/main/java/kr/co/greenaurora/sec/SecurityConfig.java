package kr.co.greenaurora.sec;


import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {
   
   private final CustomOAuth2UserService customeOAuth2UserService;
   private final CustomAuthenticationSuccessHandler authenticationSuccessHandler;

    
   @Bean
   public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
       return authenticationConfiguration.getAuthenticationManager();
   }
   
//    @Bean
//       public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
//           StrictHttpFirewall firewall = new StrictHttpFirewall();
//           firewall.setAllowUrlEncodedSlash(true);
//           firewall.setAllowSemicolon(true);
//           return firewall;
//       }
      

    @Bean
       public BCryptPasswordEncoder bCryptPasswordEncoder() {
           return new BCryptPasswordEncoder();
       }
      
//    @Bean
//    public WebSecurityCustomizer webSecurityCustomizer() {
//        return (web) -> web.httpFirewall(allowUrlEncodedSlashHttpFirewall());    
//    }
    


    
    
    
   @Bean
   public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
      
//      List<UrlsEntity> list=urlsRepository.findAll();
//      String[] permiteUrls=list.toArray();
      
//      List<String> list=new ArrayList<String>();
//      String[] perimitUrls2=(String[]) list.toArray();
      
      String[] permitUrls={"/","/svc/**", "/oauth2/**", "/index/**", "/auth/**","/auth/login"};
      
      
      http
      .csrf((auth)->auth.disable());
      
//      http
//      .formLogin((auth)-> auth.disable());
      
      http
      .httpBasic((auth)->auth.disable());
      
//      http
//      .oauth2Login(Customizer.withDefaults());
      
      http
      .oauth2Login((auth)-> auth
            .loginPage("/auth/login")
            .defaultSuccessUrl("/main", true)
            .userInfoEndpoint((config)-> config
                  .userService(customeOAuth2UserService)
                  )
      );
   
      
      
      http
       .formLogin((auth) -> auth
           .loginPage("/auth/login")
           .loginProcessingUrl("/auth/login")
           .successHandler(authenticationSuccessHandler)
           .failureUrl("/auth/login?error")
           .permitAll()
       );
            
      http
      .sessionManagement(session -> session
            .maximumSessions(1)
            .expiredUrl("/auth/login?expired")
      );
            
      http
      .authorizeHttpRequests(
            (auth)->auth
            .requestMatchers(permitUrls).permitAll()
            .requestMatchers("/admin").hasRole("ADMIN")
            .requestMatchers("/svc/**").hasAnyRole("ADMIN","USER")
            .requestMatchers("/**").permitAll()
            );   

      
      
      
      // logout작업
      http.logout((auth) -> auth
            .logoutUrl("/auth/logout")
            .logoutSuccessUrl("/")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
      );
      
      
      return http.build();
   }

}


    
 




