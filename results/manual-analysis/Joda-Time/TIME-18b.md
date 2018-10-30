# CHART-18b

## Stacktrace

```
org.joda.time.IllegalFieldValueException: Value 29 for dayOfMonth must be in the range [1,28]
	at org.joda.time.field.FieldUtils.verifyValueBounds(FieldUtils.java:233)
	at org.joda.time.chrono.BasicChronology.getDateMidnightMillis(BasicChronology.java:605)
	at org.joda.time.chrono.BasicChronology.getDateTimeMillis(BasicChronology.java:177)
	at org.joda.time.chrono.GregorianChronology.getDateTimeMillis(GregorianChronology.java:45)
	at org.joda.time.chrono.GJChronology.getDateTimeMillis(GJChronology.java:364)
	at org.joda.time.base.BaseDateTime.<init>(BaseDateTime.java:254)
	at org.joda.time.DateMidnight.<init>(DateMidnight.java:343)
```

## Frame 1

Best fitness: ex. thrown

EvoCrash gets stuck in a local optima by setting a null value to the first parameter of the method. This value is used afterwards and it throws a NullPointerException.

## Frames 2 and 3

Best fitness: ex. thrown

Methods have a lot of parameters.

## Frame 4

Best fitness: crashed

The methods has static fields referencing other classes of the application.

## Frames 5 to 7

Best fitness: ex. thrown, crashed, and ex. thrown

Methods have a lot of parameters. For frame 6, this even prevents EvoCrash to intialise the object. 
