package com.ssafy.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.dao.AttentionDao;
import com.ssafy.dto.Attention;

import jakarta.websocket.server.ServerEndpoint;

@Service
public class AttentionService {

	private final AttentionDao attentionDao;

	public AttentionService(AttentionDao attentionDao) {
		super();
		this.attentionDao = attentionDao;
	}
	

	public List<Attention> findList(String id) {
		List<Attention> result = attentionDao.selectId(id);
		return result;
	}

	public List<Long> findAptList(String id) {
		List<Attention> list = attentionDao.selectId(id);
		List<Long> aptList = new ArrayList<>();
		for (Attention att : list) {
			aptList.add(att.getAptCode());
		}
		return aptList;
	}

	public Attention getAttention(String aptCode, String id) throws SQLException {
		return attentionDao.selectOne(aptCode, id);
	}

	public void addAttention(Attention attention) {
		attentionDao.insert(attention);

	}

	public void delete(Attention attention) {
		attentionDao.delete(attention);
	}
}