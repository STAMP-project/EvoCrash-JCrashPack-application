# LANG-6b

## Stacktrace

```
java.lang.StringIndexOutOfBoundsException: String index out of range: 2
	at org.apache.commons.lang3.text.translate.CharSequenceTranslator.translate(CharSequenceTranslator.java:95)
	at org.apache.commons.lang3.text.translate.CharSequenceTranslator.translate(CharSequenceTranslator.java:59)
	at org.apache.commons.lang3.StringEscapeUtils.escapeCsv(StringEscapeUtils.java:556)
```

## Frame 1 and 2

Best fitness value is 0.3 (frame 1) and 0.375 (frame 2), meaning that the exception has been thrown. Since class `CharSequenceTranslator` is abstract, EvoCrash will instantiate an object from an subclass (randomly chosen between all subclasses). For instance, in the best candidate for frame 2, EvoCrash instantiate a `UnicodeEscaper` object, which extends `CodePointTranslator`, which in turns extends `CharSequenceTranslator`. 

Problem with this approach is that (i) the names of the classes (or line numbers) slightly change in the generated stacktraces, compared to the given one; (ii) it complicates the search since the concrete class is unknown (`CsvEscaper`, a static subclass with default visibility of `StringEscapeUtils` in this case, based on frame 3).


# Frame 3

Best fitness value is 0.3478261, meaning that the exception has been thrown. To replicate the stacktrace, one has to use the following test case, which is hardly impossible to generate using EvoCrash since it involves unicode characters in strings:

```
assertEquals("\uD83D\uDE30", StringEscapeUtils.escapeCsv("\uD83D\uDE30"));
// Examples from https://en.wikipedia.org/wiki/UTF-16
assertEquals("\uD800\uDC00", StringEscapeUtils.escapeCsv("\uD800\uDC00"));
assertEquals("\uD834\uDD1E", StringEscapeUtils.escapeCsv("\uD834\uDD1E"));
assertEquals("\uDBFF\uDFFD", StringEscapeUtils.escapeCsv("\uDBFF\uDFFD"));
```
