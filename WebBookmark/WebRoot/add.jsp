<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="com.gm.db.DB"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Add</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<style type="text/css">
		body{
			font:14px/28px "微软雅黑";
		}
		.contact *:focus{outline :none;}
		.contact{
			width: 700px;
			height: auto;
			background: #f6f6f6;
			margin: 40px auto;
			padding: 10px;
		}
		.contact ul {
			width: 650px;
			margin: 0 auto;
		}
		.contact ul li{
			border-bottom: 1px solid #dfdfdf;
			list-style: none;
			padding: 12px;
		}
		.contact ul li label {
			width: 120px;
			display: inline-block;
			float: left;
		}
		.contact ul li input[type=text],.contact ul li input[type=password]{
			width: 220px;
			height: 25px;
			border :1px solid #aaa;
			padding: 3px 8px;
			border-radius: 5px;
		}
		.contact ul li input:focus{
			border-color: #c00;
			
		}
		.contact ul li input[type=text]{
			transition: padding .25s;
			-o-transition: padding  .25s;
			-moz-transition: padding  .25s;
			-webkit-transition: padding  .25s;
		}
		.contact ul li input[type=password]{
			transition: padding  .25s;
			-o-transition: padding  .25s;
			-moz-transition: padding  .25s;
			-webkit-transition: padding  .25s;
		}
		.contact ul li input:focus{
			padding-right: 70px;
		}
		.btn{
			position: relative;
			left: 300px;
		}
		h1{
		  text-align:center;
		}
  </style>

  </head>
  <%
  String username=(String)session.getAttribute("username");
  if(username==null){
      response.sendRedirect("warning.jsp");
  }
  Connection conn = DB.getConn();
  Statement stmt = DB.createStmt(conn);
  String sql="select * from type;";
  ResultSet rs=null; 
		rs = DB.executeQuery(stmt, sql);
		List<String> typelist = new ArrayList<String>();
			try {
			    while(rs.next()){
					typelist.add(rs.getString("type"));
			        }
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				DB.close(conn);

   %>
  <body>
    <h1>添加书签</h1>
    <p><%if(request.getAttribute("error")!=null){
        out.print(request.getAttribute("error"));} %></p>
    <div class="contact" >
      <form method="post" action="/WebBookmark/add.do" name="form1">
        <ul>
          <li>
            <label>address:http://</label><input type="text" name="address" />
          </li>
          <li>
            <label>title:</label><input type="text" name="title" />
          </li>
          <li>
            <label>type:</label><select name="type" value="${type.addtype}">
                 <%for(int i=0;i<typelist.size();i++){ %>
                 <option value="<%out.print(typelist.get(i)); %>" <%out.print("${type.addtype eq \""+typelist.get(i)+"\"?\"selected='selected'\":\"\"}"); %> /><%out.print(typelist.get(i));}%>
             </select>
          </li>
          <li>
            <label>添加分类:</label><input type="text" name="addtype" />
          </li>
        </ul>
          <b class="btn">
            <input type="submit" value="提交" />
          </b>
      </form>
    </div>
    <div style="text-align:center;">
      <p><a href="index.jsp">返回主页</a></p>
    </div>
  </body>
</html>
