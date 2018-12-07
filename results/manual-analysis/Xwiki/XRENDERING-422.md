# XRENDERING-422
```
java.util.NoSuchElementException
	at org.xwiki.rendering.listener.chaining.EmptyBlockChainingListener.stopContainerBlock(EmptyBlockChainingListener.java:458)
	at org.xwiki.rendering.listener.chaining.EmptyBlockChainingListener.endFormat(EmptyBlockChainingListener.java:263)
	at org.xwiki.rendering.listener.chaining.AbstractChainingListener.endFormat(AbstractChainingListener.java:290)
	at org.xwiki.rendering.listener.chaining.BlockStateChainingListener.endFormat(BlockStateChainingListener.java:439)
	at org.xwiki.rendering.listener.chaining.AbstractChainingListener.endFormat(AbstractChainingListener.java:290)
	at org.xwiki.rendering.listener.CompositeListener.endFormat(CompositeListener.java:253)
	at org.xwiki.rendering.internal.parser.wikimodel.DefaultXWikiGeneratorListener.flushFormat(DefaultXWikiGeneratorListener.java:325)
	at org.xwiki.rendering.internal.parser.wikimodel.DefaultXWikiGeneratorListener.flushFormat(DefaultXWikiGeneratorListener.java:273)
	at org.xwiki.rendering.internal.parser.wikimodel.DefaultXWikiGeneratorListener.flushFormat(DefaultXWikiGeneratorListener.java:267)
	at org.xwiki.rendering.internal.parser.wikimodel.DefaultXWikiGeneratorListener.onWord(DefaultXWikiGeneratorListener.java:906)
	at org.xwiki.rendering.wikimodel.impl.InternalWikiScannerContext.onWord(InternalWikiScannerContext.java:1147)
	at org.xwiki.rendering.wikimodel.impl.WikiScannerContext.onWord(WikiScannerContext.java:597)
	at org.xwiki.rendering.wikimodel.xhtml.impl.TagStack.flushStack(TagStack.java:204)
	at org.xwiki.rendering.wikimodel.xhtml.impl.TagStack.onCharacters(TagStack.java:227)
	at org.xwiki.rendering.wikimodel.xhtml.impl.XhtmlHandler.characters(XhtmlHandler.java:180)
	at org.xml.sax.helpers.XMLFilterImpl.characters(XMLFilterImpl.java:588)
	at org.xwiki.rendering.wikimodel.xhtml.filter.XHTMLWhitespaceXMLFilter.sendCharacters(XHTMLWhitespaceXMLFilter.java:487)
	at org.xwiki.rendering.wikimodel.xhtml.filter.XHTMLWhitespaceXMLFilter.sendCharacters(XHTMLWhitespaceXMLFilter.java:480)
	at org.xwiki.rendering.wikimodel.xhtml.filter.XHTMLWhitespaceXMLFilter.flushContent(XHTMLWhitespaceXMLFilter.java:357)
	at org.xwiki.rendering.wikimodel.xhtml.filter.XHTMLWhitespaceXMLFilter.flushContent(XHTMLWhitespaceXMLFilter.java:335)
	at org.xwiki.rendering.wikimodel.xhtml.filter.XHTMLWhitespaceXMLFilter.endElement(XHTMLWhitespaceXMLFilter.java:200)
	at org.xml.sax.helpers.XMLFilterImpl.endElement(XMLFilterImpl.java:570)
	at org.xwiki.rendering.wikimodel.xhtml.filter.AccumulationXMLFilter.endElement(AccumulationXMLFilter.java:86)
	at org.xml.sax.helpers.XMLFilterImpl.endElement(XMLFilterImpl.java:570)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DTDXMLFilter.endElement(DTDXMLFilter.java:86)
	at org.xml.sax.helpers.XMLFilterImpl.parse(XMLFilterImpl.java:357)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.parse(DefaultXMLFilter.java:58)
	at org.xml.sax.helpers.XMLFilterImpl.parse(XMLFilterImpl.java:357)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.parse(DefaultXMLFilter.java:58)
	at org.xml.sax.helpers.XMLFilterImpl.parse(XMLFilterImpl.java:357)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.parse(DefaultXMLFilter.java:58)
	at org.xwiki.rendering.wikimodel.xhtml.XhtmlParser.parse(XhtmlParser.java:132)
```
## Frame 6
Evocrash achieves to the target line. This line is:
```
listener.endFormat(format, parameters);
```

`listener` is a local variable of the target class. This variable can be set to many extensions of an abstract class. EvoCrash cannot find the right one.

## Frame 7 & 8
The target method is private. And, there are lots of public or protected callers which call the target method directly (public method A calls the target method) or indirectly (public method A calls Private method B, and method B calls the target method). In these cases, due to the randomness of EvoCrash, it has difficulty to find the right path for calling the target method.


## Frame 9 & 10
The target method is public. But, it should be called after setting the state of the software under test in the proper way. However, setting these state needed a proper sequence of method calls to achieve this specific type of exception.


## Frame 11 & 12 & 13 & 14 & 17 & 18 & 19 & 20 & 21
The generated test covers target line and target exception. However, due to the complexity of generating the proper input, It can not achieve to the stack trace similarity.

## Frame 15
The target method is public. EvoCrash can not achieve to the line coverage. it got stuck in previous lines because of the lack of proper input generation.

## Frame 23 & 25 & 27 & 29 & 31
EvoCrash can reach to the target line coverage. however, It can not go further than this point because it can not generate the proper inputs.

## Frame 32
The search process cannot set proper value for `xmlReader`. This variable is defined in the target method and its value came from another method in the target class.
