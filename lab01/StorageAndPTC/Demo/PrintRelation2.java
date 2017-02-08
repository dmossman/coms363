package Demo;

import Demo.GetTupleFromRelationIterator2;

public class PrintRelation2{
	public static void main(String args[]) throws Exception{
		System.out.println("The tuples after loading file to Relation are: ");
		GetTupleFromRelationIterator2 getTupleFromRelationIterator= new GetTupleFromRelationIterator2("myDisk1", 31, 11);
		getTupleFromRelationIterator.open();
		while(getTupleFromRelationIterator.hasNext()){
			byte [] tuple = getTupleFromRelationIterator.next();
			System.out.println(new String(tuple).substring(0, 23)+", "+ new String(tuple).substring(23,27)+", "+ toInt(tuple, 27));
		}
	}
	
	
	private static int toInt(byte[] bytes, int offset) {
		  int ret = 0;
		  for (int i=0; i<4; i++) {
		    ret <<= 8;
		    ret |= (int)bytes[offset+i] & 0xFF;
		  }
		  return ret;
		}
}