# MOCKITO-10b

## Stacktrace

```
org.mockito.exceptions.base.MockitoException:
	at org.mockito.exceptions.Reporter.serializableWontWorkForObjectsThatDontImplementSerializable(Reporter.java:760)
	at org.mockito.internal.util.MockCreationValidator.validateSerializable(MockCreationValidator.java:63)
	at org.mockito.internal.creation.MockSettingsImpl.validatedSettings(MockSettingsImpl.java:154)
	at org.mockito.internal.creation.MockSettingsImpl.confirm(MockSettingsImpl.java:141)
	at org.mockito.internal.MockitoCore.mock(MockitoCore.java:58)
	at org.mockito.internal.stubbing.defaultanswers.ReturnsDeepStubs.newDeepStubMock(ReturnsDeepStubs.java:88)
	at org.mockito.internal.stubbing.defaultanswers.ReturnsDeepStubs.deepStub(ReturnsDeepStubs.java:71)
	at org.mockito.internal.stubbing.defaultanswers.ReturnsDeepStubs.answer(ReturnsDeepStubs.java:55)
	at org.mockito.internal.handler.MockHandlerImpl.handle(MockHandlerImpl.java:93)
	at org.mockito.internal.handler.NullResultGuardian.handle(NullResultGuardian.java:29)
	at org.mockito.internal.handler.InvocationNotifierHandler.handle(InvocationNotifierHandler.java:38)
	at org.mockito.internal.creation.MethodInterceptorFilter.intercept(MethodInterceptorFilter.java:61)
```

## Frame 1

Best fitness: ex. thrown

EvoCrash got stuck in a local optima.

## Frame 2

Best fitness: failed

There are a lot of conditions to fulfill before getting the line executed (flag problem).

## Frame 3

best fitness: crashed

The class and method have template parameters.

## Frame 4

best fitness: ex. thrown

EvoCrash got stuck in a local optima.

## Frame 5

best fitness: crashed

The methods has template parameters.

## Frame 6

best fitness: failed

The method is private and nested in a chain of private method calls.

## Frame 7

best fitness: failed

The method is private and nested in a chain of private method calls.

## Frame 8 and 9

best fitness: failed

Input parameters are hard to setup in order to reach the line (flag problem).

## Frame 10, 11, 12

best fitness: ex. thrown, ex. thrown, failed

The same parameter is passed through method calls up to frame 9.
