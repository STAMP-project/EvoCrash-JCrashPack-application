# MATH-60b

## Stacktrace

```
org.apache.commons.math.ConvergenceException: Divergence de fraction continue à NaN pour la valeur ∞
	at org.apache.commons.math.util.ContinuedFraction.evaluate(ContinuedFraction.java:186)
	at org.apache.commons.math.special.Gamma.regularizedGammaQ(Gamma.java:266)
	at org.apache.commons.math.special.Gamma.regularizedGammaP(Gamma.java:173)
	at org.apache.commons.math.special.Erf.erf(Erf.java:51)
	at org.apache.commons.math.distribution.NormalDistributionImpl.cumulativeProbability(NormalDistributionImpl.java:127)
```

## Frame 1

Best fitness: crashed

The class is abstract and instantiated using an anonymous class in frame 2.

## Frames 2 to 5

Best fitness: ex. thrown

The exception thrown in frame 1 is hard to get due to complex code both in frame 1 and in frame 2 and 3 (flag problem).
