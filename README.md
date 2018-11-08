[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/392)
[![CircleCI](https://circleci.com/gh/khanlab/prepdwi.svg?style=svg)](https://circleci.com/gh/khanlab/prepdwi)

# prepdwi
BIDS-app for pre-processing DWI (denoise, unring, top-up, eddy, bedpost.. )

Analysis levels:
* participant: Runs pre-processing including denoising, unringing, top-up, eddy, DWI-T1w registration, T1w-T1w template (MNI152_1mm and MNI152NLin2009cAsym) registration, and bedpost fitting. Writes intermediate output to `work` sub-folder, and BIDS derivatives output to `prepdwi` sub-folder. 

* group: Generates HTML reports with QC for brain-masking and registration steps (if linear registration fails, re-run with `--reg_init_participant` flag to initialize with transform from another subject)

* participant2: Runs probtrackx network connectivity between all regions in a given atlas labels file. Uses either canned atlases with the `--atlas` option, where predefined atlases are defined in the `cfg` folder;  or can specify a new atlas with the `--atlas_* options`

```
Usage: prepdwi bids_dir output_dir {participant,group,participant2} <optional arguments>
          [--participant_label PARTICIPANT_LABEL [PARTICIPANT_LABEL...]]
          [--matching_dwi MATCHING_PATTERN]
          [--matching_T1w MATCHING_STRING]
          [--reg_init_participant PARTICIPANT_LABEL]
          [--grad_coeff_file GRAD_COEFF_FILE]
          [-w WORK_DIR]  (scratch directory)

          [--no-regT1]
          [--no-topup]
          [--no-bedpost]
          [--no-dke]
          [--n_cpus NCPUS] (for bedpost, default: 8)

 participant2 (probtrack connectivity) options:
          [--nprobseeds] N (for probtrackx, default: 5000)
      Choose built-in atlas:
          [--atlas NAME (default: dosenbach)

       Available built-in atlas labels/csv:
          cort_striatum_midbrain	dosenbach  yeo17  yeo17_striatum  yeo7	yeo7_striatum

       Customize atlas labels:
          {--atlas_space NAME (MNI152_1mm or MNI152NLin2009cAsym)
          [--atlas_label_nii NIFTI
          [--atlas_label_csv LABEL_INDEX_CSV
```
