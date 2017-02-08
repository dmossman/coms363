package Demo;


import PTCFramework.ConsumerIterator;
import PTCFramework.PTCFramework;
import PTCFramework.ProducerIterator;

public class RelationToRelationPTC extends PTCFramework<byte [], byte []> {

	public RelationToRelationPTC(ProducerIterator<byte []> pIterator,ConsumerIterator<byte []> cIterator) {
		super(pIterator, cIterator);
	}
	
	public void run(){
		try{
			this.producerIterator.open();
			this.consumerIterator.open();
			while(this.producerIterator.hasNext()){
				byte [] bytes= new byte[31];
				byte [] producerElement= producerIterator.next();
				
				//We write the first 4 bytes and the last 8 bytes of the tuple to a byte array
				for(int i=0;i<31;i++){
					bytes[i]=producerElement[i+4];
				}
				//Send the transformed tuple to the Consumer Iterator
				consumerIterator.next(bytes);
			}
			this.producerIterator.close();
			this.consumerIterator.close();
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
}