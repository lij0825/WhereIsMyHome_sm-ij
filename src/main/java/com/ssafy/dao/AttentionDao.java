package com.ssafy.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.ssafy.dto.Attention;
import com.ssafy.util.DBUtil;


@Repository
public class AttentionDao {
	
	private DataSource dataSource;
	private DBUtil util;

	public AttentionDao(DataSource dataSource, DBUtil dbUtil) {
		super();
		this.dataSource = dataSource;
		this.util = dbUtil;
	}

	public List<Attention> selectId(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Attention> result = new ArrayList<>();

		try {
			conn = dataSource.getConnection();

			String sql = "select ano, id, aptCode from uattention where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				result.add(new Attention(rs.getInt(1), rs.getString(2), rs.getLong(3)));
			}

		} catch (SQLException e) {
			System.out.println("attention find error");
			e.printStackTrace();

		} finally {
			util.close(rs, conn, pstmt);
		}
		return result;
	}

	public int insert(Attention attention) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = dataSource.getConnection();
			String sql = "insert into uattention (id, aptCode) values(?, ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, attention.getId());
			pstmt.setLong(2, attention.getAptCode());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("attention insert error");
			e.printStackTrace();

		} finally {
			util.close(conn, pstmt);
		}
		return result;
	}

	public Attention selectOne(String aptCode, String id) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Attention result = null;

		try {
			conn = dataSource.getConnection();
			String sql = "select * from uattention where aptCode = ? and id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, Long.parseLong(aptCode));
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				result = new Attention(rs.getInt(1), rs.getString(2), rs.getLong(3));
			}

		} finally {
			util.close(rs, pstmt, conn);
		}

		return result;
	}

	public void delete(Attention attention) {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = dataSource.getConnection();
			String sql = "delete from uattention where id = ? and  aptCode = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, attention.getId());
			pstmt.setLong(2, attention.getAptCode());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("attention delete error");
			e.printStackTrace();

		} finally {
			util.close(conn, pstmt);
		}
	}
}