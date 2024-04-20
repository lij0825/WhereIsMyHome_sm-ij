package com.ssafy.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.dao.HouseDealDao;
import com.ssafy.dao.HouseDetailDao;
import com.ssafy.dao.HouseInfoDao;
import com.ssafy.dto.HouseDeal;
import com.ssafy.dto.HouseDetailDto;
import com.ssafy.dto.HouseInfo;

@Service
public class HouseService {

	private final HouseInfoDao houseInfoDao;
	private final HouseDealDao houseDealDao;
	private final HouseDetailDao houseDetailDao;

	public HouseService(HouseInfoDao houseInfoDao, HouseDealDao houseDealDao, HouseDetailDao houseDetailDao) {
		super();
		this.houseInfoDao = houseInfoDao;
		this.houseDealDao = houseDealDao;
		this.houseDetailDao = houseDetailDao;
	}

	// 동코드, 연, 월이 일치하는 housedeal 리스트 반환
	public List<HouseDeal> getHouseDealList(String dongCode, String year, String month) throws SQLException {
		List<HouseDeal> result = new ArrayList<HouseDeal>();

		List<Long> codes = houseInfoDao.selectAllAptCode(dongCode);
		for (long code : codes) {
			result.addAll(houseDealDao.selectAllByAptCode(code, year, month));
		}

		return result;
	}

	public HouseInfo getAptName(String aptCode) throws SQLException {
		return houseInfoDao.selectOneByAptCode(aptCode);
	}

	public HouseDeal getHouseDeal(String no) throws SQLException {
		return houseDealDao.selectOne(no);
	}

	public List<HouseDetailDto> getHouseDetail(long aptCode) throws SQLException {
		return houseDetailDao.DetailList(aptCode);
	}

}
