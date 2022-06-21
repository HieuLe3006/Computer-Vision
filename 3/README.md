# Description
This is an **Augmented Reality** application using *planar homographies*.
<br />
*Planar homography* is a warp operation that maps pixel coordinates from one camera frame to another of the same points. This usually raises a problem in which 
rdinary least squares is not possible to be used as the projective geometry in this case is of the form x = λHx′. We can bypass such dilemma by applying *Direct Linear Transform*, where the equation is rewritten into homogeneous equations that are solvable using standard least squares method.  
<br /> 
There are 2 major parts in this project:
1. Convert a cover of any book into a cover of a HarryPotter book. These are the steps:
	
2. Create an Augmented Reality application:
These are the steps to create our AR application:
- Computing Planar Homographies:
	1. Feature detection, description, and matching: find corresponding point pairs between 2 images using **FAST detector** (*detectFASTFeature* function in Matlab)  with **BRIEF descriptor** (*computeBrief* function). In order to better see these points, adjust threshold parameter on *matchFeature()* function) 
	2. Compute Homography: estimate the planar homography from a set of matched point pairs.
	3. Homography Normalization to improve the stability of the solution.
	4. Use **RANSAC algorithm** - an iterative method for estimating a mathematical model from a dataset that contains outlier, to fit model to noisy data. 
	5. HarryPotterize a book: read a book  
- Creating Augmented Reality app:
