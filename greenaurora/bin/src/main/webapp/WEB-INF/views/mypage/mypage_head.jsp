<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<header>
        <div class="inner">
            <!-- logo -->
            <a href="/main" class="logo">
                <img src="/images/logo.png" alt="logo">
            </a>

            <!-- sub-menu -->
            <div class="sub-menu">
                <ul class="menu">
                    <li>
                        <div class="qr">
                            <a href="#">
                                <img src="/images/v39_280.png" alt="qr">
                            </a>
                        </div>
                    </li>
                    <li>
                        <div class="alarm">
                            <a href="#">
                                <div class="alarm_bg">3</div>
                                <img src="/images/v39_274.png" alt="alarm">
                            </a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </header>