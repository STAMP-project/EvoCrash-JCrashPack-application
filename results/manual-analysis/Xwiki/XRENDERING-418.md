# XRENDERING-418
```
java.lang.NullPointerException
	at com.xpn.xwiki.doc.DefaultDocumentAccessBridge.getAttachmentURL(DefaultDocumentAccessBridge.java:698)
	at org.xwiki.rendering.internal.wiki.XWikiWikiModel.getLinkURL(XWikiWikiModel.java:144)
	at org.xwiki.rendering.internal.wiki.XWikiWikiModel.getImageURL(XWikiWikiModel.java:176)
	at org.xwiki.rendering.internal.renderer.xhtml.image.AttachmentXHTMLImageTypeRenderer.getImageSrcAttributeValue(AttachmentXHTMLImageTypeRenderer.java:68)
	at org.xwiki.rendering.internal.renderer.xhtml.image.AbstractXHTMLImageTypeRenderer.onImage(AbstractXHTMLImageTypeRenderer.java:91)
	at org.xwiki.rendering.internal.renderer.xhtml.image.DefaultXHTMLImageRenderer.onImage(DefaultXHTMLImageRenderer.java:79)
	at org.xwiki.rendering.internal.renderer.xhtml.XHTMLChainingRenderer.onImage(XHTMLChainingRenderer.java:548)
	at org.xwiki.rendering.listener.chaining.AbstractChainingListener.onImage(AbstractChainingListener.java:452)
	at org.xwiki.rendering.listener.chaining.AbstractChainingListener.onImage(AbstractChainingListener.java:452)
	at org.xwiki.rendering.listener.chaining.EmptyBlockChainingListener.onImage(EmptyBlockChainingListener.java:405)
	at org.xwiki.rendering.listener.chaining.AbstractChainingListener.onImage(AbstractChainingListener.java:452)
	at org.xwiki.rendering.listener.chaining.BlockStateChainingListener.onImage(BlockStateChainingListener.java:617)
	at org.xwiki.rendering.listener.chaining.AbstractChainingListener.onImage(AbstractChainingListener.java:452)
	at org.xwiki.rendering.internal.parser.wikimodel.DefaultXWikiGeneratorListener.onImage(DefaultXWikiGeneratorListener.java:859)
	at org.xwiki.rendering.internal.parser.xhtml.wikimodel.XHTMLXWikiGeneratorListener.onImage(XHTMLXWikiGeneratorListener.java:115)
	at org.xwiki.rendering.wikimodel.impl.InternalWikiScannerContext.onImage(InternalWikiScannerContext.java:994)
	at org.xwiki.rendering.wikimodel.impl.WikiScannerContext.onImage(WikiScannerContext.java:480)
	at org.xwiki.rendering.internal.parser.xhtml.wikimodel.XWikiCommentHandler.handleImageCommentStop(XWikiCommentHandler.java:192)
	at org.xwiki.rendering.internal.parser.xhtml.wikimodel.XWikiCommentHandler.onComment(XWikiCommentHandler.java:97)
	at org.xwiki.rendering.wikimodel.xhtml.impl.TagStack.onComment(TagStack.java:233)
	at org.xwiki.rendering.wikimodel.xhtml.impl.XhtmlHandler.comment(XhtmlHandler.java:234)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.comment(DefaultXMLFilter.java:87)
	at org.xwiki.rendering.wikimodel.xhtml.filter.XHTMLWhitespaceXMLFilter.comment(XHTMLWhitespaceXMLFilter.java:276)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.comment(DefaultXMLFilter.java:87)
	at org.xwiki.rendering.wikimodel.xhtml.filter.AccumulationXMLFilter.comment(AccumulationXMLFilter.java:94)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.comment(DefaultXMLFilter.java:87)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DTDXMLFilter.comment(DTDXMLFilter.java:95)
	at org.xml.sax.helpers.XMLFilterImpl.parse(XMLFilterImpl.java:357)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.parse(DefaultXMLFilter.java:58)
	at org.xml.sax.helpers.XMLFilterImpl.parse(XMLFilterImpl.java:357)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.parse(DefaultXMLFilter.java:58)
	at org.xml.sax.helpers.XMLFilterImpl.parse(XMLFilterImpl.java:357)
	at org.xwiki.rendering.wikimodel.xhtml.filter.DefaultXMLFilter.parse(DefaultXMLFilter.java:58)
	at org.xwiki.rendering.wikimodel.xhtml.XhtmlParser.parse(XhtmlParser.java:132)
	at org.xwiki.rendering.internal.parser.wikimodel.AbstractWikiModelParser.parse(AbstractWikiModelParser.java:130)
	at org.xwiki.rendering.internal.parser.wikimodel.AbstractWikiModelParser.parse(AbstractWikiModelParser.java:108)
	at org.xwiki.wysiwyg.server.internal.converter.DefaultHTMLConverter.fromHTML(DefaultHTMLConverter.java:139)
	at org.xwiki.wysiwyg.server.filter.ConversionFilter.doFilter(ConversionFilter.java:112)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.xwiki.container.servlet.filters.internal.SetHTTPHeaderFilter.doFilter(SetHTTPHeaderFilter.java:63)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at com.xpn.xwiki.plugin.webdav.XWikiDavFilter.doFilter(XWikiDavFilter.java:66)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.xwiki.container.servlet.filters.internal.SavedRequestRestorerFilter.doFilter(SavedRequestRestorerFilter.java:208)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.xwiki.container.servlet.filters.internal.SetCharacterEncodingFilter.doFilter(SetCharacterEncodingFilter.java:111)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.xwiki.resource.servlet.RoutingFilter.doFilter(RoutingFilter.java:137)
	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:241)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:208)
	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:220)
	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:122)
	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:501)
	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:170)
	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:98)
	at org.apache.catalina.valves.AccessLogValve.invoke(AccessLogValve.java:950)
	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:116)
	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:408)
	at org.apache.coyote.http11.AbstractHttp11Processor.process(AbstractHttp11Processor.java:1041)
	at org.apache.coyote.AbstractProtocol$AbstractConnectionHandler.process(AbstractProtocol.java:607)
	at org.apache.tomcat.util.net.JIoEndpoint$SocketProcessor.run(JIoEndpoint.java:315)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:617)
	at java.lang.Thread.run(Thread.java:745)
```

