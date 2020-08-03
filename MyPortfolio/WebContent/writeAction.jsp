<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- DAO값을 얻어오기 위한 파일 import -->
<%@ page import="bbs.BbsDAO" %>
<!-- 출력문 -->
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- 자바빈즈 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포트폴리오사이트</title>
</head>
<body>
 <% 
  // 로그인된 사람은 회원가입 할 수 없도록 조치
  String userID = null;
   //
   // 세션을 확인하여 아이디 값을 userID에 담아둔다.
  if(session.getAttribute("userID") != null){
    userID = (String) session.getAttribute("userID");  
  }
   
  // 로그인해라
  // 로그인 정보가 없을경우 로그인을 해라는 메세지가 나오도록 설정
  if(userID == null){
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('로그인을 하세요')");
    script.println("location.href='login.jsp'");
    script.println("</script>");
  }else{
   //타이틀이 빠지거나 또는 콘텐츠 사항에 글이 없을때 나오는 경고문
   if(bbs.getBbsTitle()==null || bbs.getBbsContent()==null){
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('입력이 안 된 사항이 있습니다.')");
    script.println("history.back()");
    script.println("</script>");
   } else{
    BbsDAO bbsDAO = new BbsDAO();
    //타이틀과 아이값 그리고 콘텐츠내용이 정상적으로 들어갔을 경우
    //result변수안에 0이상의 값이 포함되게 된다. (성공적 기본값 1)
    int result = bbsDAO.write(bbs.getBbsTitle(), 
      userID, bbs.getBbsContent());
    //데이터베이스 실패시
    if(result == -1){
     PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('글쓰기 실패.')");
     script.println("history.back()");
     script.println("</script>");
    }else{
     //모든 사항적 조건에 맞도록 글쓰기 및 빈 영역이 없다면 bbs페이지로 넘김
     PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("location.href='bbs.jsp'");
     script.println("</script>");
    }
   }
  }
 
 %>
 
 
</body>
</html>