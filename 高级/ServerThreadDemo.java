package com.hqyj.javaadvanceday07;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

public class ServerThreadDemo {
	public static List<Socket> sockets = new ArrayList<>();
	
	public static void main(String[] args) {
		try {
			ServerSocket serverSocket = new ServerSocket(3000);
			while(true) {
				System.out.println("等待客户端连接...");
				Socket socket = serverSocket.accept();
				System.out.println("客户端连接成功");
				sockets.add(socket);//把socket连接添加列表
				new ServerThread(socket).start();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
