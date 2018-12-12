# Example 1
In frame 1 and 2 of  ES-20045, The target class is not loaded. EvoCrash fails with `Error while initializing target class: java.lang.ExceptionInInitializerError`.
The target class is abstract. Evocrash tries to find an implementation of it (`IndexScopedSettings`). This implementation uses `IndexMetaData` static variables. One of these static variables should be set acroding to the static variable of another class (`AutoExpandReplicas`).in `AutoExpandReplicas`, we need to declare this static variable:
```java
private static final DeprecationLogger DEPRECATION_LOGGER = new DeprecationLogger(Loggers.getLogger(AutoExpandReplicas.class));
```
So, it needs to initialize `DeprecationLogger` which has static initializer and it throws `java.lang.ExceptionInInitializerError`.
