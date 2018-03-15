# prepdwi
BIDS-app for pre-processing DWI (denoise, unring, top-up, eddy, bedpost.. )

Analysis levels:
* participant: Runs pre-processing including denoising, unringing, top-up, eddy, DWI-T1w boundary-based registration, T1w-T1w template (MNI152_1mm and MNI152NLin2009cAsym) registration, and bedpost. Writes intermediate output to `work` sub-folder, and BIDS derivatives output to `prepdwi` sub-folder. 

* group: Generates HTML reports with QC for brain-masking and registration steps (if lienar registration fails, re-run with `--reg_init_participant` flag to initialize with transform from another subject)

* participant2: Runs probtrackx network connectivity between all regions in a given atlas labels file. Uses either canned atlases with the `--atlas` option, where canned atlases are defined in the `cfg` folder;  or can specify a new atlas with the `--atlas_* options`

```
Usage: prepdwi bids_dir output_dir {participant,group,participant2} <optional arguments>
          [--participant_label PARTICIPANT_LABEL [PARTICIPANT_LABEL...]]
          [--matching_dwi MATCHING_PATTERN
          [--matching_T1w MATCHING_STRING
          [--reg_init_participant PARTICIPANT_LABEL

          [--no-topup]
          [--no-bedpost]
          [--dke]
          [--n_cpus] NCPUS (for bedpost, default: 8)

 participant2 (probtrack connectivity) options:
          [--nprobseeds] N (for probtrackx, default: 5000)
      Choose built-in atlas:
          {--atlas NAME (default: dosenbach)

       Available built-in atlas labels/csv:
          cort_striatum_midbrain	dosenbach  yeo17  yeo17_striatum  yeo7	yeo7_striatum

       Customize atlas labels:
          {--atlas_space NAME (MNI152_1mm or MNI152NLin2009cAsym)
          [--atlas_label_nii NIFTI
          [--atlas_label_csv LABEL_INDEX_CSV
```
