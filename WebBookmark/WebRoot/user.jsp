<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="com.gm.db.DB"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>user</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style>
        body{
            padding:0;
            margin:0;
            font:normal 12px/24px "\5FAE\8F6F\96C5\9ED1";
            color:#444;
            }
        table{
            border:0;
            margin:100px auto 0;
            text-align:center;
            border-collapse:collapse;
            border-spacing:0;
            }
        table th{
            background:#0090D7;
            font-weight:normal;
            font-size:14px;
            color:#FFF;
            }
        table tr:nth-child(odd){
            background:#F4F4F4;
            }
        table td:nth-child(even){
            color:#C00;
            }
        table tr:hover{
            background:#73B1E0;
            color:#FFF;
            }
        table td,table th{
            border:1px solid #EEE;
            }
    </style>
  </head>
  
  <body>
    <%if(session.getAttribute("userMark").equals("admin")&&session.getAttribute("login").equals("islogining")){
    Connection conn = DB.getConn();
		Statement stmt = DB.createStmt(conn);
		String sql="select * from user;";
		ResultSet rs = DB.executeQuery(stmt, sql);
		List<String> user = new ArrayList<String>();
		if(rs.next()){
		    user.add(rs.getString("username")+","+rs.getString("password")+","+rs.getString("email")+","+rs.getString("usermark"));
		     try {
			    while(rs.next()){
				    user.add(rs.getString("username")+","+rs.getString("password")+","+rs.getString("email")+","+rs.getString("usermark"));
			    }
		    } catch (SQLException e) {
			    // TODO Auto-generated catch block
			    e.printStackTrace();
		    }
		   
		}else{
		    out.print("<script>alert(\"no users\");</script>");
		   
		}
		DB.close(rs);%>
		<form action="/WebBookmark/deleteuser.do" method="post">
		<table>
          <tr>
            <th>username</th>
            <th>password</th>
            <th>email</th>
            <th>usermark</th>
            <th>delete</th>
          </tr>
		  <%for(int i=0;i<user.size();i++){
              String[] us=user.get(i).split(",");
          %>
          <tr>
            <td><%out.print("<input type=\"text\" value=\""+us[0]+"\" name=\"username\" readonly />");%> </td>
            <td><%out.print(us[1]); %></td>
            <td><%out.print(us[2]); %></td>
            <td><%if(us[3].toString().equals("0")){out.print("admin");}else{out.print("user");} %></td>
            <td><%if(us[3].toString().equals("1")){out.print("<input type=\"submit\" value=\"删除\" />");} %></td>
        </tr>
		        <%} %>
    </table>
    </form>
    <div style="text-align:center;">
      <a href="adduser.jsp">添加用户</a>
    </div>
		<%
    }else{
        out.print("你的权限不够");
        }
     %>
     <div style="text-align:center;">
      <p><a href="index.jsp">返回主页</a></p>
    </div>
  </body>
</html>
