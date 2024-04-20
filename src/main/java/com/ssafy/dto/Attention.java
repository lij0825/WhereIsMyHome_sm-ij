package com.ssafy.dto;

public class Attention {
	private int ano;
	private String id;
	private long aptCode;

	public Attention() {

	}

	public Attention(int ano, String id, long aptCode) {
		this.ano = ano;
		this.id = id;
		this.aptCode = aptCode;
	}

	public Attention(String id, long aptCode) {

		this.id = id;
		this.aptCode = aptCode;
	}

	public int getAno() {
		return ano;
	}

	public void setAno(int ano) {
		this.ano = ano;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public long getAptCode() {
		return aptCode;
	}

	public void setAptCode(int aptCode) {
		this.aptCode = aptCode;
	}

}