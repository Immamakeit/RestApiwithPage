package com.gyuha.user2.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.gyuha.user2.consts.ResultCode;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class CommonRespDto {
    private int code = ResultCode.SUCCESS.value();
    private String message;
}
