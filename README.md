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

Guess being set to 0 will cause the program to consider the cases of when an edge that is currently unsigned, is set to positive and when it is set to negative. This option will only be utilized when all edges that can be signed have been signed and the program would normally terminate with a return value of False (indicating the graph could not be determined if it had a non-tight inertia bound). Only if both the case when the edge is set to positive and when it is set to negative create a contradiction as described in the method in the paper linked above, will the graph be determined to have a non-tight inertia bound. Setting guess to a number other than 0, 1, or -1 will cause the program to terminate and return False when no more edges can be guessed and a contradiction has not yet been reached.

**3. Running the program**

In the terminal, type
```
sage check.sage
```
This will run the program with the graph that you entered in step 1 and print the output to the terminal.

**4. Reading the output**
Depending on which variables have been changed, this output may be different. The output described will be assumed that debug and moreDebug are set to True and Guess is set to 0.
First off, the program will check the graph to ensure it is alpha-critical, will find all nonsingular subgraphs of size 2\*\alpha(G)+1 and is of the form necessary to be used in the method, and will find all the triangles that must be the same sign (information on why these checks are performed or definitions of the terms can be found in the paper linked above). The results of these checks will be printed to the screen as shown below.

![Alt text](https://user-images.githubusercontent.com/19316223/29589774-8cb1d8d2-8764-11e7-949d-afa1f9ef2153.png)

Next the program will find a path/tree so that we can set all the edges to be positively signed and will print the edges in this path, followed by the weight matrix associated with the graph. This weight matrix has 0's in entries where the vertices have no edge, 10's where the vertices share an edge but the program has not determined yet if that edge must be positively or negatively signed, 1's if the edge is postively signed, and -1's if the edge is negatively signed. The following screenshot is an example of what will be printed from this part.

![Alt text](https://user-images.githubusercontent.com/19316223/29590088-2b173b42-8766-11e7-8efb-e8ed31ba5cb8.png)

The next information printed to the screen will be information on the signing of the edges. It will notify that a new edge signing is beginning, then will state what the sign of the triangles will be (the sign of the triangles is the sign of the product of the edges in the triangle). It will say the triangles' sign is 1 if the triangles are positively signed, and -1 if the triangles are negatively signed. Then it will begin to determine signs of edges that are currently unsigned. It will state the triangle that is used to determine the new edge sign, then the edge of each sign in the triangle, followed by the new sign of the edge that was previously unsigned in the triangle. This will continue until the program cannot determine anymore edges. An example of a print out of this process is in the screenshot below.

![Alt text](https://user-images.githubusercontent.com/19316223/29590692-0da37708-8769-11e7-9e94-2522f797b4be.png)






