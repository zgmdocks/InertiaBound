# SageCode

The files found in this repository were used to investigate the inertia bound, also known as the Cvetkovic bound, throughout a undergraduate research assistantship with Chris Godsil and John Sinkovic in the Spring of 2017. 

## Inertia Bound
The inertia bound is defined as follows:

**Inertia Bound** - Let G be a graph on *n* vertices, and *W* be a weight matrix of *G*. Then the following inequality holds:
<p align="center"><a href="https://www.codecogs.com/eqnedit.php?latex=\alpha(G)&space;\leq&space;\min\{|G|&space;-&space;n_&plus;(W),|G|-n_-(W)\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\alpha(G)&space;\leq&space;\min\{|G|&space;-&space;n_&plus;(W),|G|-n_-(W)\}" title="\alpha(G) \leq \min\{|G| - n_+(W),|G|-n_-(W)\}" /></a></p>

<a href="https://www.codecogs.com/eqnedit.php?latex=\alpha(G)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\alpha(G)" title="\alpha(G)" /></a> - the independence number of *G*

<a href="https://www.codecogs.com/eqnedit.php?latex=n_&plus;(W)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?n_&plus;(W)" title="n_+(W)" /></a> - the number of positive eigenvalues of *W*

<a href="https://www.codecogs.com/eqnedit.php?latex=n_-(W)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?n_-(W)" title="n_-(W)" /></a> - the number of negative eigenvalues of *W*
 
More information on the inertia bound, other relevant definitions, and the proof that verifies the methods used in the code in this repository can be found in the following [paper](https://arxiv.org/abs/1609.02826).

## Files & Descriptions:

### NonTightGraphs.txt
This file contains a database of graphs that were found to have a non-tight inertia bound. Each line corresponds to a graph written in its graph6 string form and the file is ordered by the number of vertices in the graphs. More information on graph6 strings can be located in the following [SageMath manual](http://doc.sagemath.org/html/en/reference/graphs/sage/graphs/graph.html#sage.graphs.graph.Graph.graph6_string).

### Original19.txt
This file contains 19 graphs, one on each line, written in their graph6 string form. All graphs with a non-tight inertia bound that were found (the graphs found in NonTightGraphs.txt) were obtained by looking at subgraphs of the graphs found in this file.

### check.sage & signing.sage
These two scripts create the program that has been used to determine if a graph has a non-tight inerta bound using a proof method found in the following [paper](https://arxiv.org/abs/1609.02826) by John Sinkovic.

You can run this file on a specific graph by following the following instructions:

**1. Inputting the graph you wish to check for a non-tight inertia bound**
    
![Alt text](https://user-images.githubusercontent.com/19316223/29586906-496c2398-875a-11e7-9af7-0dc4d7aa3257.png)

On line 197 in the screenshot, change the string inside of the Graph() function to the graph6 string of the graph you want to check.

**2. Change the information the program outputs**
![Alt text](https://user-images.githubusercontent.com/19316223/29588904-2de82534-8761-11e7-8d4f-4d6c75534264.png)

By setting the debug and moreDebug variables to True, the program will print useful information that can be used to verify that a graph has a non-tight inertia bound, or can show where the method to prove that the graph has a non-tight inertia bound fails.

RunScript being set to True will cause the program to execute the last few lines in the file where you entered the graph you wish to check for a non-tight inertia bound in step 1.

openfig being set to True will open and save relevant images to the current directory. This option will save the graph being examined, the path/tree that had its edges set to positive, and the subgraphs that were used to find a contradiction and prove that the graph has a non-tight inertia bound.

Guess being set to 0 will cause the program to consider the cases of when an edge that is currently unsigned, is set to positive and when it is set to negative. This option will only be utilized when all edges that can be signed have been signed and the program would normally terminate with a return value of False (indicating the graph could not be determined if it had a non-tight inertia bound). Only if both the case when the edge is set to positive and when it is set to negative give 
