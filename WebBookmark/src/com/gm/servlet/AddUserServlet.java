package com.gm.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gm.db.DB;
import com.gm.javabean.User;

public class AddUserServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddUserServlet() {
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

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		User user= new User();
		user.setUsername((String)request.getParameter("username"));
		user.setPassword((String)request.getParameter("password"));
		user.setEmail((String)request.getParameter("em"));
		if(user.getEmail()==null){
			user.setEmail("");
		}
		Connection conn = DB.getConn();
		Statement stmt = DB.createStmt(conn);
		user.setUsermark("1");
		String sql="insert into user values ('"+user.getUsername()+"','"+user.getPassword()+"','"+user.getEmail()+"','"+user.getUsermark()+"');";
		try {
			    stmt.execute(sql);
				response.getWriter().print("添加成功,5秒之后跳转");
				HttpSession session = request.getSession();
				response.addHeader("refresh", "5;URL=user.jsp");

			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			response.getWriter().print("用户名重复,5秒之后跳转");
			response.addHeader("refresh", "5;URL=adduser.jsp");
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
