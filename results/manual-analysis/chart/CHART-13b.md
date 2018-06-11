# CHART-13b

## Stacktrace

```
java.lang.IllegalArgumentException: Range(double, double): require lower (0.0) <= upper (-2.3000000000000007).
	at org.jfree.data.Range.<init>(Range.java:87)
	at org.jfree.chart.block.BorderArrangement.arrangeFF(BorderArrangement.java:454)
	at org.jfree.chart.block.BorderArrangement.arrange(BorderArrangement.java:152)
	at org.jfree.chart.block.BorderArrangement.arrangeFN(BorderArrangement.java:323)
	at org.jfree.chart.block.BorderArrangement.arrange(BorderArrangement.java:149)
	at org.jfree.chart.block.BlockContainer.arrange(BlockContainer.java:182)
```

Frame 1 is reproduced.

## Frame 2

Best fitness is 4 (could not reach the line where the exception is thrown). This is probably due to the condition in `Range.<init>`:

```
if (lower > upper) {
	String msg = "Range(double, double): require lower (" + lower 
		+ ") <= upper (" + upper + ").";
	throw new IllegalArgumentException(msg);
}
```

Which is hard to satisfy from `BorderArrangement.arrangeFF`, where we have `new Range(0.0, constraint.getWidth() - w[2])`, `constraint` is a parameter and `w` is built from `constraint`.

## Frames 3

Best fitness is 0.3432836 (exception thrown). As for frame 2, in order to get the correct call stack from the `arrange` method, parameters have to be initialised in order to have the  good `if` condition activated.

```
if (w == LengthConstraintType.NONE) {
	if (h == LengthConstraintType.NONE) {
		contentSize = arrangeNN(container, g2);
	}
	else if (h == LengthConstraintType.FIXED) {
		throw new RuntimeException("Not implemented.");
	}
	else if (h == LengthConstraintType.RANGE) {
		throw new RuntimeException("Not implemented.");
	}
}
else if (w == LengthConstraintType.FIXED) {
	if (h == LengthConstraintType.NONE) {
		contentSize = arrangeFN(container, g2, constraint.getWidth());
	}
	else if (h == LengthConstraintType.FIXED) {
		contentSize = arrangeFF(container, g2, constraint);
	}
	else if (h == LengthConstraintType.RANGE) {
		contentSize = arrangeFR(container, g2, constraint);
	}
}
else if (w == LengthConstraintType.RANGE) {
	if (h == LengthConstraintType.NONE) {
		throw new RuntimeException("Not implemented.");
	}
	else if (h == LengthConstraintType.FIXED) {
		throw new RuntimeException("Not implemented.");
	}
	else if (h == LengthConstraintType.RANGE) {
		contentSize = arrangeRR(container, constraint.getWidthRange(),
				constraint.getHeightRange(), g2);
	}
}
```

## Frame 4

Best fitness is 0.3934010 (exception thrown). Same problem as previously in `arrangeFN` method:

```
if (this.topBlock != null) {
	Size2D size = this.topBlock.arrange(g2, c1);
	w[0] = size.width;
	h[0] = size.height;
}
if (this.bottomBlock != null) {
	Size2D size = this.bottomBlock.arrange(g2, c1);
	w[1] = size.width;
	h[1] = size.height;
}
RectangleConstraint c2 = new RectangleConstraint(0.0,
		new Range(0.0, width), LengthConstraintType.RANGE,
		0.0, null, LengthConstraintType.NONE);
if (this.leftBlock != null) {
	Size2D size = this.leftBlock.arrange(g2, c2);
	w[2] = size.width;
	h[2] = size.height;
}
if (this.rightBlock != null) {
	double maxW = Math.max(width - w[2], 0.0);
	RectangleConstraint c3 = new RectangleConstraint(0.0,
			new Range(Math.min(w[2], maxW), maxW),
			LengthConstraintType.RANGE, 0.0, null,
			LengthConstraintType.NONE);
	Size2D size = this.rightBlock.arrange(g2, c3);
	w[3] = size.width;
	h[3] = size.height;
}

h[2] = Math.max(h[2], h[3]);
h[3] = h[2];

if (this.centerBlock != null) {
	RectangleConstraint c4 = new RectangleConstraint(width - w[2]
			- w[3], null, LengthConstraintType.FIXED, 0.0, null,
			LengthConstraintType.NONE);
	Size2D size = this.centerBlock.arrange(g2, c4);
	w[4] = size.width;
	h[4] = size.height;
}
```

## Frame 5

Best fitness is 0.4192308 (exception thrown). See Frame 3.

## Frame 6

Best fitness is 0.4349845 (exception thrown). Method `BlockContainer.arrange` contains only a call to `BorderArrangement.arrange`. See Frame 3

