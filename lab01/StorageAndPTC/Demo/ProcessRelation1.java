package Demo;

import PTCFramework.ConsumerIterator;
import PTCFramework.PTCFramework;
import PTCFramework.ProducerIterator;

public class ProcessRelation1{
	public static void main(String[] args) throws Exception{
		
		ProducerIterator<byte []> relationProducerIterator= new GetTupleFromRelationIterator2("myDisk1", 35, 0);
		ConsumerIterator<byte []> consumerIterator= new PutTupleInRelationIterator(31,"myDisk1");
		PTCFramework<byte[], byte[]>relationToRelationFramework= new RelationToRelationPTC(relationProducerIterator, consumerIterator);
		
		relationToRelationFramework.run();
		
	}
	
}