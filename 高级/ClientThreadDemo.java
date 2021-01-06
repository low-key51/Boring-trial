package com.hqyj.javaadvanceday07;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.net.Socket;
import java.net.UnknownHostException;
import java.util.Scanner;

public class ClientThreadDemo {

	public static void main(String[] args) {
		try {
			Socket socket = new Socket("127.0.0.1",3000);
			new ClientThread(socket).start();
			Scanner scanner = new Scanner(System.in);
			String line = null;
			OutputStream outputStream = socket.getOutputStream();  //把键盘输入的消息发送给服务器
			PrintStream printStream = new PrintStream(outputStream);
			while((line = scanner.nextLine())!=null) {
				printStream.println(line);
			}
			
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