## Frame 1
Evocrash got stuck in line 694. this object is generated from an injected object called `execution`.
It is hard for EvoCrash to set the state of the object, and it leads to NPE in line 694.

## Frame 2 & 3
cssParser dependency is available but application could not instantiate it properly.

## Frame 4
the `initialize()` method need to be run before calling target frame.

## Frame 5
Target line is covered. However, EvoCrash cannot throw exception in the target line because the generated inputs are not correct.

## Frame 6
Target line is covered. However, there is another method in target line which call `getXHTMLImageTypeRenderer`, and Evocrash got stuck in this method.

## Frame 7
Target line is not covered. Evocrash got stuck in line 545. the statement in this line is :
```
reference.addBaseReferences(getMetaDataState().<String>getAllMetaData(MetaData.BASE));
```
Noting that reference is an input argument, and it is hard for EvoCrash to set the state of this object properly for replicating crash.

## Frame 8 & 9
Target line is not covered. Evocrash got stuck in line 450. in this line application call `getListenerChain()` method which return `listenerChain` object.
the `listenerChain` is needed to be set with another method (`setListenerChain()`). Probability of calling the setter before calling target method in search is low.

## Frame 10
Target line is covered. Evocrash had problem for covering deeper frame (Frame 9)

## Frame 11
same as Frame 8 & 9

## Frame 12
Target line is covered. Evocrash had problem for covering deeper frame (Frame 11)

## Frame 13
same as Frame 8 & 9

