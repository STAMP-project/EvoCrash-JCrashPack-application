# MATH-51b

## Stacktrace

```
org.apache.commons.math.exception.TooManyEvaluationsException: état incohérent: limite (3 624) dépassé: évaluations
	at org.apache.commons.math.analysis.solvers.BaseAbstractUnivariateRealSolver.incrementEvaluationCount(BaseAbstractUnivariateRealSolver.java:296)
	at org.apache.commons.math.analysis.solvers.BaseAbstractUnivariateRealSolver.computeObjectiveValue(BaseAbstractUnivariateRealSolver.java:153)
	at org.apache.commons.math.analysis.solvers.BaseSecantSolver.doSolve(BaseSecantSolver.java:161)
	at org.apache.commons.math.analysis.solvers.BaseAbstractUnivariateRealSolver.solve(BaseAbstractUnivariateRealSolver.java:190)
	at org.apache.commons.math.analysis.solvers.BaseSecantSolver.solve(BaseSecantSolver.java:117)
	at org.apache.commons.math.analysis.solvers.BaseSecantSolver.solve(BaseSecantSolver.java:124)
	at org.apache.commons.math.analysis.solvers.BaseAbstractUnivariateRealSolver.solve(BaseAbstractUnivariateRealSolver.java:195)
```

## Frame 1

Best fitness: crashed

The class is abstract.


## Frame 2

Best fitness: crashed

The class is abstract 
