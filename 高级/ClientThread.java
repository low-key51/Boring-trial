package com.hqyj.javaadvanceday07;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.Socket;

public class ClientThread extends Thread {
	private Socket socket;
	
	
	@Override
	public void run() {
		try {
			InputStream inputStream = socket.getInputStream();
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
			String line = null;
			while((line = bufferedReader.readLine())!=null) {
				System.out.println(line);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}


	public ClientThread(Socket socket) {
		this.socket = socket;
	}
	
	
	
}
