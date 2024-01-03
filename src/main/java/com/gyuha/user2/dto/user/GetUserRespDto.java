package com.gyuha.user2.dto.user;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.gyuha.user2.dto.CommonRespDto;
import com.gyuha.user2.vo.UserVo;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class GetUserRespDto extends CommonRespDto {
    private UserVo userDetail;
}
