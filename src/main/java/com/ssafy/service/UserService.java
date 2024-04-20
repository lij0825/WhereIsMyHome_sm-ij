package com.ssafy.service;

import org.springframework.stereotype.Service;

import com.ssafy.dao.UserDao;
import com.ssafy.dto.User;

@Service
public class UserService {
	
	
	
	private final UserDao userDao;


	public UserService(UserDao userDao) {
		super();
		this.userDao = userDao;
	}

	public int join(User user) throws Exception {
		int result = userDao.insert(user);
		if (result == 0) {
			throw new Exception("가입 실패");
		}
		return result;
	}

	public User find(String id, String pw) throws Exception {
		User result = userDao.selectOne(id, pw);
		if (result == null) {
			throw new Exception("id 또는 password를 확인하세요.");
		}
		return result;
	}

	public int modifyInfo(String pw, String address, String id) throws Exception {
		int result = userDao.updateOne(pw, address, id);
		if (result == 0) {
			throw new Exception("수정 실패");
		}
		return result;
	}
	
	
	public int deleteInfo(String id) throws Exception {
		int result = userDao.deleteOne(id);
		if (result == 0) {
			throw new Exception("삭제 실패");
		}
		return result;
	}
	

}