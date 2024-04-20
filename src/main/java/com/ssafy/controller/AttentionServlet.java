package com.ssafy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import com.google.gson.Gson;
import com.ssafy.dto.Attention;
import com.ssafy.dto.User;
import com.ssafy.service.AttentionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/attention")
public class AttentionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static AttentionService service = AttentionService.getInstance();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("act");
		String aptCode = request.getParameter("aptCode");
		User user = (User) request.getSession().getAttribute("loginInfo");

		System.out.println(action);

		if ("addAttention".equals(action)) {
			System.out.println("ATTENTION - addAttention");
			service.addAttention(new Attention(user.getId(), Long.parseLong(aptCode)));
			request.setAttribute("aptCode", aptCode);
			request.getRequestDispatcher("success/successAttention.jsp").forward(request, response);

		} else if ("checkAtt".equals(action)) {
			System.out.println("ATTENTION - checkAtt");
			try {
				Attention a = service.getAttention(aptCode, user.getId());
				response.setContentType("text/plain;charset=utf-8");
				Gson gs = new Gson();
				PrintWriter out = response.getWriter();
				out.println(gs.toJson(a));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("delete".equals(action)) {
			System.out.println("ATTENTION - delete");
			service.delete(new Attention(user.getId(), Long.parseLong(aptCode)));
			request.setAttribute("msg", "찜 삭제 완료!!");
			request.getRequestDispatcher("user?act=mypage").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
