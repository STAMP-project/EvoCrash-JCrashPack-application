# MATH-40b

## Stacktrace

```
org.apache.commons.math.exception.TooManyEvaluationsException: état incohérent: limite (100) dépassé: évaluations
	at org.apache.commons.math.analysis.solvers.BaseAbstractUnivariateRealSolver.incrementEvaluationCount(BaseAbstractUnivariateRealSolver.java:296)
	at org.apache.commons.math.analysis.solvers.BaseAbstractUnivariateRealSolver.computeObjectiveValue(BaseAbstractUnivariateRealSolver.java:153)
	at org.apache.commons.math.analysis.solvers.BracketingNthOrderBrentSolver.doSolve(BracketingNthOrderBrentSolver.java:283)
	at org.apache.commons.math.analysis.solvers.BaseAbstractUnivariateRealSolver.solve(BaseAbstractUnivariateRealSolver.java:190)
	at org.apache.commons.math.analysis.solvers.BracketingNthOrderBrentSolver.solve(BracketingNthOrderBrentSolver.java:394)
```

## Frame 1

Best fitness: crashed

The class `BaseAbstractUnivariateRealSolver` is abstract. 
