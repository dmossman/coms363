package PTCFramework;

public abstract class PTCFramework<P,C>{
	//The Producer Iterator with element of type P
	protected ProducerIterator<P> producerIterator;
	
	//The consumer Iterator with elements of type C
	protected ConsumerIterator<C> consumerIterator;
	
	//Initialize our framework
	public PTCFramework(ProducerIterator<P> producerIterator, ConsumerIterator<C> consumerIterator){
		this.producerIterator=producerIterator;
		this.consumerIterator=consumerIterator;
	}
	
	public abstract void run();
}