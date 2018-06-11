# MATH-79b

## Stacktrace

```
java.lang.NullPointerException
	at org.apache.commons.math.stat.clustering.KMeansPlusPlusClusterer.assignPointsToClusters(KMeansPlusPlusClusterer.java:91)
	at org.apache.commons.math.stat.clustering.KMeansPlusPlusClusterer.cluster(KMeansPlusPlusClusterer.java:57)
```

## Frame 2

Fitness decreases to 0.2 but not further. Line is reached and exception is thrown but stacktrace similarity remains 0.2. Generate stacktrace is:

```
java.lang.NullPointerException
	at org.apache.commons.math.stat.clustering.KMeansPlusPlusClusterer.getNearestCluster(KMeansPlusPlusClusterer.java:156)
	at org.apache.commons.math.stat.clustering.KMeansPlusPlusClusterer.assignPointsToClusters(KMeansPlusPlusClusterer.java:90)
	at org.apache.commons.math.stat.clustering.KMeansPlusPlusClusterer.cluster(KMeansPlusPlusClusterer.java:57)
```

There is an initialisation phase before calling the `assignPointsToClusters` method. This initialisation phase is performed by  `chooseInitialCenters` and uses a random number generator:

```
    public List<Cluster<T>> cluster(final Collection<T> points,
                                    final int k, final int maxIterations) {
        // create the initial clusters
        List<Cluster<T>> clusters = chooseInitialCenters(points, k, random);
        assignPointsToClusters(clusters, points);
		...
```

Making it very hard to EvoCrash to initialise the test case properly before calling cluster.