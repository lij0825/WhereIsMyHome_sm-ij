package com.ssafy.controller;

import java.io.IOException;
import java.util.List;

import com.ssafy.dto.User;
import com.ssafy.service.AttentionService;
import com.ssafy.service.HouseService;
import com.ssafy.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

	private UserService service = UserService.getInstance();
	private AttentionService attService = AttentionService.getInstance();
	private HouseService houseService = HouseService.getInstance();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("asd");
		String act = request.getParameter("act");


		if ("loginForm".equals(act)) {
			request.getRequestDispatcher("/user/login.jsp").forward(request, response);
		} else if ("logout".equals(act)) {
			request.getSession().invalidate();
			request.setAttribute("msg", "완료되었습니다");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		} else if ("joinForm".equals(act)) {
			request.getRequestDispatcher("/user/join.jsp").forward(request, response);
		} else if ("mypage".equals(act)) {
			User user = (User) request.getSession().getAttribute("loginInfo");
			String id = user.getId();
			List<Long> attList = attService.findAptList(id); // 아파트 코드만 따왔어
//            request.setAttribute("houseInfoList", houseService.getAptInfo(attList));
			request.setAttribute("attList", attList);
			System.out.println(attList.size());
			request.getRequestDispatcher("/user/mypage.jsp").forward(request, response);
		} else if ("checkForm".equals(act)) {
			request.getRequestDispatcher("/user/checkpw.jsp").forward(request, response);
		} else if ("modifyForm".equals(act)) {
			request.getRequestDispatcher("/user/modifyForm.jsp").forward(request, response);
		} 

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String act = request.getParameter("act");
		System.out.println("asd");
		try {
			if ("login".equals(act)) {
				String id = request.getParameter("userid"); // 인풋 태그에 name이
				String pw = request.getParameter("userpw");

				User userinfo = service.find(id, pw);// 로그인 실패 시 exception 던짐.
				
				if (userinfo != null) {
					HttpSession session = request.getSession();
					session.setAttribute("loginInfo", userinfo);
					request.setAttribute("msg", "로그인 완료");
					request.getRequestDispatcher("index.jsp").forward(request, response);
				} else
					System.out.println("로그인실패");
			} else if ("join".equals(act)) {
				String id = request.getParameter("userid"); // 인풋 태그에 name이
				String pw = request.getParameter("userpw");
				String name = request.getParameter("username");
				String address = request.getParameter("address");

				User newUser = new User(id, pw, name, address);

				if (service.join(newUser) == 1) {
//                    request.setAttribute("msg", "가입 완료");
					request.getRequestDispatcher("index.jsp").forward(request, response);
				}
			} else if ("checkpass".equals(act)) {
				String pw = request.getParameter("userpw");

				HttpSession session = request.getSession();
				User user = (User) session.getAttribute("loginInfo");
				String id = user.getId();
				System.out.println(id + " " + pw);
				User infocheck = service.find(id, pw);
				if (infocheck != null) {
					request.getRequestDispatcher("user/modifyInfo.jsp").forward(request, response);
				} else {
					request.getRequestDispatcher("/user/checkpw.jsp").forward(request, response);

				}
			} else if ("modify".equals(act)) {
				HttpSession session = request.getSession();
				User user = (User) session.getAttribute("loginInfo");
				String id = user.getId();
				String pw = request.getParameter("userpw"); // 변경 비밀번호
				String chpw = request.getParameter("userpwCheck"); // 비밀번호 확인
				String add = request.getParameter("address");
				if (!pw.equals(chpw)) {
					// 똑같지 않으면
					request.setAttribute("msg", "수정 실패");
					request.getRequestDispatcher("user/modifyInfo.jsp").forward(request, response);
				} else {
					service.modifyInfo(chpw, add, id);
					User upUser = service.find(id, chpw);
					session = request.getSession();
					session.setAttribute("loginInfo", upUser);

					request.setAttribute("msg", "수정 완료");
					System.out.println("수정완");
					request.getRequestDispatcher("user/mypage.jsp").forward(request, response);
				}
			} else if ("delete".equals(act)) {
				HttpSession session = request.getSession();
				User user = (User) session.getAttribute("loginInfo");
				String id = user.getId();
				
				service.deleteInfo(id);
				
				session.invalidate();

				response.sendRedirect(request.getContextPath() + "/index.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", e.getMessage()); // 실패 메시지 alert한테 보내기
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}

	}

}