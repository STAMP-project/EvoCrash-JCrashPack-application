# Example 1
The following frames are frame 7 to 9 in crash `XRENDERING-422`:
```
at org.xwiki.rendering.internal.parser.wikimodel.DefaultXWikiGeneratorListener.flushFormat(DefaultXWikiGeneratorListener.java:325)
at org.xwiki.rendering.internal.parser.wikimodel.DefaultXWikiGeneratorListener.flushFormat(DefaultXWikiGeneratorListener.java:273)
at org.xwiki.rendering.internal.parser.wikimodel.DefaultXWikiGeneratorListener.flushFormat(DefaultXWikiGeneratorListener.java:267)
```
The target methods of frames 7 and 8 are private. According to the given stack trace. The correct public caller for these private methods are the target method of frame 9 `flushFormat`. EvoCrash found two public callers: `flushFormat` and `beginFormat`. The search process got stuck in a local optima in the path which we call the target method by `beginFormat`.
