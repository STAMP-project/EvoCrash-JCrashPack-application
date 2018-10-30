# MATH-78b

## Stacktrace

```
org.apache.commons.math.MathRuntimeException$4: les valeurs de la fonction aux bornes n'ont pas des signes différents. Bornes : [89,999, 153,1], valeurs : [-0,066, -1 142,11]
	at org.apache.commons.math.MathRuntimeException.createIllegalArgumentException(MathRuntimeException.java:305)
	at org.apache.commons.math.analysis.solvers.BrentSolver.solve(BrentSolver.java:178)
	at org.apache.commons.math.ode.events.EventState.evaluateStep(EventState.java:218)
```

## Frame 1

Best fitness: line reached

The exception is thrown in frame 2 using a factory:

```
throw MathRuntimeException.createIllegalArgumentException(LocalizedFormats.SAME_SIGN_AT_ENDPOINTS, min, max, yMin, yMax);
```

Frame 1 points to the `new` call for that exception in the factory method (and could not be thrown).

The frame is considered as irrelevant here.
