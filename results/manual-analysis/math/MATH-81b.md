# MATH-81b

## Stacktrace

```
java.lang.ArrayIndexOutOfBoundsException: -1
	at org.apache.commons.math.linear.EigenDecompositionImpl.computeShiftIncrement(EigenDecompositionImpl.java:1544)
	at org.apache.commons.math.linear.EigenDecompositionImpl.goodStep(EigenDecompositionImpl.java:1071)
	at org.apache.commons.math.linear.EigenDecompositionImpl.processGeneralBlock(EigenDecompositionImpl.java:893)
	at org.apache.commons.math.linear.EigenDecompositionImpl.findEigenvalues(EigenDecompositionImpl.java:657)
	at org.apache.commons.math.linear.EigenDecompositionImpl.decompose(EigenDecompositionImpl.java:246)
	at org.apache.commons.math.linear.EigenDecompositionImpl.<init>(EigenDecompositionImpl.java:205)
```

## Frame 1 to 5

Frames 1 to 5 could not be reproduced. They are all private methods with calls from 5 -> 4 -> 3 -> 2 -> 1. EvocCrash correctly identified them as private and tries to generate test cases using the two constructors, which are calling methods from frames 1 to 5, but crashed eventually.

## Frame 6

Could be reproduced calling the construtor of the class.