## Frame 14 & 15
Target line is covered. Evocrash had problem for covering deeper frame (Frame 13)

## Frame 16
Target line is covered. Evocrash had problem for covering deeper frame.
the target line is :
```
fListener.onImage(ref);
```
fListener is an object which is made by init of CUT.
Evocrash need to generate proper inputs for init to set the state of `fListener` properly

## Frame 17
Target line is covered. Evocrash had problem for covering deeper frame (Frame 16)

## Frame 18
Target line is not covered.
The target call is private. Evocrash tried to access to target method by public callers ( here `onComment`), and it was successful. However, Evocrash got stuck in line 174 because it is hard to generate proper `content` as input argument.

## Frame 19
Target line is covered. Evocrash had problem for covering deeper frame (Frame 18)
Note that target call of this frame is `onComment` method which we mentioned it in Frame 18.

## Frame 20
Target line is covered. Evocrash had problem for covering deeper frame (Frame 18)
the situation is similar to Frame 16

## Frame 21
Line is not covered. The situation is similar to Frame 2 & 3

## Frame 22
Line is not covered. Evocrash got stuck in `<init>` of the target class.

## Frame 23
Line is not covered.
The input arguments of target call is :
```
comment(char[] ch, int start, int length)
```
In all of the 5 rounds of experiment, Evocrash got stuck in line 269 which is:
```
String comment = new String(ch, start, length);
```
and generated exception is:
```
java.lang.String.<init>(String.java:196)
org.xwiki.rendering.wikimodel.xhtml.filter.XHTMLWhitespaceXMLFilter.comment(XHTMLWhitespaceXMLFilter.java:269)
```
According to these information, it seems that Evocrash could not generate proper input for `java.lang.String`.

## Frame 24
Target line is covered. Evocrash had problem for covering deeper frame (Frame 23)

## Frame 25
Target line is covered.
However, the target line is :
```
super.comment(array, start, length);
```
This line points to its super class. there is no Exception in target line.


## Frame 26
Target line is covered.
However, the target line is :
```
this.lexicalHandler.comment(ch, start, length);
```
For achieving the coverage, `lexicalHandler` should be set properly by a setter method.

## Frame 27
Similar situation to Frame 25

## Frame 29
Target line is covered. Evocrash had problem for covering deeper frame (Frame 28)


## Frame 31
Target line is covered. Evocrash had problem for covering deeper frame (Frame 30)

## Frame 33
Target line is covered. Evocrash had problem for covering deeper frame (Frame 32)

## Frame 34
Line is not covered.
Evocrash got stuck in line 121. the reason is similar to frame 2 and 3.

## Frame 35
Target line is covered
In 2 out of 5 rounds, exception is covered too. in this situation the problem is line Frame 36.
In 3 out of 5 rounds, best Fitness function was 3. in these 3 rounds Evocrash had problem with css parser.

## Frame 36
Target line is covered. Evocrash had problem for covering deeper frame (Frame 34)

## Frame 37
Line is covered. However, EvoCrash could not throw any exception in this line
But ... execution passed from target line and NPE has been thrown in line 143.
Target line is:
```
xhtmlStreamParser.parse(new StringReader(html), printRendererFactory.createRenderer(printer));
```
and `printRendererFactory` is defined as following:
```
PrintRendererFactory printRendererFactory =
                componentManager.getInstance(PrintRendererFactory.class, syntaxId);
```
Noting that, `syntaxId` is an **input argument**.

## Frame 38
Line is not covered.
Evocrash should generate a proper value for `req`, which is an **input argument**, to set state of the SUT in a way that it achieve to target line.

## Frame 41 & 44 & 47 & 50
Line is covered. However, EvoCrash could not throw the right type of exception in this line
Target line is:
```
chain.doFilter(request, response);
```
`chain` is an **input argument**.

## Frame 53
Line is not covered.
The problem is similar to Frame 41 & 44 & 47 & 50.
