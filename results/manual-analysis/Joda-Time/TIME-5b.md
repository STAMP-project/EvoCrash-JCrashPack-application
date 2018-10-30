# TIME-5b

## Stacktrace

```
java.lang.UnsupportedOperationException: Field is not supported
	at org.joda.time.PeriodType.setIndexedField(PeriodType.java:690)
	at org.joda.time.Period.withYears(Period.java:896)
	at org.joda.time.Period.normalizedStandard(Period.java:1631)
```

## Frame 1

Best fitness: crashed

The constructor is private and there are a lot of public static methods calling the constructor and returning a PeriodType object.
