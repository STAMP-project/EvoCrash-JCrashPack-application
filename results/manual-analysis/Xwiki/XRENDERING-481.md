XRENDERING-481
```
java.lang.NullPointerException
	at org.xwiki.rendering.internal.macro.toc.TreeParametersBuilder.build(TreeParametersBuilder.java:71)
	at org.xwiki.rendering.internal.macro.toc.TocMacro.execute(TocMacro.java:125)
	at org.xwiki.rendering.internal.transformation.macro.MacroTransformation.transform(MacroTransformation.java:272)
	at org.xwiki.rendering.internal.transformation.DefaultRenderingContext.transformInContext(DefaultRenderingContext.java:183)
	at org.xwiki.rendering.internal.transformation.DefaultTransformationManager.performTransformations(DefaultTransformationManager.java:95)
	at org.xwiki.display.internal.DocumentContentDisplayer.display(DocumentContentDisplayer.java:263)
	at org.xwiki.display.internal.DocumentContentDisplayer.display(DocumentContentDisplayer.java:133)
	at org.xwiki.display.internal.DefaultDocumentDisplayer.display(DefaultDocumentDisplayer.java:96)
	at org.xwiki.sheet.internal.SheetDocumentDisplayer.display(SheetDocumentDisplayer.java:123)
	at org.xwiki.display.internal.ConfiguredDocumentDisplayer.display(ConfiguredDocumentDisplayer.java:68)
	at com.xpn.xwiki.doc.XWikiDocument.display(XWikiDocument.java:1164)
	at com.xpn.xwiki.doc.XWikiDocument.getRenderedContent(XWikiDocument.java:1205)
	at com.xpn.xwiki.doc.XWikiDocument.getRenderedContent(XWikiDocument.java:1182)
	at com.xpn.xwiki.doc.XWikiDocument.getRenderedContent(XWikiDocument.java:1213)
	at com.xpn.xwiki.api.Document.getRenderedContent(Document.java:704)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.apache.velocity.util.introspection.UberspectImpl$VelMethodImpl.doInvoke(UberspectImpl.java:395)
	at org.apache.velocity.util.introspection.UberspectImpl$VelMethodImpl.invoke(UberspectImpl.java:384)
	at org.apache.velocity.runtime.parser.node.ASTMethod.execute(ASTMethod.java:173)
	at org.apache.velocity.runtime.parser.node.ASTReference.execute(ASTReference.java:280)
	at org.apache.velocity.runtime.parser.node.ASTReference.value(ASTReference.java:567)
	at org.apache.velocity.runtime.parser.node.ASTExpression.value(ASTExpression.java:71)
	at org.apache.velocity.runtime.parser.node.ASTSetDirective.render(ASTSetDirective.java:142)
	at org.apache.velocity.runtime.parser.node.ASTBlock.render(ASTBlock.java:72)
	at org.apache.velocity.runtime.parser.node.SimpleNode.render(SimpleNode.java:342)
	at org.apache.velocity.runtime.parser.node.ASTIfStatement.render(ASTIfStatement.java:106)
	at org.apache.velocity.runtime.parser.node.ASTBlock.render(ASTBlock.java:72)
	at org.xwiki.velocity.introspection.TryCatchDirective.render(TryCatchDirective.java:87)
	at org.apache.velocity.runtime.parser.node.ASTDirective.render(ASTDirective.java:207)
	at org.apache.velocity.runtime.parser.node.SimpleNode.render(SimpleNode.java:342)
	at org.xwiki.velocity.internal.DefaultVelocityEngine.evaluateInternal(DefaultVelocityEngine.java:259)
	at org.xwiki.velocity.internal.DefaultVelocityEngine.evaluate(DefaultVelocityEngine.java:222)
	at com.xpn.xwiki.render.DefaultVelocityManager.evaluate(DefaultVelocityManager.java:361)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.evaluateContent(InternalTemplateManager.java:806)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.render(InternalTemplateManager.java:682)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.lambda$renderFromSkin$0(InternalTemplateManager.java:657)
	at com.xpn.xwiki.internal.security.authorization.DefaultAuthorExecutor.call(DefaultAuthorExecutor.java:85)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.renderFromSkin(InternalTemplateManager.java:656)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.renderFromSkin(InternalTemplateManager.java:635)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.render(InternalTemplateManager.java:621)
	at com.xpn.xwiki.internal.template.DefaultTemplateManager.render(DefaultTemplateManager.java:78)
	at com.xpn.xwiki.XWiki.evaluateTemplate(XWiki.java:2131)
	at com.xpn.xwiki.XWiki.parseTemplate(XWiki.java:2109)
	at com.xpn.xwiki.api.XWiki.parseTemplate(XWiki.java:953)
	at sun.reflect.GeneratedMethodAccessor262.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.apache.velocity.util.introspection.UberspectImpl$VelMethodImpl.doInvoke(UberspectImpl.java:395)
	at org.apache.velocity.util.introspection.UberspectImpl$VelMethodImpl.invoke(UberspectImpl.java:384)
	at org.apache.velocity.runtime.parser.node.ASTMethod.execute(ASTMethod.java:173)
	at org.apache.velocity.runtime.parser.node.ASTReference.execute(ASTReference.java:280)
	at org.apache.velocity.runtime.parser.node.ASTReference.render(ASTReference.java:369)
	at org.apache.velocity.runtime.parser.node.ASTBlock.render(ASTBlock.java:72)
	at org.apache.velocity.runtime.directive.VelocimacroProxy.render(VelocimacroProxy.java:216)
	at org.apache.velocity.runtime.directive.RuntimeMacro.render(RuntimeMacro.java:311)
	at org.apache.velocity.runtime.directive.RuntimeMacro.render(RuntimeMacro.java:230)
	at org.apache.velocity.runtime.parser.node.ASTDirective.render(ASTDirective.java:207)
	at org.apache.velocity.runtime.parser.node.SimpleNode.render(SimpleNode.java:342)
	at org.xwiki.velocity.internal.DefaultVelocityEngine.evaluateInternal(DefaultVelocityEngine.java:259)
	at org.xwiki.velocity.internal.DefaultVelocityEngine.evaluate(DefaultVelocityEngine.java:222)
	at com.xpn.xwiki.render.DefaultVelocityManager.evaluate(DefaultVelocityManager.java:361)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.evaluateContent(InternalTemplateManager.java:806)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.render(InternalTemplateManager.java:682)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.lambda$renderFromSkin$0(InternalTemplateManager.java:657)
	at com.xpn.xwiki.internal.security.authorization.DefaultAuthorExecutor.call(DefaultAuthorExecutor.java:85)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.renderFromSkin(InternalTemplateManager.java:656)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.renderFromSkin(InternalTemplateManager.java:635)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.render(InternalTemplateManager.java:621)
	at com.xpn.xwiki.internal.template.DefaultTemplateManager.render(DefaultTemplateManager.java:78)
	at com.xpn.xwiki.XWiki.evaluateTemplate(XWiki.java:2131)
	at com.xpn.xwiki.XWiki.parseTemplate(XWiki.java:2109)
	at com.xpn.xwiki.api.XWiki.parseTemplate(XWiki.java:953)
	at sun.reflect.GeneratedMethodAccessor262.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at org.apache.velocity.util.introspection.UberspectImpl$VelMethodImpl.doInvoke(UberspectImpl.java:395)
	at org.apache.velocity.util.introspection.UberspectImpl$VelMethodImpl.invoke(UberspectImpl.java:384)
	at org.apache.velocity.runtime.parser.node.ASTMethod.execute(ASTMethod.java:173)
	at org.apache.velocity.runtime.parser.node.ASTReference.execute(ASTReference.java:280)
	at org.apache.velocity.runtime.parser.node.ASTReference.render(ASTReference.java:369)
	at org.apache.velocity.runtime.parser.node.ASTBlock.render(ASTBlock.java:72)
	at org.apache.velocity.runtime.directive.VelocimacroProxy.render(VelocimacroProxy.java:216)
	at org.apache.velocity.runtime.directive.RuntimeMacro.render(RuntimeMacro.java:311)
	at org.apache.velocity.runtime.directive.RuntimeMacro.render(RuntimeMacro.java:230)
	at org.apache.velocity.runtime.parser.node.ASTDirective.render(ASTDirective.java:207)
	at org.apache.velocity.runtime.parser.node.ASTBlock.render(ASTBlock.java:72)
	at org.apache.velocity.runtime.parser.node.ASTIfStatement.render(ASTIfStatement.java:87)
	at org.apache.velocity.runtime.parser.node.ASTBlock.render(ASTBlock.java:72)
	at org.apache.velocity.runtime.parser.node.SimpleNode.render(SimpleNode.java:342)
	at org.apache.velocity.runtime.parser.node.ASTIfStatement.render(ASTIfStatement.java:106)
	at org.apache.velocity.runtime.parser.node.SimpleNode.render(SimpleNode.java:342)
	at org.xwiki.velocity.internal.DefaultVelocityEngine.evaluateInternal(DefaultVelocityEngine.java:259)
	at org.xwiki.velocity.internal.DefaultVelocityEngine.evaluate(DefaultVelocityEngine.java:222)
	at com.xpn.xwiki.render.DefaultVelocityManager.evaluate(DefaultVelocityManager.java:361)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.evaluateContent(InternalTemplateManager.java:806)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.render(InternalTemplateManager.java:682)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.lambda$renderFromSkin$0(InternalTemplateManager.java:657)
	at com.xpn.xwiki.internal.security.authorization.DefaultAuthorExecutor.call(DefaultAuthorExecutor.java:85)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.renderFromSkin(InternalTemplateManager.java:656)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.renderFromSkin(InternalTemplateManager.java:635)
	at com.xpn.xwiki.internal.template.InternalTemplateManager.render(InternalTemplateManager.java:621)
	at com.xpn.xwiki.internal.template.DefaultTemplateManager.render(DefaultTemplateManager.java:78)
	at com.xpn.xwiki.XWiki.evaluateTemplate(XWiki.java:2131)
	at com.xpn.xwiki.web.Utils.parseTemplate(Utils.java:180)
	at com.xpn.xwiki.web.XWikiAction.execute(XWikiAction.java:463)
	at com.xpn.xwiki.web.XWikiAction.execute(XWikiAction.java:210)
	at org.apache.struts.action.RequestProcessor.processActionPerform(RequestProcessor.java:425)
	at org.apache.struts.action.RequestProcessor.process(RequestProcessor.java:228)
	at org.apache.struts.action.ActionServlet.process(ActionServlet.java:1913)
	at org.apache.struts.action.ActionServlet.doGet(ActionServlet.java:449)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:687)
	at javax.servlet.http.HttpServlet.service(HttpServlet.java:790)
	at org.eclipse.jetty.servlet.ServletHolder.handle(ServletHolder.java:841)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1650)
	at com.xpn.xwiki.web.ActionFilter.doFilter(ActionFilter.java:112)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1637)
	at org.xwiki.wysiwyg.filter.ConversionFilter.doFilter(ConversionFilter.java:127)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1637)
	at org.xwiki.container.servlet.filters.internal.SetHTTPHeaderFilter.doFilter(SetHTTPHeaderFilter.java:63)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1637)
	at org.xwiki.container.servlet.filters.internal.SavedRequestRestorerFilter.doFilter(SavedRequestRestorerFilter.java:208)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1637)
	at org.xwiki.container.servlet.filters.internal.SetCharacterEncodingFilter.doFilter(SetCharacterEncodingFilter.java:111)
	at org.eclipse.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1637)
	at org.xwiki.resource.servlet.RoutingFilter.doFilter(RoutingFilter.java:134)


```

