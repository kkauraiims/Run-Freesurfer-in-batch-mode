#!/usr/bin/env bash

# the script accepts '.nii.gz' as input file 
# for DICOM folders, please check: scripts/run_freesurfer_batch_dicom.sh
# for any other format, please modify the code below

# check that FreeSurfer is set-up correctly
if ! command -v recon-all >/dev/null 2>&1; then
    echo "Error: recon-all not found. Please set up FreeSurfer first:"
    echo "source \$FREESURFER_HOME/SetUpFreeSurfer.sh"
    exit 1
fi

# check if at least one subject name was provided 
# if not explain the user how to add subject names
if [ "$#" -eq 0 ]; then
    echo "Error: No subject names were provided."
    echo "Please add subject names after the path to the script, separated by spaces."
    echo "Example:"
    echo "bash run_freesurfer_batch.sh S001 S002 S003"
    exit 1
fi

# check that each subject has a corresponding .nii.gz file in the current directory
for str in "$@"; do
    if [ ! -f "${str}.nii.gz" ]; then
        echo "Error: MRI file not found for subject: $str"
        echo "Expected file: ${str}.nii.gz"
        echo "Please check that you are in the correct SUBJECTS_DIR and that the file name matches the subject name."
        exit 1
    fi
done

# if all is well until this point
# run recon-all for each subject provided as input
for str in "$@"; do
    echo "Processing subject: $str"
    recon-all -i "${str}.nii.gz" -s "$str" -all
done
