package com.gyuha.user2.config.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import java.util.HashMap;
import java.util.Map;


@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public CustomAuthenticationProvider customAuthenticationProvider() {
        return new CustomAuthenticationProvider();
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests((authorize) -> authorize
                        .requestMatchers("/user/**").authenticated()
                        .anyRequest().permitAll()
                )
                .formLogin(form -> form
                        .loginPage("/signin")
                        .loginProcessingUrl("/login")
                        .defaultSuccessUrl("/user/detail")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutSuccessUrl("/")
                );

        http.authenticationProvider(customAuthenticationProvider());

        return http.build();
    }

//    @Bean
//    public PasswordEncoder createDelegatingPasswordEncoder() {
//        String encodingId = "bcrypt";
//        Map<String, PasswordEncoder> encoders = new HashMap<>();
//        encoders.put(encodingId, new BCryptPasswordEncoder());
//        return new org.springframework.security.crypto.password.DelegatingPasswordEncoder(encodingId, encoders);
//    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }



}

