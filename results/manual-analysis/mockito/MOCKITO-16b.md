# MOCKITO-16b

## Stacktrace

```
org.mockito.exceptions.misusing.MissingMethodInvocationException:
	at org.mockito.exceptions.Reporter.missingMethodInvocation(Reporter.java:77)
	at org.mockito.internal.MockitoCore.stub(MockitoCore.java:43)
	at org.mockito.internal.MockitoCore.when(MockitoCore.java:56)
	at org.mockito.Mockito.when(Mockito.java:994)
```

## Frame 1

Best fitness: ex. thrown

The cause is unknown. This is probably linked to the difficulty of EvoCrash to handle Mockito (which is also a dependency of EvoCrash).

## Frame 2 and 3

Best fitness: crashed

Methods have template parameters.

## Frame 4

Best fitness: crashed

There are static initializers.
