package com.gm.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gm.db.DB;
import com.gm.javabean.BookMark;

public class AddServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public AddServlet() {
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
		response.setContentType("text/html;charset=UTF-8");
		BookMark bm = new BookMark();

		bm.setAddress((String)request.getParameter("address"));
		bm.setTitle((String)request.getParameter("title"));
		bm.setType((String)request.getParameter("type"));
		bm.setAddtype((String)request.getParameter("addtype"));
		Connection conn = DB.getConn();
		Statement stmt = DB.createStmt(conn);
		HttpSession session = request.getSession();
		bm.setUsername((String)session.getAttribute("username"));
		try {
			if(bm.getAddtype()==null||bm.getAddtype()==""){
			 String sql="insert into bookmark values ('"+bm.getUsername()+"','"+bm.getAddress()+"','"+bm.getTitle()+"','"+bm.getType()+"');";
			 stmt.execute(sql);
		    }else{
			     String sql="insert into bookmark values ('"+bm.getUsername()+"','"+bm.getAddress()+"','"+bm.getTitle()+"','"+bm.getAddtype()+"');";
			     stmt.execute(sql);
			     sql="insert into type values ('"+bm.getAddtype()+"');";
			     stmt.execute(sql);
			    bm.setType(bm.getAddtype());
		    }
		    request.setAttribute("address", bm.getAddress());
		    request.setAttribute("title", bm.getTitle());
		    request.setAttribute("type", bm.getType());
		    RequestDispatcher dispatcher = request.getRequestDispatcher("success.jsp");
			dispatcher.forward(request, response);
		    } catch (Exception e) {
			// TODO Auto-generated catch block
			    request.setAttribute("error", "ÃÌº” ß∞‹");
			    RequestDispatcher dispatcher = request.getRequestDispatcher("add.jsp");
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
