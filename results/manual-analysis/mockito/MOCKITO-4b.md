# MOCKITO-4b

## Stacktrace

```
java.lang.ClassCastException: java.lang.Boolean cannot be cast to java.lang.String
	at org.mockito.exceptions.Reporter.noMoreInteractionsWantedInOrder(Reporter.java:434)
```

## Frame 1


Brest fitness value is 3 (line is reached but exception is not thrown). The `noMoreInteractionsWantedInOrder` method is:

```
public void noMoreInteractionsWantedInOrder(Invocation undesired) {
	throw new VerificationInOrderFailure(join(
			"No interactions wanted here:",
			new LocationImpl(),
			"But found this interaction on mock '" + undesired.getMock() + "':",
			undesired.getLocation()
	));
}
```

Where `Invocation` is an interface, meaning that to create an `Invocation` object, EvoCrash will look to implementing classes. 

To reproduce the exception, call `undesired.getMock()` (signature is `Object getMock();`) has to return a `java.lang.Boolean` or any other object that cannot be cast to `String` by `join` method. 


