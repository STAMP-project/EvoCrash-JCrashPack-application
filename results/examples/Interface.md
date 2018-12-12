# Example 1
In `ES-21457`, frame 9 points to an interface (following code) as the target class.
```java
public interface TransportRequestHandler<T extends TransportRequest> {

    /**
     * Override this method if access to the Task parameter is needed
     */
    default void messageReceived(final T request, final TransportChannel channel, Task task) throws Exception {
        messageReceived(request, channel);
    }

    void messageReceived(T request, TransportChannel channel) throws Exception;
}
```
