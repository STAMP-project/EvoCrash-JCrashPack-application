# LANG-13b

## Stacktrace

```
java.lang.ClassNotFoundException: byte
	at org.apache.tools.ant.AntClassLoader.findClassInComponents(AntClassLoader.java:1365)
	at org.apache.tools.ant.AntClassLoader.findClass(AntClassLoader.java:1315)
	at org.apache.tools.ant.AntClassLoader.loadClass(AntClassLoader.java:1068)
	at org.apache.commons.lang3.SerializationUtils$ClassLoaderAwareObjectInputStream.resolveClass(SerializationUtils.java:268)
	at org.apache.commons.lang3.SerializationUtils.clone(SerializationUtils.java:95)
```

## Frame 4

Best fitness: failed

Reaching the line requires that a call to `Class.forName` throws a `ClassNotFoundException`. Since the name is get from an `ObjectStreamClass` object, given as parameter to the method, there is no possibility to EvoCrash to instantiate such parameter with the required conditions to throw the exception (EvoCrash can only instantiate objects from classes that are in its classpath). 


# Frame 5

Best fitness: line reached

The method performs a deep clone of the object using serialization. Method uses a template parameter and reflection in sub-calls to instantiate the object.
