# SageCode

The files found in this repository were used to investigate the inertia bound, also known as the Cvetkovic bound.

## Inertia Bound
The inertia bound is defined as follows:

**Inertia Bound** - Let G be a graph on *n* vertices, and *W* be a weight matrix of *G*. Then the following inequality holds:
 <a href="https://www.codecogs.com/eqnedit.php?latex=\alpha(G)&space;\leq&space;\min\{|G|&space;-&space;n_&plus;(W),|G|-n_-(W)\}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\alpha(G)&space;\leq&space;\min\{|G|&space;-&space;n_&plus;(W),|G|-n_-(W)\}" title="\alpha(G) \leq \min\{|G| - n_+(W),|G|-n_-(W)\}" /></a> with <a href="https://www.codecogs.com/eqnedit.php?latex=\alpha(G)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\alpha(G)" title="\alpha(G)" /></a> being the independence number of *G*, <a href="https://www.codecogs.com/eqnedit.php?latex=n_&plus;(W)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?n_&plus;(W)" title="n_+(W)" /></a> being the number of positive eigenvalues of *W*, and <a href="https://www.codecogs.com/eqnedit.php?latex=n_-(W)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?n_-(W)" title="n_-(W)" /></a> being the number of negative eigenvalues of *W*
 
More information on the inertia bound, other relevant definitions, and the proof that verifies the methods used in the code in this repository can be found in the following [paper](https://arxiv.org/abs/1609.02826).

