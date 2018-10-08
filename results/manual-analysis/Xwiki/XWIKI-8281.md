XWIKI-8281
```
java.lang.IndexOutOfBoundsException: Index: 0, Size: 0
	at com.xpn.xwiki.doc.XWikiDocument.getDocumentSection(XWikiDocument.java:7845)
	at com.xpn.xwiki.web.EditAction.updateDocumentTitleAndContentFromRequest(EditAction.java:224)
	at com.xpn.xwiki.web.EditAction.prepareEditedDocument(EditAction.java:95)
	at com.xpn.xwiki.web.EditAction.render(EditAction.java:58)
	at com.xpn.xwiki.web.XWikiAction.execute(XWikiAction.java:432)
```
# Frame 1
The line is reached, but EvoCrash cannot throw exception.

# Frame 2
Permission denied.

# Frame 3
EvoCrash cannot generate inputs to reach the target line.

# Frame 4
EvoCrash can reach the target line, but it got stuck in the same location as the deeper frame.

# Frame 5
The target method has more than 300 lines of code.
