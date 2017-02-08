package PTCFramework;

import java.util.Iterator;

public interface ConsumerIterator<C> extends Iterator<C>{

	void open() throws Exception;
	void close() throws Exception;
	
	//The Java Iterator class has next which does not take any parameter. 
	//Adding a function which takes a parameter and consumes it.
	public void next(C c) throws Exception;
}