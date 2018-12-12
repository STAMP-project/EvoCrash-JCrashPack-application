# Example 1
In crash `ES-14457`, the target line of frame 4 is in a try catch:
```java
try {
    TransportAddress[] addresses = transportService.addressesFromString(host, limitPortCounts);
    for (TransportAddress address : addresses) {
        configuredTargetNodes.add(new DiscoveryNode(UNICAST_NODE_PREFIX + unicastNodeIdGenerator.incrementAndGet() + "#", address, version.minimumCompatibilityVersion()));
    }
} catch (Exception e) {
    throw new IllegalArgumentException("Failed to resolve address for [" + host + "]", e);
}
```
EvoCrash reached to the target line. However, it cannot throw the exception in this line. Instead of the target line, EvoCrash can achieve a test which throws the exception in the next lines. Though, it cannot deliver the similar stack trace.
As a side note, EvoCrash was successful in reproducing the first 3 frames of this crash.