# Frame 1

EvoCrash can not achieve to the line coverage. The target method is public. So, EvoCrash can directly call `build` method. However, it got stuck in line 61 which is:
```
resolvedRootBlock = context.getXDOM();
```

EvoCrash can not generate a proper input value (`context`) for this method call.

# Frame 2
Same as previous one, it got stuck in a line before the target line:
```
WikiModel wikiModel = this.wikiModelProvider.get();
```

`wikiModelProvider` is injected, but EvoCrash can not set a proper value for it.

# Frame 3

Same as previous ones. The search got stuck in line 202 because it can not set a proper value for one of the complex input arguments (`rootBlock`).

# Frame 4
EvoCrash can not mock the values properly to instantiate the target class.

#Frame 5
The reason is same as frame 3, it got stuck in this line:
```
for (String hint : this.configuration.getTransformationNames()) {
```
It can not set a proper value for one of the complex injected objects (`configuration`).

# Frame 6 & 7
Same as previous ones. It got stuck in line 280 because it can not set a proper value for one of the complex input arguments (`document`).

# Frame 8

Point to the `@inject`.

# Frame 9 & 10
Target line and exception is covered. however, EvoCrash can not generate proper values for achieving 100% stack trace similarity.


# Frame 11 & 12 & 13 & 14
`XWikiDocument` initialization needs complex inputs that EvoCrash can not generate them properly.

