package com.gyuha.user2.errorhandler;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
public class GlobalErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        if (status != null) {
            int statusCode = Integer.parseInt(status.toString());

            if (statusCode == HttpStatus.NOT_FOUND.value()) {
                log.info("From GlobalErrorController, 404 Not Found Error \n"+ statusCode);
                return "redirect:/customError";
            } else if (statusCode == HttpStatus.BAD_REQUEST.value()) {
                log.info("From GlobalErrorController, 400 Bad Request Error \n" + statusCode);
                return "redirect:/customError";
            } else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                log.info("From GlobalErrorController, 500 Internal Server Error \n"+ statusCode);
                return "redirect:/customError";
            } else {
                log.info("From GlobalErrorController, Unknown Error: \n" + statusCode);
                return "redirect:/customError";
            }
        }

        return "error/customError";
    }
}