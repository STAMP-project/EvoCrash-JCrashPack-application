# Example 1
In some of the cases, EvoCrash should generate complex input arguments for the target method. For instance, the search process cannot reproduce the first frame of crash `XWIKI-13708`. This frame is:

```
com.xpn.xwiki.internal.template.TemplateListener.onEvent(TemplateListener.java:79)
```
According to this frame, the target method is `onEvent`. As we can see in the following code, one of the input argument of the target method is `Object source`. In this case, EvoCrash needs to generate an object which is cast-able to the `XWikiDocument`. Also, the casted input should have proper return values for multiple method calls like `getXObject()` or `getAttachment()`. EvoCrash could not generate such a complicated object for the target method.

```java
public void onEvent(Event event, Object source, Object data)
{
    XWikiDocument document = (XWikiDocument) source;

    // Is this a skin document
    if (document.getXObject(WikiSkinUtils.SKINCLASS_REFERENCE) != null) {
        if (event instanceof AbstractAttachmentEvent) {
            XWikiAttachment attachment = document.getAttachment(((AbstractAttachmentEvent) event).getName());
            String id = this.referenceSerializer.serialize(attachment.getReference()); // target line
            ...
            ...
          }
        }
      }
```


# Example 2
In some cases, EvoCrash needs to set some local variables in the CUT before calling the target method. For instance, method `execute(Terminal terminal, OptionSet options)` is the target method in crash `ES-22922` frame 5.  As we can see in the following code, the first lines of this method is using a local variable (`subcommands`). This protected variable is a LinkedHashMap and if it is empty, then the target method throws exception before reaching to the target line. In all of the generate tests, this local variable is empty.

```java
protected void execute(Terminal terminal, OptionSet options) throws Exception {
    if (subcommands.isEmpty()) {
        throw new IllegalStateException("No subcommands configured");
    }
    ...
  }
```

# Example 3
In some of the cases, EvoCrash could not inject the target method to the test because they involve the java generic types. For instance, in crash `ES-20479`, frame 10 point to a method which has generic types as input arguments and return value.

```java
<T> T callInContext(ContextualCallable<T> callable) throws ErrorsException {
  ...
}
```
