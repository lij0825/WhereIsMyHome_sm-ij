package com.ssafy.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.dao.BoardDao;
import com.ssafy.dto.BoardDto;

@Service
public class BoardService {

	private final BoardDao boardDao;
	
	public BoardService(BoardDao boardDao) {
		super();
		this.boardDao = boardDao;
	}


	public List<BoardDto> list() throws SQLException {

		return boardDao.list();
	}

	public void post(BoardDto boardDto) throws SQLException {
		boardDao.post(boardDto);
	}

	public BoardDto view(String boardNo) throws SQLException {
		return boardDao.view(boardNo);
	}

}
