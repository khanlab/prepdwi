.. HOME documentation master file, created by
   sphinx-quickstart on Thu Jul 19 14:49:39 2018.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Prepdwi Documentation
=====================

Prepdwi is a BIDS App developed by the Khan Lab to pre-process diffusion-weighted MRI data and perform simple tractography.  Steps to generate a pre-processed DWI image include de-noising,  unringing, EPI distortion correction (top-up, and if necessary non-linear image registration), eddy correction, gradient correction (requires coefficient file), and rigid registration to T1w.  The app also generates FSL FDT dtifit maps, DKE kurtosis maps (for multi-shell DWI only), and FSL BEDPOST pre-processing (CPU parallelization over slices).  

.. toctree::
   :maxdepth: 2

   installation
   pipeline
   support
   citing




