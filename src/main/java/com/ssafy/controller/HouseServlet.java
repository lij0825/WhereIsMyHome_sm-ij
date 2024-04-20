package com.ssafy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import com.google.gson.Gson;
import com.ssafy.dto.HouseDeal;
import com.ssafy.dto.HouseDetailDto;
import com.ssafy.dto.HouseInfo;
import com.ssafy.service.HouseService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/house")
public class HouseServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static HouseService service = HouseService.getInstance();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("act");

		System.out.println(action);

		if ("search".equals(action)) {
			System.out.println("HOUSE - search");

			String sido = request.getParameter("sido");
			String gugun = request.getParameter("gugun");
			String dong = request.getParameter("dong");
			String year = request.getParameter("year");
			String month = request.getParameter("month");

			System.out.println(sido + " " + gugun + " " + dong + " " + year + " " + month + " ");

			try {
				List<HouseDeal> houseDealList = service.getHouseDealList(dong, year, month);
				request.setAttribute("houseDealList", houseDealList);
				request.setAttribute("resultSize", houseDealList.size());

				if (houseDealList.size() != 0) {
					Long aptcode = houseDealList.get(0).getAptCode();
					request.setAttribute("dongName", service.getAptName(aptcode + "").getDong());
					System.out.println(service.getAptName(aptcode + "").getDong());
				}
				request.setAttribute("sido", sido);
				request.setAttribute("gugun", gugun);
				request.setAttribute("dong", dong);
				request.setAttribute("year", year);

				request.setAttribute("month", ("all".equals(month)) ? 1 : Integer.parseInt(month));
				request.getRequestDispatcher("index.jsp").forward(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}

		} else if ("getAptName".equals(action)) {
			System.out.println("HOUSE - getAptCode");
			String aptCode = request.getParameter("aptCode");
			try {
				HouseInfo houseInfo = service.getAptName(aptCode);
				System.out.println(houseInfo.getApartmentName());
				response.setContentType("text/plain;charset=utf-8");
				Gson gs = new Gson();
				PrintWriter out = response.getWriter();
				out.println(gs.toJson(houseInfo));
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} else if ("detail".equals(action)) {
			System.out.println("HOUSE - detail");
			long no = Long.parseLong(request.getParameter("no"));
			try {
				System.out.println(no);
				List<HouseDetailDto> houseDetailList = service.getHouseDetail(no);
				request.setAttribute("houseDeal", houseDetailList);
				request.getRequestDispatcher("house/detail.jsp").forward(request, response);
				
			} catch (SQLException e) {
				e.printStackTrace();
				request.getRequestDispatcher("error/error.jsp").forward(request, response);
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
