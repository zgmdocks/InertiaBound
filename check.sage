import os
import operator as op
import time
load('signing.sage')

import sys

# this logger class is needed so output is written to a file while still output to the
# command line
class Logger(object):
    def __init__(self):
        self.terminal = sys.stdout
        self.log = open("DeleteVertices.txt", "a")

    def write(self, message):
        self.terminal.write(message)
        self.log.write(message)  

    def flush(self):
        #this flush method is needed for python 3 compatibility.
        #this handles the flush command by doing nothing.
        #you might want to specify some extra behavior here.
        pass    

#sys.stdout = Logger()

# if moreDebug is true, information will be printed to screen to help debug issues
# or just figure out what the program is doing. The following things will be printed:
# time taken for certain processes, the independent number, number of vertices,
# the number of subgraphs needed to iterate over, the number of subraphs that are
# potentially useable, and the success of finding a contradictary case.
moreDebug = True
# showFigs will save and open files showing the graph, path used, and subgraphs used
showFigs = False
openFig = False
# change Guess to 0 if you want it to make a guess, and change it to any value other than
# 0, 1, or -1 if you don't want it to guess.
Guess = 0

# ncr returns n choose r
def ncr(n, r):
    r = min(r, n-r)
    if r == 0: return 1
    numer = reduce(op.mul, xrange(n, n-r, -1))
    denom = reduce(op.mul, xrange(1, r+1))
    return numer//denom

# check takes a graph G as input and returns true if the 
# graph satisfies all properties that would make
# it a good candidate for the method used in John 
# Sinkovic's Paper to find an inertia bound that
# is not tight
def check(G):
    if moreDebug:
        # t0 is used to help time how long processes are taking to understand
        # how the problem will scale as we increase the number of vertices.
        t0 = time.clock()
    alpha = len(G.independent_set())
    numVertices = len(G)
    if 2*alpha+1 > numVertices:
        if moreDebug:
            print "alpha too large"
        return False
    if moreDebug:
        print "alpha is {}".format(alpha)
        print "numVerties is {}".format(numVertices)
        print "number of combinations will be {}".format(ncr(numVertices,2*alpha+1))
    if not is_alpha_critical(G):
        if moreDebug:
            print "alpha critical"
        return False
    path = G.hamiltonian_path()
    if not path:
        if moreDebug:
            print "no hamiltionian"
        path = G.random_spanning_tree()
    subgraphs = set()
    trianglesCheck = set()
    counter = 0
    for combo in Combinations(numVertices,2*alpha+1):
        counter += 1
        if moreDebug:
            if counter % 1000 == 0:
                print counter
        I = G.subgraph(combo,immutable=true)
        #this next while loop will delete all pendants of g,
        #then check if the resulting g is a: a single odd cycle
        # or b: a disjoint union of odd cycles. if it is in category
        # a, then it is added to trainglesCheck list, and if it is in b,
        # it is added to subgraphs list
        h = G.subgraph(combo)
        # this changed variable is necessary because when we iterate through the
        # vertices, we are deleting some and creating new pendants that we need
        # to delete also, but if we already iterated over that vertice, then
        # we won't realize that it still needs to be deleted so we need to
        # keep iterating over the vertices until we get to a point where we don't
        # find and delete any new pendants
        changed = True
        while changed:
            changed = False
            for v in h.vertex_iterator():
                if len(h[v]) == 1:
                    changed = True
                    h.delete_vertex(h[v][0])
                    h.delete_vertex(v)
                    break
        if h.is_cycle() and h.order()%2 == 1:
            copy = h.copy(immutable=true)
            trianglesCheck.add(copy)
        components = h.connected_components_subgraphs()
        if not components:
            break
        continue_loop = False
        for com in components:
            if (not com.is_cycle()) or (not com.order()%2 == 1):
                continue_loop = True 
                # need continue_loop because I want to continue out of outer for
                # loop, but using continue now will only continue out of 
                # the inner for loop
                break
        if continue_loop:
            continue
        # if we make it to this point, every component was an odd cycle
        subgraphs.add(I)
    if moreDebug:
        print "number of subgraphs: {}".format(len(subgraphs))
        print "**************************** {}".format(time.clock() - t0)
    T = graphs.CompleteGraph(3)
    Triangles = contained(G,T,trianglesCheck)
    if moreDebug:
        print "number of triangles to use: {}".format(len(Triangles))
    if moreDebug:
        print "number of triangles: {}".format(len(Triangles))
    if not Triangles:
        print "contained"
        return False
    # finished preliminary check, now to check signs
    if debug:
        print "Check passed"
        print len(subgraphs)
    for e in G.edge_iterator(labels=false):
        temp1 = e[0]
        temp2 = e[1]
        G.delete_edge(e)
        if path.has_edge(e):
            if debug:
                print e
            G.add_edge((temp1,temp2,1))
        else:
            G.add_edge((temp1,temp2,10))
    M1 = G.weighted_adjacency_matrix()
    M2 = G.weighted_adjacency_matrix()
    if debug:
        print M1
    if not signing(G,M1,subgraphs,1,Triangles, Guess,''):
        return False
    if moreDebug:
        print "************* Positive Signing found a contradiction **********************"
    if not signing(G,M2,subgraphs,-1,Triangles, Guess,''):
        return False
    if showFigs:
        pathGraphic = path.plot()
        pathGraphic.save('path.png')
        if openFig:
            os.system('open path.png')
    return True


# contained returns true if the each triangle in G is
# contained in at least one subgraph of the form SubGraph and
# false otherwise
def contained(G, Triangle, SubGraphs):
    Triangles = set()
    #calculates the total number of triangles in G
    for triangle in G.subgraph_search_iterator(Triangle,induced = true):
        for s in SubGraphs:
            if set(triangle).issubset(set(s)):
                Triangles.add(tuple(triangle))
                break
    return Triangles



# is_alpha_critical returns true if the graph G is alpha critical
def is_alpha_critical(G):
    alpha=len(G.independent_set())
    for i in G.edges():
        H=G.copy()
        H.delete_edge(i)
        if len(H.independent_set())==alpha:
            return False
    return True

if showFigs:
    g = Graph(r"Jtv`plZXy^_")
    g.allow_loops(False)
    g.allow_multiple_edges(False)
    graphic = g.plot()
    graphic.save('output.png')
    if openFig:
        os.system('open output.png')
    print check(g)
