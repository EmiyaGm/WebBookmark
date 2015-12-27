<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Login</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link href="css/login.css" rel="stylesheet" type="text/css">
  </head>
  
  <body>
<div class="login">
    <form id="form" method="post" action="/WebBookmark/login.do">
      <h1 style="text-align:center"><br />用户登录<br /><br /><br /></h1>
    	<div class="login_form">
    	  <%String login=(String)session.getAttribute("login");
          if(login=="unlogining"){
              out.print("<p>error username or password</p>"); }
         %>
		  <div class="user">
            <input class="text_value" type="text" name="username" id="username"/>
            <input class="text_value" type="password" name="password" id="password"/>
		  </div>
        
        <input class="button" type="submit" value="login" id="submit" />
        </div>
        <div id="tip">
        <br />
        <input type="radio" name="user" value="user" checked="checked"/>用户
        <input type="radio" name="user" value="admin" />管理员
         <br/>
        <a href="regist.jsp">regist</a>
        </div>
        
    </form>
    </div>
  </body>
</html>
