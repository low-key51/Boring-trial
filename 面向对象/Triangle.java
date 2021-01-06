package com.hqyj;

//同时可以继承类和实现接口，implements要放到extends后面
public class Triangle extends TriShape implements Shape, Color{
	private String color;
	private int height;
	
	public Triangle(int botom, int border2, int border3, int height) {
		super(botom, border2, border3);
		this.height = height;
	}

	@Override
	public void fill(String color) {
		this.color = color;
	}

	@Override
	public int calcArea() {
		return (int)(0.5*height*botom);
	}

	@Override
	public int calcPerimeter() {
		return botom+border2+border3;
	}

}
