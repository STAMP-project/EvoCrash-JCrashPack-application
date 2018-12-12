# Example 1
In crash `MATH-58b`, frame 3 points the an inner class. This frame is:
```
org.apache.commons.math.optimization.fitting.CurveFitter$TheoreticalValuesFunction.value(CurveFitter.java:203)
```
If we check `TheoreticalValuesFunction` class in the  `CurveFitter`, we will see that this class is a private class:
```java
private class TheoreticalValuesFunction
    implements DifferentiableMultivariateVectorialFunction {
      ...
    }
```
EvoCrash was successful in reproducing frames 1 and 2, but it was unsuccessful in frame 3 because of the private inner class challenge.
