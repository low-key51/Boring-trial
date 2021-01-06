package com.hqyj.javaadvanceday06;

import org.junit.Test;

public class ThreadDemoTest {

	@Test
	public void testThread1() {
		ThreadDemo demo1 = new ThreadDemo("线程一：");
		demo1.start();
	}
	
	public static void main(String[] args) {
		/*
		ThreadDemo demo1 = new ThreadDemo("线程一：");
		demo1.start();
		ThreadDemo demo2 = new ThreadDemo("线程二：");
		demo2.start();
		*/
		/*
		RunnableDemo runnableDemo1 = new RunnableDemo();
		new Thread(runnableDemo1).start();
		RunnableDemo runnableDemo2 = new RunnableDemo();
		new Thread(runnableDemo2).start();
		*/
		Account account = new Account("894653413478967687", 888);
		DrawThread thread1 = new DrawThread(account, 500);
		thread1.start();
		DrawThread thread2 = new DrawThread(account, 500);
		thread2.start();
	}
	
}
