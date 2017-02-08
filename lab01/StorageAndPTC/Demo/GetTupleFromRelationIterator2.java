package Demo;

import PTCFramework.ProducerIterator;
import StorageManager.Storage;

public class GetTupleFromRelationIterator2 implements ProducerIterator<byte[]>{

	Storage storage;
	long currentpage;
	int byteswrittentopage;
	int tuplelength;
	String fileName;
	int pageSize;
	
	public GetTupleFromRelationIterator2(String fileName, int tuplelength, int startingPageNumber) {
		this.tuplelength= tuplelength;
		this.fileName=fileName;
	}

	public void open() {
		// TODO Auto-generated method stub
		
	}

	public boolean hasNext() {
		// TODO Auto-generated method stub
		return false;
	}

	public byte[] next() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void close() throws Exception {
		// TODO Auto-generated method stub
		
	}

}
