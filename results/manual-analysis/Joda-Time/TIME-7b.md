# TIME-7b

## Stacktrace

```
org.joda.time.IllegalFieldValueException: Cannot parse "2 29": Value 29 for dayOfMonth must be in the range [1,28]
	at org.joda.time.field.FieldUtils.verifyValueBounds(FieldUtils.java:220)
	at org.joda.time.field.PreciseDurationDateTimeField.set(PreciseDurationDateTimeField.java:78)
	at org.joda.time.format.DateTimeParserBucket$SavedField.set(DateTimeParserBucket.java:483)
	at org.joda.time.format.DateTimeParserBucket.computeMillis(DateTimeParserBucket.java:366)
	at org.joda.time.format.DateTimeParserBucket.computeMillis(DateTimeParserBucket.java:359)
	at org.joda.time.format.DateTimeFormatter.parseInto(DateTimeFormatter.java:715)
```

## Frame 3

Best fitness: crashed

The method is inside an inner class with default visibility.
