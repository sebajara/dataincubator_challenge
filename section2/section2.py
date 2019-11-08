
import numpy as np
from collections import Counter

def list2eqclass(X,n):
    """Takes a coordinate and convertes it to the equivalent-class notation"""
    return tuple(sorted([abs(x - (n-1)/2) for x in X]))

def eqclass2list(Y, n):
    """Takes a coordinate in equivalent-class notation and returns the
    actual coordinate"""
    return [abs(y - (n-1)/2) for y in list(Y)]

def onestep(X, n):
    """Given a position X and size grid n, return a Counter dict with
       all next positions and their frequencies. The positions are
       tuples and in equivalent-class notation"""
    nextlist = []
    for i in range(len(X)):
        if(X[i] > 0):
            next = list(X)
            next[i] = next[i]-1
            nextlist.append(list2eqclass(next, n))
        if(X[i] < n-1):
            next = list(X)
            next[i] = next[i]+1
            nextlist.append(list2eqclass(next, n))
    return Counter(nextlist)

def countpaths(x0, n, m):
    """Given initial potision x0, size of the grid n, and number of
    steps m, returns how many paths are possible"""
    return countpaths_rec({tuple(list2eqclass(x0, n)) : 1}, n, m)

savedcountpaths = {}

def countpaths_rec(dic, n, m):
    """Function that takes a counter dict (in equivalent class
    notation) and recursively computes the number of paths given the
    size of grid n, and number of steps m"""
    global savedcountpaths
    if(m >= 0):
        positions = list(dic.keys())
        frequencies = list(dic.values())
        recfreqs = []
        for i in range(len(positions)):
            p = positions[i]
            f = frequencies[i]
            if(tuple([p,n,m]) in savedcountpaths):
                val = savedcountpaths[tuple([p,n,m])]
            else:
                val = countpaths_rec(onestep(eqclass2list(p, n), n), n , m-1)
                savedcountpaths[tuple([p,n,m])] = val
            recfreqs.append(f*val)
        return sum(recfreqs)
    else:
        return 1

# Example from the problem description:
# countpaths([0,0],3,2) -> 6

# For questions 1-3
print('Precomputing questions 1-3 ...')
n = 10
m = 10
ansd4 = np.empty(shape=[n,n,n,n],dtype=int)
for x1 in range(n):
    for x2 in range(n):
        for x3 in range(n):
            for x4 in range(n):
                ansd4[x1][x2][x3][x4] = countpaths([x1,x2,x3,x4], n, m)

# Answers 1-3
print(' A1: ' + str(ansd4[0][0][0][0]))
print(' A2: ' + str(ansd4.flatten().max()/ansd4.flatten().min()))
print(' A3: ' + str(ansd4.flatten().std()/ansd4.flatten().mean()))

                
# For questions 4-6
print('Precomputing questions 4-6 ...')
n = 12
m = 12
ansd8 = np.empty(shape=[n,n,n,n,n,n,n,n],dtype=int)
for x1 in range(n):
    for x2 in range(n):
        for x3 in range(n):
            for x4 in range(n):
                for x5 in range(n):
                    for x6 in range(n):
                        for x7 in range(n):
                            for x8 in range(n):
                                ansd8[x1][x2][x3][x4][x5][x6][x7][x8] = countpaths([x1,x2,x3,x4,x5,x6,x7,x8], n, m)

# Answers 4-6
print(' A4: ' + str(ansd8[0][0][0][0][0][0][0][0]))
print(' A5: ' + str(ansd8.flatten().max()/ansd8.flatten().min()))
print(' A6: ' + str(ansd8.flatten().std()/ansd8.flatten().mean()))
