# MOCKITO-9b

## Stacktrace

```
org.mockito.exceptions.base.MockitoException:
	at org.mockito.exceptions.Reporter.cannotCallAbstractRealMethod(Reporter.java:583)
	at org.mockito.internal.invocation.InvocationImpl.callRealMethod(InvocationImpl.java:110)
	at org.mockito.internal.stubbing.answers.CallsRealMethods.answer(CallsRealMethods.java:36)
	at org.mockito.internal.handler.MockHandlerImpl.handle(MockHandlerImpl.java:93)
	at org.mockito.internal.handler.NullResultGuardian.handle(NullResultGuardian.java:29)
	at org.mockito.internal.handler.InvocationNotifierHandler.handle(InvocationNotifierHandler.java:38)
	at org.mockito.internal.creation.cglib.MethodInterceptorFilter.intercept(MethodInterceptorFilter.java:59)
```

## Frames 1 and 2

Best fitness: ex. thrown

The cause is unknown. This is probably linked to the difficulty of EvoCrash to handle Mockito (which is also a dependency of EvoCrash).

## Frames 3 to 7

Best fitness: line reached, line reached, ex. thrown, ex. thrown, and failed

Input parameters of frame 7 are numerous and complex. Those parameters are wrapped and passed to method calls to lower frames.