# Frame 15
EvoCrash achieves to the target line, but this line has a call to `getXWikiContext`. For executing this method properly, EvoCrash needs to set lots of values properly.

# Frame 29

The target method has nested predicates.

# Frame 32

The target method is private, and its public caller should be called. In the process of public caller invoking, EvoCrash needs to set proper input arguments. However, it can not.

# Frame 33
This frame's target method is the public caller which is mentioned in the previous frame.

# Frame 34
EvoCrash can not set all of the input values properly.

# Frame 35 & 36 & 37 & 39 & 40 & 41
The target methods are in the private inner classes.

# Frame 38
EvoCrash can not reach to the target line. before that it got stuck because it can not set a proper value for input `xcontextProvider`.

# Frame 42
EvoCrash reaches the target line, but it got stuck there because of the improper setting of the variables in the CUT.

# Frame 43 & 44
EvoCrash can not finish initialization of the CUT. It can not set the proper input values.

# Frame 45
EvoCrash throws error during initialisation of injection dependencies.

# Frame 60
Same as frame 32

# Frame 61
Same as frame 33

# Frame 62
Same as frame 34

# Frame 63 & 64 & 65 & 67 & 68 & 69
same as frame 35

# Frame 66
Same as frame 38

# Frame 70
same as frame 42

# Frame 71
same as frame 43

# Frame 72
same as frame 44

# Frame 73
same as frame 45

# Frame 93
Same as frame 32

# Frame 94
Same as frame 33

# Frame 95
Same as frame 34

# Frame 96 & 97 & 98 & 100 & 101 & 102
same as frame 35

# Frame 99
Same as frame 38

# Frame 103
same as frame 42

# Frame 104
same as frame 43

# Frame 105 & 106 & 107
Target method contains more than 200 lines of code and it contains nested predicates.

# Frame 116 & 118 & 120 & 122 & 124 & 126
EvoCrash reaches the target line. It got stuck in this line because it can not set a proper value for `chain` input argument.
