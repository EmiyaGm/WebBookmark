package com.gm.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gm.db.DB;
import com.gm.javabean.BookMark;

public class EditServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public EditServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		BookMark bm= new BookMark();
		bm.setAddress((String)request.getParameter("address"));
		bm.setTitle((String)request.getParameter("title"));
		bm.setType((String)request.getParameter("type"));
		Connection conn = DB.getConn();
		Statement stmt = DB.createStmt(conn);
		HttpSession session = request.getSession();
		bm.setUsername((String)session.getAttribute("username"));
		String sql="update bookmark set title='"+bm.getTitle()+"',type='"+bm.getType()+"' where username='"+bm.getUsername()+"' and address='"+bm.getAddress()+"';";
		try {
			stmt.execute(sql);
			sql="select * from type where type='"+bm.getType()+"';";
			ResultSet rs= DB.executeQuery(stmt, sql);
			String typesql=null;
			while(rs.next()){
				typesql=rs.getString("type");
			}
			if(bm.getType().equals(typesql)){
			    response.getWriter().print("修改成功,5秒之后跳转");
			    response.addHeader("refresh", "5;URL=list.jsp");
			    }else{
			    	sql="insert into type values('"+bm.getType()+"');";
					stmt.execute(sql);
					response.getWriter().print("修改成功,5秒之后跳转");
					response.addHeader("refresh", "5;URL=list.jsp");
			    }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			request.setAttribute("error", "修改失败");
		    RequestDispatcher dispatcher = request.getRequestDispatcher("list.jsp");
			dispatcher.forward(request, response);
		}
		
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
