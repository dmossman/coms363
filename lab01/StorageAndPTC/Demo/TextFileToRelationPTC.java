package Demo;

import java.nio.ByteBuffer;

import PTCFramework.ConsumerIterator;
import PTCFramework.PTCFramework;
import PTCFramework.ProducerIterator;

public class TextFileToRelationPTC extends PTCFramework<byte [], byte []> {

	public TextFileToRelationPTC(ProducerIterator<byte []> piterator, ConsumerIterator<byte []> citerator) {
		super(piterator, citerator);
	}
	
	@Override
	public void run(){
		try {
			this.producerIterator.open();
			this.consumerIterator.open();
			
			while(producerIterator.hasNext()){
				
				byte [] producerElement = producerIterator.next();
				//Here we have a single tuple as it is in Emp.txt file
				
				int len = producerElement.length;
				
				int id=0;
				int j;
				for(j=1;producerElement[j]!=',';j++){
					id=id*10;
					id+=producerElement[j] - '0';
				}
				
				j++;
				
				byte [] name = new byte[23];
				int count=0;
				for(;producerElement[j]!=',';j++){
					name[count++]=producerElement[j]; 
					
				}
				
				j++;
				
				byte [] deptbytes = new byte[4];
				count=0;
				for(;producerElement[j]!=',';j++){
					deptbytes[count++]=producerElement[j]; 
				}
				
				j++;
				
				
				
				int salary=0;
				for(;j<len-1;j++){
					salary = salary*10;
					salary += producerElement[j]-'0';
				}
				
				
				
				
				
				
				//Extract the id, name dept and salary from the input.
				byte [] bytes= new byte[35];
				byte [] idbytes= ByteBuffer.allocate(4).putInt(id).array();
				byte [] salaryBytes= ByteBuffer.allocate(4).putInt(salary).array();
				
				//Create a 35 byte array which stores our tuple in the form id,Name,Dname,salary
				for(int i=0;i<4;i++){
					bytes[i]=idbytes[i];
					bytes[34-i]=salaryBytes[3-i];
				}
				
				for(int i=0;i<4;i++){
					bytes[27+i]=deptbytes[i];
				}
				
				
				
				for(int i=0;i<23;i++){
					bytes[4+i]=name[i];
				}
				
				//Once the tuple is stored in the byte array, pass it to the consumer iterator.
				consumerIterator.next(bytes);
			}
			producerIterator.close();
			consumerIterator.close();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
}