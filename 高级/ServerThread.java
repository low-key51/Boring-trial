package com.hqyj.javaadvanceday07;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.net.Socket;

public class ServerThread extends Thread {
	private Socket socket;
	
	public ServerThread(Socket socket) {
		this.socket = socket;
	}

	@Override
	public void run() {
		try {
			InputStream inputStream = socket.getInputStream(); //接收客户端消息
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
			String line = null;
			while((line = bufferedReader.readLine())!=null) {
				System.out.println("接收到消息：" + line);
				for(Socket s : ServerThreadDemo.sockets) {
					OutputStream outputStream = s.getOutputStream();  //发送消息给所有客户端
					PrintStream printStream = new PrintStream(outputStream);
					printStream.println(line);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			ServerThreadDemo.sockets.remove(socket);
		}
	}

	
}
