# TIME-14b

## Stacktrace

```
org.joda.time.IllegalFieldValueException: Value 29 for dayOfMonth must be in the range [1,28]
	at org.joda.time.field.FieldUtils.verifyValueBounds(FieldUtils.java:218)
	at org.joda.time.field.PreciseDurationDateTimeField.set(PreciseDurationDateTimeField.java:78)
	at org.joda.time.chrono.BasicMonthOfYearDateTimeField.add(BasicMonthOfYearDateTimeField.java:213)
	at org.joda.time.MonthDay.withFieldAdded(MonthDay.java:519)
	at org.joda.time.MonthDay.plusMonths(MonthDay.java:592)
```

## Frame 1

Best fitness: ex. thrown

EvoCrash gets stuck in a local optima by setting a null value to the first parameter of the method. This value is used afterwards and it throws a NullPointerException.

## Frame 2 to 5

Best fitness: ex. thrown

The values are passed to the lower frames based on the internal values, returned by `getValues()`, those values are hard to set properly for EvoCrash.
