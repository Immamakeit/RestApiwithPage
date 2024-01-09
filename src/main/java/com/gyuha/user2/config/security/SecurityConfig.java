package com.gyuha.user2.config.security;

import com.gyuha.user2.mapper.UserMapper;
import jakarta.servlet.DispatcherType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private UserMapper userMapper;

    @Bean
    public CustomAuthenticationProvider customAuthenticationProvider() {
        return new CustomAuthenticationProvider();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        http
                .authorizeHttpRequests(authorize -> authorize
                        .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                        .requestMatchers("/", "/signin", "/signup", "/api/**", "/images/**", "/js/**", "/css/**").permitAll()
                        .anyRequest().authenticated()
                )
                /*api 내에도 페이지에서 넘어오는 csrf_token 검증하게 하고 api 실행되게 하기.
                ex) meta name = "csrf_token" 설정하고, 그거 가져다가 보내주기.
                meta name으로 csrf token 가져와주고
                meta name content javascript 보내면 됨.
                xhr.setRequestHeader로 하기.*/
                .csrf(csrf -> csrf
                        .ignoringRequestMatchers("/api/**")
                )
                .formLogin(form -> form
                        .loginPage("/signin")
                        .loginProcessingUrl("/login")
                        .defaultSuccessUrl("/user/detail")
                        .usernameParameter("username")
                        .passwordParameter("password")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/logout", "POST"))
                        .logoutSuccessUrl("/signin")
                        .permitAll()
                );

        return http.build();
    }

    //그냥 Bcrypt 쓰는게 나음.
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // 인코더 커스텀 해서 쓰고 싶을 때, encoderFactories.createDelegatingPassword 써서 설정해주면 됨.
    /* @Bean
    public PasswordEncoder passwordEncoder() {
        String encodingId = "bcrypt";
        Map<String, PasswordEncoder> encoders = new HashMap<>();
        encoders.put(encodingId, new BCryptPasswordEncoder());
        return new DelegatingPasswordEncoder(encodingId, encoders);
    }*/
    
    //5.7.0 이상부터는 web.ignoring 으로 정적자원 통과시키는 걸 권장하지 않음.
    //기본적인 filter 거치지 않기 때문에 filterChain 내부에서 requestMatcher permitALl로 풀어주는 걸 권장하고 있다고 함
    //static static resources common 어쩌고로 리턴해주는 것도 시도해보기 , chain 에 넣지 말고
    /* @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().requestMatchers.("/css/**", "/js/**", "/images/**");
    }*/

}