package com.gyuha.user2.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/loginForm", "/", "/css/**", "/js/**", "/images/**").permitAll()  // 로그인 페이지와 정적 자원에 대한 접근 허용
                        .requestMatchers("/userDetail").authenticated()  // "/userDetail"은 인증 필요
                        .anyRequest().permitAll()  // 나머지 경로는 인증 필요 없음
                )
                .formLogin(formLogin -> formLogin
                        .loginPage("/loginForm")  // 사용자 정의 로그인 페이지 경로
                        .loginProcessingUrl("/check/login")  // 로그인 처리 URL
                        .defaultSuccessUrl("/userDetail")
                        .permitAll()  // 모든 사용자가 로그인 페이지에 접근할 수 있도록 허용
                );

        return http.build();
    }
}
