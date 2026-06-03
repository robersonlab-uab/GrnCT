# GrnCT
Code repository for analyses associated with the manuscript titled: "Carboxy-terminal blockade of sortilin binding enhances progranulin gene therapy
in a mouse model of frontotemporal dementia." Published by Kashyap and Fox in 2026 from Erik Roberson's lab at University of Alabama at Birmingham.

## Contents

### ImageJ/Fiji Macros
- **Iba1_Lipo.ijm** — Automated image analysis of Iba1-labeled microglia and lipofuscin puncta
- **ND2_to_NRRD.ijm** — Converts Nikon .nd2 files to NRRD format for use in 3D Slicer
- **ND2_to_TIFF.ijm** — Converts Nikon .nd2 files to TIFF format
- **ReverseROImask.ijm** — Generates an inverse ROI mask for region-based image analysis

### R Scripts
- **Density_dist_branch.R** — Analysis of microglial density, distribution, and branching morphology
- **LMEM_SSCTX.R** — Used in the preprinted version on BioRxiv (Fig 4). During reviews for publishing, our biostatistisian, Dr. Charles Murchison, elected to use a restricted maximum likelihood (RMEL) mixed-effects model with a Tukey's multiple comparison (the code listed here does not do the RMEL in the final version, but is kept here for transparency and record-keeping).
- **Sphericity_SSCTX.R** — Quantification of microglial sphericity in somatosensory cortex

### 3D Morphology
- **Slicer_Morph** — Parameters and files for 3D morphometric analysis using the SlicerMorph extension in 3D Slicer

## Third-Party Resources

The following libraries (in their corresponding folders) are the property of their respective authors and were used in analyses associated with this manuscript. They are archived here for reproducibility purposes.

### Keypoint MoSeq
- **Source:** https://github.com/dattalab/keypoint-moseq
- **Description:** An unsupervised machine learning framework for identifying stereotyped behavioral modules from keypoint tracking data without human supervision.
- **Reference:** Weinreb C, Pearl JE, Lin S, Osman MAM, Zhang L, Annapragada S, Conlin E, Hoffmann R, Makowska S, Gillis WF, Jay M, Ye S, Mathis A, Mathis MW, Pereira T, Linderman SW, Datta SR. Keypoint-MoSeq: parsing behavior by linking point tracking to pose dynamics. *Nature Methods.* 2024;21(7):1329–1339. DOI: 10.1038/s41592-024-02318-2

### 3DMorph
- **Source:** https://github.com/ElisaYork/3DMorph
- **Description:** A MATLAB-based script for automated analysis of microglial morphology from 3D imaging data. Outputs include cell and territorial volume, branch length, and branch and end point counts.
- **Reference:** York EM, LeDue JM, Bernier LP, MacVicar BA. 3DMorph automatic analysis of microglial morphology in three dimensions from *ex vivo* and *in vivo* imaging. *eNeuro.* 2018;5(6):ENEURO.0266-18.2018. DOI: 10.1523/ENEURO.0266-18.2018

## Dependencies
- Fiji/ImageJ
- R (v4.4.2)
- 3D Slicer with SlicerMorph extension
- Python (Keypoint MoSeq)
- MATLAB (3DMorph)

## Contact
For questions, please contact Erik Roberson's lab at the University of Alabama at Birmingham.
