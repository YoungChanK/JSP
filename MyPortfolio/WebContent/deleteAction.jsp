<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- DAO값을 얻어오기 위한 파일 import -->
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<!-- 출력문 -->
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>


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
  }
	// bbsID 초기값 선언;
	int bbsID = 0;
	// 업데이트가 되기위해 업데이트할 리스트의 순번이 정확히 파악되어야 한다.
	// 값을 받아와서 정수로 바꿔 값을 변환하여 넣는다
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}

	// 업데이트시 만약 순번이 0이라면 유효하지 않다고 기재
	if (bbsID == 0) {
		// 스크립트문 출력
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않는 정봉입니다.')");
		script.println("'location.href='bbs.jsp'");
		script.println("</script>");
	}

	// DAO의 정보를 받아와야 한다.
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("'location.href='bbs.jsp'");
		script.println("</script>");
	}
	
	else{
    BbsDAO bbsDAO = new BbsDAO();
    //타이틀과 아이값 그리고 콘텐츠내용이 정상적으로 들어갔을 경우
    //result변수안에 0이상의 값이 포함되게 된다. (성공적 기본값 1)
    int result = bbsDAO.delete(bbsID);
    //데이터베이스 실패시
    if(result == -1){
     PrintWriter script = response.getWriter();
     script.println("<script>");
     script.println("alert('글 삭제에 실패했다')");
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
  
 
 %>
 
 
</body>
</html>