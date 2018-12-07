MOCKITO-34b
```
java.lang.ArrayIndexOutOfBoundsException: 0
	at org.mockito.internal.invocation.InvocationMatcher.captureArgumentsFrom(InvocationMatcher.java:107)
```

# Frame 1
EvoCrash got stuck in constructor of CUT . Like MOCKITO-3b Frame 1.