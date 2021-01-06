package com.hqyj.javaadvanceday06;

public class DrawThread extends Thread{
	private Account account;
	private double drawAmount;
	
	public DrawThread(Account account, double drawAmount) {
		this.account = account;
		this.drawAmount = drawAmount;
	}

	@Override
	public void run() {
		//取钱金额小于等于账户余额，执行取钱动作
		if(drawAmount<=account.getBlance()) {
			System.out.println(getName() + "取钱成功，取了：" + drawAmount);
			account.setBlance(account.getBlance()-drawAmount);//修改余额
			System.out.println("账户余额是：" + account.getBlance());
		}else {//余额不足，不能取钱
			System.out.println("余额不足,取钱失败");
		}
	}
	
	
}
