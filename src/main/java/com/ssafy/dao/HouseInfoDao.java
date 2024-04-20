package com.ssafy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.ssafy.dto.HouseInfo;
import com.ssafy.util.DBUtil;

@Repository
public class HouseInfoDao {
	
	private DataSource dataSource;
	private DBUtil util;

	public HouseInfoDao(DataSource dataSource, DBUtil util) {
		super();
		this.dataSource = dataSource;
		this.util = util;
	}

	public HouseInfo selectOne(String dongCode) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		HouseInfo result = null;

		try {
			conn = dataSource.getConnection();
			String sql = "select * "
					+ " from houseinfo where dongCode = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dongCode);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				int idx = 1;
				result = new HouseInfo(rs.getLong(idx++), rs.getInt(idx++), rs.getString(idx++), rs.getString(idx++),
						rs.getString(idx++), rs.getString(idx++), rs.getString(idx++), rs.getString(idx++),
						rs.getString(idx++), rs.getString(idx++), rs.getString(idx++), rs.getString(idx++),
						rs.getString(idx++), rs.getString(idx++), rs.getString(idx++), rs.getString(idx++),
						rs.getString(idx++), rs.getString(idx++), rs.getString(idx++));
			}

		} finally {
			util.close(rs, pstmt, conn);
		}

		return result;
	}

	public HouseInfo selectOneByAptCode(String aptCode) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		HouseInfo result = null;

		try {
			conn = dataSource.getConnection();
			String sql = "select * "
					+ " from houseinfo where aptCode = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, Long.parseLong(aptCode));
			rs = pstmt.executeQuery();

			if (rs.next()) {
				int idx = 1;
				result = new HouseInfo(rs.getLong(idx++), rs.getInt(idx++), rs.getString(idx++), rs.getString(idx++),
						rs.getString(idx++), rs.getString(idx++), rs.getString(idx++), rs.getString(idx++),
						rs.getString(idx++), rs.getString(idx++), rs.getString(idx++), rs.getString(idx++),
						rs.getString(idx++), rs.getString(idx++), rs.getString(idx++), rs.getString(idx++),
						rs.getString(idx++), rs.getString(idx++), rs.getString(idx++));
			}

		} finally {
			util.close(rs, pstmt, conn);
		}

		return result;
	}

	public List<Long> selectAllAptCode(String dongCode) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Long> result = new ArrayList<Long>();

		try {
			conn = dataSource.getConnection();
			String sql = "select aptCode from houseinfo where dongCode = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dongCode);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				result.add(rs.getLong(1));
			}

		} finally {
			util.close(rs, pstmt, conn);
		}

		return result;
	}

}
