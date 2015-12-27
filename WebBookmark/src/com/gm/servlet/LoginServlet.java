package com.gm.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gm.db.DB;

public class LoginServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public LoginServlet() {
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
	@SuppressWarnings("null")
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String userMark=request.getParameter("user");
		HttpSession session = request.getSession();	
		Connection conn = DB.getConn();
		Statement stmt = DB.createStmt(conn);
		String sql="select * from user where username='"+username+"';";
		ResultSet rs = DB.executeQuery(stmt, sql);	
		try {
		if(rs.next()){
			if(userMark.equals("admin")&&rs.getString("password").equals(password)&&rs.getString("userMark").equals("0")){
			session.setAttribute("username", username);
			session.setAttribute("userMark", userMark);
			session.setAttribute("login", "islogining");
			response.sendRedirect("user.jsp");
			}else
			if(rs.getString("password").equals(password)){
				response.sendRedirect("index.jsp");
				session.setAttribute("login", "islogining");
				session.setAttribute("username", username);
			}else{
				response.sendRedirect("login.jsp");
				session.setAttribute("login", "unlogining");
			}
		} else {
			session.setAttribute("login", "unlogining");
			response.sendRedirect("login.jsp");
			
		}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
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
