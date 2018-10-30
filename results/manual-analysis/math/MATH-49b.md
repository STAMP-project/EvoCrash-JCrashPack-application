# MATH-49b

## Stacktrace

```
org.apache.commons.math.MathRuntimeException$6: la table d'adressage a été modifiée pendant l'itération
	at org.apache.commons.math.MathRuntimeException.createConcurrentModificationException(MathRuntimeException.java:373)
	at org.apache.commons.math.util.OpenIntToDoubleHashMap$Iterator.advance(OpenIntToDoubleHashMap.java:564)
	at org.apache.commons.math.linear.OpenMapRealVector.ebeMultiply(OpenMapRealVector.java:372)
	at org.apache.commons.math.linear.OpenMapRealVector.ebeMultiply(OpenMapRealVector.java:33)
```

## Frame 1

Best fitness: line reached

The exception is thrown in frame 2 using a factory:

```
throw MathRuntimeException.createConcurrentModificationException(LocalizedFormats.MAP_MODIFIED_WHILE_ITERATING);
```

Frame 1 points to the `new` call for that exception in the factory method (and could not be thrown).

The frame is considered as irrelevant here.


## Frame 4

Best fitness: crashed

Line points to class declaration header.
