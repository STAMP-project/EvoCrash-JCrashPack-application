# MOCKITO-7b

## Stacktrace

```
org.mockito.exceptions.base.MockitoException: Raw extraction not supported for : 'null'
	at org.mockito.internal.util.reflection.GenericMetadataSupport$TypeVariableReturnType.extractRawTypeOf(GenericMetadataSupport.java:407)
	at org.mockito.internal.util.reflection.GenericMetadataSupport$TypeVariableReturnType.extractRawTypeOf(GenericMetadataSupport.java:405)
	at org.mockito.internal.util.reflection.GenericMetadataSupport$TypeVariableReturnType.rawType(GenericMetadataSupport.java:385)
	at org.mockito.internal.stubbing.defaultanswers.ReturnsDeepStubs.answer(ReturnsDeepStubs.java:51)
	at org.mockito.internal.handler.MockHandlerImpl.handle(MockHandlerImpl.java:93)
	at org.mockito.internal.handler.NullResultGuardian.handle(NullResultGuardian.java:29)
	at org.mockito.internal.handler.InvocationNotifierHandler.handle(InvocationNotifierHandler.java:38)
	at org.mockito.internal.creation.cglib.MethodInterceptorFilter.intercept(MethodInterceptorFilter.java:59)
```

## Frames 1 to 3

Best fitness: failed

The lines are in private inner static classes that cannot be directly instantiated by EvoCrash.

## Frames 4 and 5

Best fitness: failed and line reached

The lower frames have a lot of if statements on the internal state of the object, making it difficult for EvoCrash to reach the line and throw an exception (flag problem).

## Frames 6 to 8

Best fitness: ex. thrown, ex. thrown and failed

Input parameters of frame 8 are numerous and complex. Those parameters are wrapped and passed to method calls in frame 7 and 6.
