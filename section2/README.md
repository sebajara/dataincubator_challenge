# Section 2

## Problem 

**Consider a grid in d-dimensional space. There are n grid lines in each
dimension, spaced one unit apart. We will consider a walk of "m" steps
from grid intersection to grid intersection. Each step will be a single
unit movement in any one of the dimensions, such that it says on the
grid. We wish to look at the number of possible paths from a particular
starting location on this grid.**

For example, consider the case where d=2 and n=3. We will label the grid
intersections (x,y), where x,y \in {0,1,2}. There will be six valid
walks starting at (0,0) of length m=2

* (0,0) -> (0,1) -> (0,0)
* (0,0) -> (0,1) -> (0,2)
* (0,0) -> (0,1) -> (1,1)
* (0,0) -> (1,0) -> (0,0)
* (0,0) -> (1,0) -> (2,0)
* (0,0) -> (1,0) -> (1,1)

Note that the walks may double back upon themselves, and multiple walks
may end at the same grid intersection. All of these walks are counted.

## Questions

### Question 1
**Consider the case where d=4, n=10, and m=10. How many valid walks
start from the corner (0, 0, 0, 0)?**

``` python
44569724
```

### Question 2
**Consider the case where d=4, n=10, and m=10. Consider the count of
valid walks associated with each possible starting position. What is the
ratio of the highest count of valid walks to smallest count of valid
walks?**

``` python
23.81209118548726
```

### Question 3
**Consider the case where d=4, n=10, and m=10.
Consider the count of valid walks associated with each possible starting
position. What is the ratio of the standard deviation of the number of
valid walks to the mean of the number of valid walks?**

``` python
0.5106573744484552
```

### Question 4
**Now, let's consider the case where d=8, n=12, and m=12.
How many valid walks start from one of the corners?**

``` python
2479092118264
```

### Question 5
**Consider the case where d=8, n=12, and m=12.
Consider the count of valid walks associated with each possible starting
position. What is the ratio of the highest count of valid walks to
smallest count of valid walks?**

``` python
113.51216384122472
```

### Question 6
**Consider the case where d=8, n=12, and m=12.
Consider the count of valid walks associated with each possible starting
position. What is the ratio of the standard deviation of the number of
valid walks to the mean of the number of valid walks?**

``` python
0.5153659308568227
```

## Personal notes

This version was built after the deadline for the challenge, and I ought
to Ricardo Honorato-Zimmer for figuring out the recursion and
memoization trick.

In general, the approach followed here relies on 4 realisations:
1. All positions with the same distance to grid centre are equivalent
with respect to path counting (what I call equivalent-class in the
code).
2. It is possible to speed up counting paths by recursively multiplying
   the frequency of equivalent positions found on each step by the
   number of paths spawning from that step.
3. It is possible to speed up computation by saving in memory the
   result of recursive steps and retrieving the answer when those points
   are encountered later (memoization).
4. To know the distribution over the whole grid is sufficient to compute
   only representatives of each equivalent-class and know their
   frequency over the grid.
