=======
Citing Prepdwi
=======

Prepdwi is mainly using the FSL(1,2,3) tools to preprocess the DTI data. For Eddy current correction we used the FSL Eddy tool which is based on (4) and the topup correction for the data collected with reversed phase-encode blips, resulting in pairs of images with distortions going in opposite directions, the susceptibility-induced off-resonance field was estimated using a method similar to that described in [5,Andersson 2003] as implemented in FSL [6,Smith 2004] and the two images were combined into a single corrected one. 

Prepdwi also uses octave (9) in numerical analysis within our pipeline.





1. M.W. Woolrich, S. Jbabdi, B. Patenaude, M. Chappell, S. Makni, T. Behrens, C. Beckmann, M. Jenkinson, S.M. Smith. Bayesian analysis of neuroimaging data in FSL. NeuroImage, 45:S173-86, 2009

2. S.M. Smith, M. Jenkinson, M.W. Woolrich, C.F. Beckmann, T.E.J. Behrens, H. Johansen-Berg, P.R. Bannister, M. De Luca, I. Drobnjak, D.E. Flitney, R. Niazy, J. Saunders, J. Vickers, Y. Zhang, N. De Stefano, J.M. Brady, and P.M. Matthews. Advances in functional and structural MR image analysis and implementation as FSL. NeuroImage, 23(S1):208-19, 2004

3. M. Jenkinson, C.F. Beckmann, T.E. Behrens, M.W. Woolrich, S.M. Smith.  FSL. NeuroImage, 62:782-90, 2012

4. Jesper L. R. Andersson and Stamatios N. Sotiropoulos. An integrated approach to correction for off-resonance effects and subject movement in diffusion MR imaging. NeuroImage, 125:1063-1078, 2016. 

5. J.L.R. Andersson, S. Skare, J. Ashburner How to correct susceptibility distortions in spin-echo echo-planar images:application to diffusion tensor imaging. NeuroImage, 20(2):870-888, 2003.

6. S.M. Smith, M. Jenkinson, M.W. Woolrich, C.F. Beckmann, T.E.J. Behrens, H. Johansen-Berg, P.R. Bannister, M. De Luca, I. Drobnjak, D.E. Flitney, R. Niazy, J. Saunders, J. Vickers, Y. Zhang, N. De Stefano, J.M. Brady, and P.M. Matthews. Advances in functional and structural MR image analysis and implementation as FSL. NeuroImage, 23(S1):208-219, 2004.

7. T.E.J. Behrens, M.W. Woolrich, M. Jenkinson, H. Johansen-Berg, R.G. Nunes, S. Clare, P.M. Matthews, J.M. Brady, and S.M. Smith. Characterization and propagation of uncertainty in diffusion-weighted MR imaging. Magn Reson Med, 50(5):1077-1088, 2003.

8. T.E.J. Behrens, H. Johansen-Berg, S. Jbabdi, M.F.S. Rushworth, and M.W. Woolrich. Probabilistic diffusion tractography with multiple fibre orientations. What can we gain? NeuroImage, 23:144-155, 2007.

9. John W. Eaton, David Bateman, Søren Hauberg, Rik Wehbring (2015).



License information
====================



Other relevant references
-------------------------

.. index::
        pair: Syntax; TOC Tree
