# MOCKITO-1b

## Stacktrace

```
java.lang.UnsupportedOperationException
	at org.mockito.internal.invocation.InvocationMatcher.captureArgumentsFrom(InvocationMatcher.java:123)
	at org.mockito.internal.handler.MockHandlerImpl.handle(MockHandlerImpl.java:94)
	at org.mockito.internal.handler.NullResultGuardian.handle(NullResultGuardian.java:29)
	at org.mockito.internal.handler.InvocationNotifierHandler.handle(InvocationNotifierHandler.java:37)
	at org.mockito.internal.creation.bytebuddy.MockMethodInterceptor.doIntercept(MockMethodInterceptor.java:82)
	at org.mockito.internal.creation.bytebuddy.MockMethodInterceptor.interceptAbstract(MockMethodInterceptor.java:70)
	at org.mockito.internal.util.reflection.FieldInitializer$ConstructorArgumentResolver$MockitoMock$858169766.resolveTypeInstances(Unknown Source)
	at org.mockito.internal.util.reflection.FieldInitializer$ParameterizedConstructorInstantiator.instantiate(FieldInitializer.java:256)
	at org.mockito.internal.util.reflection.FieldInitializer.acquireFieldInstance(FieldInitializer.java:124)
	at org.mockito.internal.util.reflection.FieldInitializer.initialize(FieldInitializer.java:86)
```

## Frames 1 and 2

Best fitness: failed

The exception is thrown within a if statement with conditions on the input parameter (flag problem).

## Frames 3 to 6

Best fitness: line reached

The line is easy to reach (within the first lines of the method without branching statements), but the data is hard to generate in order to thrown an exception in sub-frames.

## Frames 7 to 10

Best fitness: crashed

The class has static package inner classes.
