# MATH-31b

## Stacktrace

```
org.apache.commons.math3.exception.ConvergenceException: état incohérent: Divergence de fraction continue à NaN pour la valeur 0,5
	at org.apache.commons.math3.util.ContinuedFraction.evaluate(ContinuedFraction.java:177)
	at org.apache.commons.math3.special.Beta.regularizedBeta(Beta.java:154)
	at org.apache.commons.math3.special.Beta.regularizedBeta(Beta.java:129)
	at org.apache.commons.math3.special.Beta.regularizedBeta(Beta.java:50)
	at org.apache.commons.math3.distribution.BinomialDistribution.cumulativeProbability(BinomialDistribution.java:101)
	at org.apache.commons.math3.distribution.AbstractIntegerDistribution.checkedCumulativeProbability(AbstractIntegerDistribution.java:201)
	at org.apache.commons.math3.distribution.AbstractIntegerDistribution.solveInverseCumulativeProbability(AbstractIntegerDistribution.java:143)
	at org.apache.commons.math3.distribution.AbstractIntegerDistribution.inverseCumulativeProbability(AbstractIntegerDistribution.java:116)
```

## Frame 1

Best fitness: crashed

The constructor is protected and the class is abstract.
