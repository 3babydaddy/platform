package com.tfkj.framework.core.exception;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Enumeration;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import com.tfkj.framework.core.utils.Exceptions;
import com.tfkj.framework.system.utils.LogUtils;

public class JsonMappingExceptionResolver extends SimpleMappingExceptionResolver {

    private Properties exceptionStatus;

    @Override
    protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {

        if (handler == null) {
            return null;
        }
        HandlerMethod handlerMethod = (HandlerMethod) handler;

        Method method = handlerMethod.getMethod();

        if (method == null) {
            return null;
        }

        ResponseBody responseBodyAnn = AnnotationUtils.findAnnotation(method, ResponseBody.class);
        if (responseBodyAnn != null) {
            ModelAndView mv = new ModelAndView();
            try {
                String status = findMatchingStatus(exceptionStatus, ex);
                int httpStatus = 500;
                if (status == null || "".equals(status)) {
                    httpStatus = Integer.parseInt(status);
                }
                response.setStatus(httpStatus);
                response.setContentType(MediaType.APPLICATION_JSON_VALUE);
                response.setCharacterEncoding("UTF-8");
                response.setHeader("Cache-Control", "no-cache, must-revalidate");
                response.getWriter().write("{\"exception\":\"" + Exceptions.getStackTraceAsString(ex) + "\"}");
            } catch (IOException e) {
                return null;
            }
            LogUtils.saveLog(request, handler, ex, null);
            return mv;
        } else {
            // Expose ModelAndView for chosen error view.
            String viewName = determineViewName(ex, request);
            if (viewName != null) {
                // Apply HTTP status code for error views, if specified.
                // Only apply it if we're processing a top-level request.
                Integer statusCode = determineStatusCode(request, viewName);
                if (statusCode != null) {
                    applyStatusCodeIfPossible(request, response, statusCode);
                }
                LogUtils.saveLog(request, handler, ex, null);
                return getModelAndView(viewName, ex, request);
            } else {
                return null;
            }
        }
    }

    protected String findMatchingStatus(Properties exceptionStatus, Exception ex) {
        String status = null;
        String dominantMapping = null;
        int deepest = Integer.MAX_VALUE;
        for (Enumeration<?> names = exceptionStatus.propertyNames(); names.hasMoreElements();) {
            String exceptionMapping = (String) names.nextElement();
            int depth = getDepth(exceptionMapping, ex);
            if (depth >= 0 && (depth < deepest || (depth == deepest && dominantMapping != null && exceptionMapping.length() > dominantMapping.length()))) {
                deepest = depth;
                dominantMapping = exceptionMapping;
                status = exceptionStatus.getProperty(exceptionMapping);
            }
        }
        return status;
    }

    public void setExceptionStatus(Properties exceptionStatus) {
        this.exceptionStatus = exceptionStatus;
    }

}