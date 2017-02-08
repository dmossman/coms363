package Demo;

import java.io.File;
import java.util.Scanner;

import PTCFramework.*;

public class TextFileScanIterator implements ProducerIterator<byte []>{
	File file;
	Scanner in;
	int count=0;
	@Override
	public boolean hasNext() {
		return in.hasNextLine();
	}

	@Override
	public byte [] next() {
		count++;
		return in.nextLine().getBytes();
	}

	@Override
	public void remove() {
		
	}

	@Override
	public void open() throws Exception {
		file= new File("Demo/Emp.txt");
		in=new Scanner(file);
	}

	@Override
	public void close() throws Exception {
		in.close();
	}
	
}