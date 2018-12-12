# Example 1 & 2
`MATH-49b` is a good example for this category because 2 out of 4 frames of this stack trace is irrelevant. the given stack trace in this crash is:
```
org.apache.commons.math.MathRuntimeException$6: la table d'adressage a été modifiée pendant l'itération
	at org.apache.commons.math.MathRuntimeException.createConcurrentModificationException(MathRuntimeException.java:373)
	at org.apache.commons.math.util.OpenIntToDoubleHashMap$Iterator.advance(OpenIntToDoubleHashMap.java:564)
	at org.apache.commons.math.linear.OpenMapRealVector.ebeMultiply(OpenMapRealVector.java:372)
	at org.apache.commons.math.linear.OpenMapRealVector.ebeMultiply(OpenMapRealVector.java:33)
```
Frame 1 points to the `new` call for that exception in the factory method (and could not be thrown).
```java
return new ConcurrentModificationException() {  // ---> Target line


    private static final long serialVersionUID = -1878427236170442052L;


    @Override
    public String getMessage() {
        return buildMessage(Locale.US, pattern, arguments);
    }

    @Override
    public String getLocalizedMessage() {
        return buildMessage(Locale.getDefault(), pattern, arguments);
    }

};
```

Also, the target line in frame 4 points to class declaration header.
```java
public class OpenMapRealVector extends AbstractRealVector // ---> Target line
    implements SparseRealVector, Serializable {
      ...
    }
```
