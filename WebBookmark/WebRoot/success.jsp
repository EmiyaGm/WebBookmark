<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>success</title>
    
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
        table tr:nth-child(5){
            background:#73B1E0;
            color:#FFF;
            }
        table tr:hover{
            background:#73B1E0;
            color:#FFF;
            }
        table td,table th{
            border:1px solid #EEE;
            }
        h1{
            text-align:center;
        }
    </style>

  </head>
  
  <body>
    <h1>add success</h1><br>
    <%String address=(String)request.getAttribute("address");
      String title=(String)request.getAttribute("title");
      String type=(String)request.getAttribute("type");
     %>
     <table>
         <tr>
             <td>address:http://<%out.print(address); %></td>
         </tr>
         <tr>
             <td>title:<%out.print(title); %></td>
         </tr>
         <tr>
             <td>type:<%out.print(type); %></td>
         </tr>
     </table>
     <div style="text-align:center;">
      <p><a href="index.jsp">返回主页</a></p>
    </div>
  </body>
</html>
