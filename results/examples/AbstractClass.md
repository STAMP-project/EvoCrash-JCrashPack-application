# Example 1
EvoCrash could not find any generator for `org.elasticsearch.transport.TcpTransport` during the experiment on `ES-22119` (frames 3 and 4). Also, this tool could not mock the class. This class is an **abstract class**, and EvoCrash could not find the implementation of it.

# Example 2
In `XRENDERING-422` frame 6, The target line is:
```java
listener.endFormat(format, parameters);
```
The type of `listener` is `AbstractChainingListener` which is an abstract class. EvoCrash can set `listener` to any extension of this abstract class. EvoCrash cannot find the right one.
