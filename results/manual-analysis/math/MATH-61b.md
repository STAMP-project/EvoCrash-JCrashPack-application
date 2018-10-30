# MATH-61b

## Stacktrace

```
org.apache.commons.math.MathRuntimeException$4: la moyenne de Poisson doit être positive (-1)
	at org.apache.commons.math.MathRuntimeException.createIllegalArgumentException(MathRuntimeException.java:387)
	at org.apache.commons.math.distribution.PoissonDistributionImpl.<init>(PoissonDistributionImpl.java:94)
	at org.apache.commons.math.distribution.PoissonDistributionImpl.<init>(PoissonDistributionImpl.java:80)
```

## Frame 1

Best fitness: line reached

The exception is thrown in frame 2 using a factory:

```
throw MathRuntimeException.createIllegalArgumentException(LocalizedFormats.NOT_POSITIVE_POISSON_MEAN, p);
```

Frame 1 points to the `new` call for that exception in the factory method (and could not be thrown).

The frame is considered as irrelevant here.
