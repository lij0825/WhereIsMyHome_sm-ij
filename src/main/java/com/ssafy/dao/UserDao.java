package com.ssafy.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.stereotype.Repository;

import com.ssafy.dto.User;
import com.ssafy.util.DBUtil;


@Repository
public class UserDao {

	private DataSource dataSource;
	private DBUtil util;	
	
	public UserDao(DataSource dataSource, DBUtil util) {
		super();
		this.dataSource = dataSource;
		this.util = util;
	}

	public int insert(User user) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = dataSource.getConnection();
			String sql = "insert into userinfo values(?,?, ?, ?)";
			pstmt = conn.prepareStatement(sql);

			
			pstmt.setString(1, user.getId());
			pstmt.setString(2, util.getHashValue(user.getPw()));
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getAddress());

			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("user insert error");
			e.printStackTrace();
			throw e;
		} finally {
			util.close(conn, pstmt);
		}
		return result;
	}

	public User selectOne(String id, String pw) throws SQLException {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User result = null;
		

		try {
			conn = dataSource.getConnection();

			String sql = "select id, pw, name, address from userinfo where id=? and pw=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, util.getHashValue(pw));
			rs = pstmt.executeQuery();
			if (rs.next()) //
				result = new User(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4));

		} catch (SQLException e) {
			System.out.println("user find error");
			e.printStackTrace();

		} finally {
			util.close(rs, conn, pstmt);
		}
		return result;
	}

	public int updateOne(String pw, String address, String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		ResultSet rs = null;

		try {
			conn = dataSource.getConnection();
			String sql = "update userinfo set pw=?, address=?\r\n" + "where id = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, util.getHashValue(pw));
			pstmt.setString(2, address);
			pstmt.setString(3, id);

			result = pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("insert error");
			ex.printStackTrace();
		} finally {
			util.close(rs, pstmt, conn);
		}
		return result;
	}	
	
	
	
	public int deleteOne(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		ResultSet rs = null;

		try {
			conn = dataSource.getConnection();
			
			String sql = "delete from board where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();

			
			
			sql = "delete from userinfo where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			result = pstmt.executeUpdate();
			
			
		} catch (Exception ex) {
			System.out.println("delete error");
			ex.printStackTrace();
		} finally {
			util.close(rs, pstmt, conn);
		}
		return result;
	}	
	
	
	
	
	

}