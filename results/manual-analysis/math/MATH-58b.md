# MATH-58b

## Stacktrace

```
org.apache.commons.math.exception.NotStrictlyPositiveException: -1,277 n'est pas strictement plus petit que le minimum (0)
	at org.apache.commons.math.analysis.function.Gaussian$Parametric.validateParameters(Gaussian.java:183)
	at org.apache.commons.math.analysis.function.Gaussian$Parametric.value(Gaussian.java:128)
	at org.apache.commons.math.optimization.fitting.CurveFitter$TheoreticalValuesFunction.value(CurveFitter.java:203)
	at org.apache.commons.math.optimization.direct.BaseAbstractVectorialOptimizer.computeObjectiveValue(BaseAbstractVectorialOptimizer.java:107)
	at org.apache.commons.math.optimization.general.AbstractLeastSquaresOptimizer.updateResidualsAndCost(AbstractLeastSquaresOptimizer.java:128)
	at org.apache.commons.math.optimization.general.LevenbergMarquardtOptimizer.doOptimize(LevenbergMarquardtOptimizer.java:350)
	at org.apache.commons.math.optimization.direct.BaseAbstractVectorialOptimizer.optimize(BaseAbstractVectorialOptimizer.java:141)
	at org.apache.commons.math.optimization.general.AbstractLeastSquaresOptimizer.optimize(AbstractLeastSquaresOptimizer.java:253)
	at org.apache.commons.math.optimization.general.AbstractLeastSquaresOptimizer.optimize(AbstractLeastSquaresOptimizer.java:43)
	at org.apache.commons.math.optimization.fitting.CurveFitter.fit(CurveFitter.java:161)
	at org.apache.commons.math.optimization.fitting.CurveFitter.fit(CurveFitter.java:126)
	at org.apache.commons.math.optimization.fitting.GaussianFitter.fit(GaussianFitter.java:121)
```

## Frame 3

Best fitness: crashed

Line points to a method in a private inner class.


## Frame 4

Best fitness: crashed

The class is abstract and could not be instantiated.


## Frame 5

Best fitness: line reached

The class is abstract and the method is protected. Method can be called from public method of subclasses but EvoCrash fails to get the right subclass with proper object state.


## Frame 6

Best fitness: failed

Method is protected but can be called from other place in the code. However, the method is long and complex with a lot of nested if ad while statements.


## Frame 7

Best fitness: crashed

The class is abstract and could not be instantiated.


## Frame 8

Best fitness: line reached

The class is abstract and the method is protected. Method can be called from public method of subclasses but EvoCrash fails to get the right subclass with proper object state.


## Frame 9

Best fitness: crashed

The class is abstract and could not be instantiated.


## Frame 10

Best fitness: line reached

Method has 3 parameters, one with complex structure. Those parameters are in turn used to compute the 5 parameters of `fit`.


## Frame 11

Best fitness: ex. thrown

This method is a wrapper for the method called in frame 10.


## Frame 12

Best fitness: line reached

This method is a wrapper for the method called in frame 11.
