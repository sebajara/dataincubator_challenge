# This code was built after the deadline for the challenge, and I ought
# to Ricardo Honorato-Zimmer for figuring out the recursion and
# memoization trick.
# 
# In general, the approach followed here relies on 4 realisations:
# 1) All positions with the same distance to grid centre are equivalent
#    with respect to path counting (what I call equivalent-class).
# 2) It is possible to speed up counting paths by recursively
#    multiplying the frequency of equivalent positions found on each
#    step by the number of paths spawning from each position.
# 3) It is possible to speed up computations by saving in memory the
#    result of recursive steps and retrieving the answer when those
#    points are encountered later (memoization).
# 4) To know the distribution over the whole grid is sufficient to
#    compute only the number of paths for one representative of each
#    equivalent-class, and the number of elements of each class.

from collections import Counter
from itertools import combinations_with_replacement
from sympy.utilities.iterables import multiset_permutations


def list2eqclass(X, n):
    """Takes a coordinate and convertes it to the equivalent-class
    notation"""
    # Examples:
    # list2eqclass([0,1],3) -> (0.0, 1.0)
    # list2eqclass([1,0],3) -> (0.0, 1.0)
    # list2eqclass([1,1],3) -> (0.0, 0.0)
    return tuple(sorted([abs(x - (n-1)/2) for x in X]))


def eqclass2list(Y, n):
    """Takes a coordinate in equivalent-class notation and returns the
    actual coordinate"""
    # Example:
    # eqclass2list((0,0), 3) -> [1.0, 1.0]
    return sorted([abs(y - (n-1)/2) for y in list(Y)])


def onestep(X, n):
    """Given a position X and size grid n, returns a Counter dict with
       all next positions (in equivalent-class notation) and their
       frequencies."""
    # Example:
    # onestep([0,0],3) -> Counter({(0.0, 1.0): 2})
    nextlist = []
    for i in range(len(X)):
        if(X[i] > 0):
            # move down
            next = list(X)
            next[i] = next[i]-1
            nextlist.append(list2eqclass(next, n))
        if(X[i] < n-1):
            # move up
            next = list(X)
            next[i] = next[i]+1
            nextlist.append(list2eqclass(next, n))
    # count all equivalent positions
    return Counter(nextlist)


def countpaths(x0, n, m):
    """Given initial position x0, size of the grid n, and number of
    steps m, returns how many paths are possible starting from that
    position."""
    # Example:
    # countpaths([0,0], 3, 2) -> 6
    dic = {tuple(list2eqclass(x0, n)): 1}  # initial step with frequency 1
    return countpaths_rec(dic, n, m)


# dict used for memoization
savedcountpaths = {}


def countpaths_rec(dic, n, m):
    """Function that takes a counter dict (in equivalent class
    notation) and recursively computes the number of paths given the
    size of grid n, and number of steps m"""
    global savedcountpaths  # dict used for memoization
    if(m >= 0):
        # list of positions in equivalent-class notation
        positions = list(dic.keys())
        # their respective frequencies
        frequencies = list(dic.values())
        recfreqs = []
        # for all branches
        for i in range(len(positions)):
            p = positions[i]
            f = frequencies[i]
            if(tuple([p, n, m]) in savedcountpaths):
                # we know the result already
                npaths = savedcountpaths[tuple([p, n, m])]
            else:
                # convert to regular coordinate system
                realpos = eqclass2list(p, n)
                # compute number of paths and save it
                npaths = countpaths_rec(onestep(realpos, n), n, m-1)
                savedcountpaths[tuple([p, n, m])] = npaths
            # multiply the number of paths by the frequency
            recfreqs.append(f*npaths)
        # sum results from all branches
        return sum(recfreqs)
    else:  # end recursion
        return 1


def eqclassreps(d, n):
    """Given dimension d, and size of grid n, return a list with
    a representative position for each equivalent-class in regular
    notation"""
    return [list(x)
            for x in list(combinations_with_replacement(range(round(n/2)), d))]


def eqinstancesingrid(X, n):
    """Given a coordinate in regular notation (X) returns the number of
    instances in the respective equilent class. Only works for cases
    where n is even, and n > len(X)."""
    d = len(X)
    x = eqclass2list(list2eqclass(X, n), n)
    return (2**d)*len(list(multiset_permutations(x)))


def mymean(values, mdf):
    """Computes the mean of the distribution given by a mass density
    function (mdf) defined over the elements of the list in values"""
    return sum([f*x for (x, f) in zip(values, mdf)])


def mystd(values, mdf):
    """Computes the standard deviation of the distribution given by a
    mass density function (mdf) defined over the elements of the list in
    values"""
    mean = mymean(values, mdf)
    return sum([f*((x-mean)**2) for (x, f) in zip(values, mdf)])**(0.5)


# For questions 1-3
n = 10
m = 10
d = 4
print('Computing questions 1 to 3 ...')
pointsrep1 = eqclassreps(d, n)
pointsrep1_npaths = [countpaths(x, n, m) for x in pointsrep1]
pointsrep1_ngrid = [eqinstancesingrid(x, n) for x in pointsrep1]
pointsrep1_mdf = [n/sum(pointsrep1_ngrid) for n in pointsrep1_ngrid]
# Answers 1-3
countscorner1 = pointsrep1_npaths[0]
min1 = min(pointsrep1_npaths)
max1 = max(pointsrep1_npaths)
mean1 = mymean(pointsrep1_npaths, pointsrep1_mdf)
std1 = mystd(pointsrep1_npaths, pointsrep1_mdf)
print(' A1: ' + str(countscorner1))
print(' A2: ' + str(max1/min1))
print(' A3: ' + str(std1/mean1))

# For questions 4-6
n = 12
m = 12
d = 8
print('Computing questions 4 to 6 ...')
pointsrep2 = eqclassreps(d, n)
pointsrep2_npaths = [countpaths(x, n, m) for x in pointsrep2]
pointsrep2_ngrid = [eqinstancesingrid(x, n) for x in pointsrep2]
pointsrep2_mdf = [n/sum(pointsrep2_ngrid) for n in pointsrep2_ngrid]
# Answers 4-6
countscorner2 = pointsrep2_npaths[0]
min2 = min(pointsrep2_npaths)
max2 = max(pointsrep2_npaths)
mean2 = mymean(pointsrep2_npaths, pointsrep2_mdf)
std2 = mystd(pointsrep2_npaths, pointsrep2_mdf)
print(' A4: ' + str(countscorner2))
print(' A5: ' + str(max2/min2))
print(' A6: ' + str(std2/mean2))
