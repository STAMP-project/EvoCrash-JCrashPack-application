# MATH-103b

## Stacktrace

```
org.apache.commons.math.MaxIterationsExceededException: Maximal number of iterations (10,000) exceeded
	at org.apache.commons.math.special.Gamma.regularizedGammaP(Gamma.java:180)
	at org.apache.commons.math.special.Erf.erf(Erf.java:56)
	at org.apache.commons.math.distribution.NormalDistributionImpl.cumulativeProbability(NormalDistributionImpl.java:109)
```

## Frame 2

Best fitness: line reached

Line is the first line of the method. For the exception to be thrown, the parameter value of `erf` has to be specific.


## Frame 3

Best fitness: ex. thrown

As for frame 2, for the right exception to be thrown, the parameter value of `cumulativeProbability` has to be specific.
