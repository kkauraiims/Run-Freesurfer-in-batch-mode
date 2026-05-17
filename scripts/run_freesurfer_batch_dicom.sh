#!/usr/bin/env bash

# This script accepts DICOM folders as input.
# Each subject should have a folder named which is the same as the subject ID.
# For 'nii.gz' file format please check scripts/run_freesurfer_batch.sh 
# For any other format, please modify the code below 

# Check that FreeSurfer is set up correctly
if ! command -v recon-all >/dev/null 2>&1; then
    echo "Error: recon-all not found. Please set up FreeSurfer first:"
    echo "source \$FREESURFER_HOME/SetUpFreeSurfer.sh"
    exit 1
fi

# Check that at least one subject name was provided
if [ "$#" -eq 0 ]; then
    echo "Error: No subject names were provided."
    echo "Please add subject names after the path to the script, separated by spaces."
    echo "Example:"
    echo "bash run_freesurfer_batch_dicom.sh S001 S002 S003"
    exit 1
fi

# Check that each subject has a corresponding DICOM directory
for str in "$@"; do
    if [ ! -d "$str" ]; then
        echo "Error: DICOM folder not found for subject: $str"
        echo "Expected folder: $str"
        echo "Please check that you are in the correct SUBJECTS_DIR and that the folder name matches the subject name."
        exit 1
    fi
done

# Check that each DICOM directory contains at least one .dcm or .DCM file
for str in "$@"; do
    first_dicom=$(find "$str" -maxdepth 1 -type f \( -name "*.dcm" -o -name "*.DCM" \) | head -n 1)

    if [ -z "$first_dicom" ]; then
        echo "Error: No .dcm or .DCM files found in folder for subject: $str"
        echo "Expected at least one DICOM file inside: $str"
        echo "Please check that the folder contains DICOM files with a .dcm or .DCM extension."
        exit 1
    fi
done

# If all checks pass, run recon-all for each subject using one DICOM file
for str in "$@"; do
    first_dicom=$(find "$str" -maxdepth 1 -type f \( -name "*.dcm" -o -name "*.DCM" \) | head -n 1)

    echo "Processing subject: $str"
    echo "Using DICOM file: $first_dicom"

    recon-all -i "$first_dicom" -s "$str" -all
done
