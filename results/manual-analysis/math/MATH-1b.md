# MATH-1b

## Stacktrace

```
org.apache.commons.math3.fraction.FractionConversionException: état incohérent: Dépassement de capacité lors de la conversion de 0,5 en fraction (2 499 999 794/4 999 999 587)
	at org.apache.commons.math3.fraction.BigFraction.<init>(BigFraction.java:306)
	at org.apache.commons.math3.fraction.BigFraction.<init>(BigFraction.java:356)
```

## Frame 1

Best fitness: crashed

The constructor is private. EvoCrash failed to find another method calling this constructor and therefore could not start the search.
