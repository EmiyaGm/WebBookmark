<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="com.gm.db.DB"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//每页显示记录数
int PageSize = 5;
int StartRow = 0; //开始显示记录的编号 
int PageNo=0;//需要显示的页数
int CounterStart=0;//每页页码的初始值
int CounterEnd=0;//显示页码的最大值
int RecordCount=0;//总记录数;
int MaxPage=0;//总页数
int PrevStart=0;//前一页
int NextPage=0;//下一页
int LastRec=0; 
int LastStartRecord=0;//最后一页开始显示记录的编号 

//获取需要显示的页数，由用户提交
if(request.getParameter("PageNo")==null){ //如果为空，则表示第1页
  if(StartRow == 0){
     PageNo = StartRow + 1; //设定为1
  }
}else{
  PageNo = Integer.parseInt(request.getParameter("PageNo")); //获得用户提交的页数
  StartRow = (PageNo - 1) * PageSize; //获得开始显示的记录编号
}

//因为显示页码的数量是动态变化的，假如总共有一百页，则不可能同时显示100个链接。而是根据当前的页数显示
//一定数量的页面链接

//设置显示页码的初始值!!
  if(PageNo % PageSize == 0){
   CounterStart = PageNo - (PageSize - 1);
  }else{
   CounterStart = PageNo - (PageNo % PageSize) + 1;
  }

CounterEnd = CounterStart + (PageSize - 1);
%>

<!DOCTYPE html>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My List</title>
    
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
	<script language="javascript">
        function Edit(){   
               //对应的Action路径
	        form.action="/WebBookmark/edit.do";
	        document.form.submit();
        }   
        function Delete(id){   
              ////对应的Action路径
            document.getElementById("address"+id).name="address";
            document.getElementById("title"+id).name="title";
	        form.action="/WebBookmark/delete.do";
	        document.form.submit();
        }
        function sn(id){
            document.getElementById(id).name="type";
            document.getElementById("address"+id).name="address";
            document.getElementById("title"+id).name="title";
        }   
  </script>

  </head>
  
  <body>
  <%
  String username=(String)session.getAttribute("username");
  if(username==null){
      response.sendRedirect("warning.jsp");
  }
  Connection conn = DB.getConn();
		Statement stmt = DB.createStmt(conn);
		String sql="select * from bookmark where username='"+username+"';";
		ResultSet rs = DB.executeQuery(stmt, sql);
		rs.last();
		RecordCount = rs.getRow();
		sql="select * from bookmark where username='"+username+"' limit "+StartRow+","+PageSize+";";
		rs = DB.executeQuery(stmt, sql);
		MaxPage = RecordCount % PageSize;
        if(RecordCount % PageSize == 0){
            MaxPage = RecordCount / PageSize;
        }else{
            MaxPage = RecordCount/PageSize+1;
        }
		List<String> bookmark = new ArrayList<String>();
		if(rs.next()){
		    bookmark.add(rs.getString("address")+","+rs.getString("title")+","+rs.getString("type"));
		     try {
			    while(rs.next()){
				    bookmark.add(rs.getString("address")+","+rs.getString("title")+","+rs.getString("type"));
			    }
		    } catch (SQLException e) {
			    // TODO Auto-generated catch block
			    e.printStackTrace();
		    }
		   
		}else{
		    out.print("<script>alert(\"no bookmarks\");</script>");
		   
		}
		sql="select * from type;";
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
		DB.close(rs);
		if(request.getAttribute("error")!=null){
		out.print(request.getAttribute("error"));}
   %>
    <form method="post" name="form" action="">
    <table width="100%" border="0">
      <tr>
        <th>
        <font size=4><%="总共"+RecordCount+"条记录 - 当前页："+PageNo+"/"+MaxPage %></font>
        </th>
      </tr>
    </table>
    <table>
        <tr>
            <th>address</th>
            <th>title</th>
            <th>type</th>
            <th>修改</th>
            <th>删除</th>
            <th>点此进入</th>
        </tr>
        
        <%for(int i=0;i<bookmark.size();i++){
              String[] bm=bookmark.get(i).split(",");
         %>
        <tr>
            <td><%out.print("<input type=\"text\" value=\""+bm[0]+"\" name=\"\" id=\"address"+i+"\" readonly />"); %> </td>
            <td><%out.print("<input type=\"text\" value=\""+bm[1]+"\" name=\"\" id=\"title"+i+"\" onchange=\"sn("+i+")\" />"); %></td>
            <td><select name="" id="<%out.print(i); %>" value="${type.addtype}" onchange="sn(<%out.print(i); %>)">
                 <%for(int j=0;j<typelist.size();j++){ %>
                 <option value="<%out.print(typelist.get(j)); %>" <%out.print("${type.addtype eq \""+typelist.get(j)+"\"?\"selected='selected'\":\"\"}"); if(typelist.get(j).equals(bm[2])){out.print(" selected=\"selected\"");}%> /><%out.print(typelist.get(j));}%>
             </select></td>
            <td><%out.print("<input type=\"submit\" value=\"修改\" onclick=\"Edit()\" />"); %></td>
            <td><%out.print("<input type=\"submit\" value=\"删除\" onclick=\"Delete("+i+")\" />"); %></td>
            <td><a href="http://<% out.print(bm[0]);%>">点此进入</a></td>
        </tr>
        <%} %>
    </table>
    </form>

    <table width="100%" border="0">
      <tr>
        <th><div align="center">
    <%
      out.print("<font size=4>");
      //显示第一页或者前一页的链接
      //如果当前页不是第1页，则显示第一页和前一页的链接
      if(PageNo != 1){
        PrevStart = PageNo - 1;
        out.print("<a href=list.jsp?PageNo=1>第一页 </a>: ");
        out.print("<a href=list.jsp?PageNo="+PrevStart+">前一页</a>");
      }
      out.print("[");

      //打印需要显示的页码
      for(int c=CounterStart;c<=CounterEnd;c++){
        if(c <MaxPage){
          if(c == PageNo){
            if(c %PageSize == 0){
              out.print(c);
            }else{
            out.print(c+" ,");
         }
       }else if(c % PageSize == 0){
         out.print("<a href=list.jsp?PageNo="+c+">"+c+"</a>");
     }else{
         out.print("<a href=list.jsp?PageNo="+c+">"+c+"</a> ,");
     }
     }else{
       if(PageNo == MaxPage){
        out.print(c);
         break;
     }else{
        out.print("<a href=list.jsp?PageNo="+c+">"+c+"</a>");
     break;
     }
    }
   }

   out.print("]");;

   if(PageNo < MaxPage){ //如果当前页不是最后一页，则显示下一页链接
      NextPage = PageNo + 1;
      out.print("<a href=list.jsp?PageNo="+NextPage+">下一页</a>");
   }

//同时如果当前页不是最后一页，要显示最后一页的链接
   if(PageNo < MaxPage){
     LastRec = RecordCount % PageSize;
     if(LastRec == 0){
        LastStartRecord = RecordCount - PageSize;
     }
      else{
        LastStartRecord = RecordCount - LastRec;
     }

     out.print(":");
     out.print("<a href=list.jsp?PageNo="+MaxPage+">最后一页</a>");
    }
    out.print("</font>");
%>
</div>
</th>
</tr>
</table>
    <div style="text-align:center;">
      <p><a href="index.jsp">返回主页</a></p>
    </div>
  </body>
</html>
