# Data incubator challenge // section 2

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


### Question 2
**Consider the case where d=4, n=10, and m=10. Consider the count of
valid walks associated with each possible starting position. What is the
ratio of the highest count of valid walks to smallest count of valid
walks?**



### Question 3
**Consider the case where d=4, n=10, and m=10.
Consider the count of valid walks associated with each possible starting
position. What is the ratio of the standard deviation of the number of
valid walks to the mean of the number of valid walks?**



### Question 4
**Now, let's consider the case where d=8, n=12, and m=12.
How many valid walks start from one of the corners?**



### Question 5
**Consider the case where d=8, n=12, and m=12.
Consider the count of valid walks associated with each possible starting
position. What is the ratio of the highest count of valid walks to
smallest count of valid walks?**



### Question 6
**Consider the case where d=8, n=12, and m=12.
Consider the count of valid walks associated with each possible starting
position. What is the ratio of the standard deviation of the number of
valid walks to the mean of the number of valid walks?**



