# Example 1
In the first 4 frames of crash `ES-21061`, EvoCrash could not finish the search process. In all of the cases, EvoSuite security manager throw the following error:
```
 MSecurityManager - SUT asked for a runtime permission that EvoSuite does not recognize: getFileStoreAttributes
```
After this message, EvoCrash could not cover any new execution path, and after a while it crashed.

# Example 2
In many stack traces, we have frames which point to the `XWikiHibernateBaseStore` or `XWikiHibernateStore` classes. For instantiating these classes we need a configuration file path as input to process. One of the crashes which we have this challenge in it is `XWIKI-12584` frame 1-4.
