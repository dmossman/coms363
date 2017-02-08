package PTCFramework;
import java.util.Iterator;

public interface ProducerIterator<P> extends Iterator<P>{
	
	//Functions which are not there in Java's Iterator but need to be implemented by our iterator
	void open() throws Exception;
	void close() throws Exception;
}