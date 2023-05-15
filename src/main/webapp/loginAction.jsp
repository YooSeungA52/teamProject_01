<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="base.dao.JoinDao"%>
<%@ page import="java.io.PrintWriter"%>

<jsp:useBean id="user" class="base.dto.JoinDto" scope="page" />
<jsp:setProperty name="user" property="userID" param="userID" />
<jsp:setProperty name="user" property="userPassword"
	param="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset= UTF-8">
<% request.setCharacterEncoding("UTF-8"); %>
<title>로그인 페이지</title>
</head>
<body>
	<%	
        String userID = null;
        if(session.getAttribute("userID") != null) {
            userID = (String) session.getAttribute("userID");
        }
        if (userID != null) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 로그인이 되어있습니다.')");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
        
        JoinDao joinDao = new JoinDao();
        int result = joinDao.login(user.getUserID(), user.getUserPassword());
        if (result == 1) {
            session.setAttribute("userID", user.getUserID());
            // 로그인 상태 유지를 위해 세션 만료 시간 설정
            int sessionExpiryTime = 60 * 60 * 24 * 7; // 7일로 설정
            session.setMaxInactiveInterval(sessionExpiryTime);
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("location.href = 'main.jsp'");
            script.println("</script>");
        }
        else if (result == 0) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('비밀번호가 틀립니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
        else if (result == -1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('존재하지 않는 아이디입니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
        else if (result == -2) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('데이터베이스 오류가 발생했습니다.')");
            script.println("history.back()");
            script.println("</script>");
        }
    %>
</body>
</html>
