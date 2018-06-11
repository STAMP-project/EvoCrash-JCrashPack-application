# CHART-4b

## Stacktrace

```
java.lang.NullPointerException
	at org.jfree.chart.plot.XYPlot.getDataRange(XYPlot.java:4493)
	at org.jfree.chart.axis.NumberAxis.autoAdjustRange(NumberAxis.java:434)
	at org.jfree.chart.axis.NumberAxis.configure(NumberAxis.java:417)
	at org.jfree.chart.axis.Axis.setPlot(Axis.java:1044)
	at org.jfree.chart.plot.XYPlot.<init>(XYPlot.java:660)
	at org.jfree.chart.ChartFactory.createScatterPlot(ChartFactory.java:1490)
```

All frames are reproduced except frame 2.

## Frame 2

Best fitness achieved is 0.3695652 (exception is thrown).

To be thrown in `XYPlot`, the state of the object has to be set in a rather complex way: based on the `axis` parameter of `getDataRange(ValueAxis axis)`, a `mappedDatasets` is built using `XYPlot.getDatasetsMappedToDomainAxis`. The values in this  `mappedDatasets` are then iterate over and used as parameter for method `XYPlot.getRendererForDataset`. It is only if this method `getRendererForDataset` returns a null value that the stacktrace can be reproduced.

When considering frame 1 or frames 3-6, EvoCrash introduces other objects with some complex methods that modifies the state of the frame class's instance. For frame 3 for instance, EvoCrash creates the following test case:

```
NumberAxis numberAxis0 = new NumberAxis();
YIntervalSeriesCollection yIntervalSeriesCollection0 = new YIntervalSeriesCollection();
XYPlot xYPlot0 = null;
xYPlot0 = new XYPlot(yIntervalSeriesCollection0, numberAxis0, numberAxis0, (XYItemRenderer) null);
```

Where the target method `configure` is indirectly called by `new XYPlot` (the explicit call to `configure` is removed during minimisation). The `new XYPlot` call has side effect on the provided parameters.

For frame 2, those calls are not made, which seems to make it hard to set the object in the proper state to trigger the exception.


