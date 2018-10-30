# MATH-85b

## Stacktrace

```
org.apache.commons.math.ConvergenceException: nombre d'itérations = 1, itérations maximum = 2 147 483 647, valeur initiale = 1, borne inférieure = 0, borne supérieure = 179 769 313 486 231 570 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000 000, valeur a finale = 0, valeur b finale = 2, f(a) = -0,477, f(b) = 0
	at org.apache.commons.math.analysis.solvers.UnivariateRealSolverUtils.bracket(UnivariateRealSolverUtils.java:199)
	at org.apache.commons.math.analysis.solvers.UnivariateRealSolverUtils.bracket(UnivariateRealSolverUtils.java:127)
	at org.apache.commons.math.distribution.AbstractContinuousDistribution.inverseCumulativeProbability(AbstractContinuousDistribution.java:85)

```

## Frame 1 to 3

Best fitness: ex. thrown

The exception is thrown within a if statement (flag problem) in frame 1.
