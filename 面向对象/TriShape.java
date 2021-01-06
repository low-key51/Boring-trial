package com.hqyj;

//三角形父类
public class TriShape {
	protected int botom;
	protected int border2;
	protected int border3;
	
	public TriShape(int botom, int border2, int border3) {
		super();
		this.botom = botom;
		this.border2 = border2;
		this.border3 = border3;
	}

	public boolean validate() {
		//两边之和大于第三边
		if(botom+border2>border3 && botom+border3>border2 && border2+border3>botom) {
			if(Math.abs(botom-border2)<border3 && Math.abs(botom-border3)<border2 && Math.abs(border2-border3)<botom) {
				return true;
			}
		}
		return false;
	}
	
}
