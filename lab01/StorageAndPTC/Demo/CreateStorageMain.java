package Demo;

import StorageManager.Storage;

public class CreateStorageMain {
	public static void main(String args[]) throws Exception{
		Storage s1 = new Storage();
		s1.CreateStorage("myDisk1", 1024, 1024*100);
	}
}