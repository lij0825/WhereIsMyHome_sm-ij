package com.ssafy.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.ssafy.dto.BoardDto;
import com.ssafy.service.BoardService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/board")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String root;
	private BoardService boardService = BoardService.getInstance();

	@Override
	public void init() throws ServletException {
		root = getServletContext().getContextPath();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		System.out.println("DEBUG : " + action);

		switch (action) {
		case "list":
			list(request, response);
			break;
		case "mvpost":
			mvpost(request, response);
			break;
		case "post":
			post(request, response);
			break;
		case "view":
			view(request, response);
			break;
		}

	}

	protected void view(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boardNo = request.getParameter("post_no");

		try {
			BoardDto boardDto = boardService.view(boardNo);
			request.setAttribute("boardDto", boardDto);
			request.getRequestDispatcher("/board/view.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			List<BoardDto> list = new ArrayList<>();
			list = boardService.getInstance().list();
			request.setAttribute("list", list);
			request.getRequestDispatcher("/board/list.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void mvpost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect(root + "/board/post.jsp");
	}

	protected void post(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String userId = request.getParameter("userId");

		BoardDto boardDto = new BoardDto();
		boardDto.setSubject(subject);
		boardDto.setContent(content);
		boardDto.setUserId(userId);

		System.out.println(boardDto);

		try {
			boardService.post(boardDto);
		} catch (SQLException e) {

			e.printStackTrace();
		}

		list(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
