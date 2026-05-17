# Run-FreeSurfer-in-batch-mode
This repository contains a bash script for running FreeSurfer `recon-all` in batch mode across multiple subjects.

## Requirements 

To use this script you will need: 
(i) FreeSurfer installed on your system, with a valid license. The license is available for free. If FreeSurfer is not yet installed, please see the official installation guide:  
   https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall
   
(ii) Structural MRI scans of interest in `.nii.gz` format (preferable), stored in a single subject directory on your system. If your MRI data are stored as DICOM files, please use the alternate script provided for DICOM inputs.

## Running the code 
Batch processing in FreeSurfer is well suited to HPC (High Performance Computing) systems, as processing a single subject with `recon-all` can take 4-7 hours.
If you are running the script on a local computer, make sure that:

- the computer remains plugged in;
- sleep mode is disabled;

Before running the batch script, ensure that FreeSurfer is installed and correctly set up. 

Example workflow: 
(open a terminal on your system) 
```bash
# Set up FreeSurfer (If set-up runs correctly, you should be able to see the set up environment and file locations)
source $FREESURFER_HOME/SetUpFreeSurfer.sh

# Set the FreeSurfer subjects directory
export SUBJECTS_DIR=/path/to/your/subject_directory

# Move into the subject directory
cd $SUBJECTS_DIR

# Run recon-all for each subject in a loop
# add the subject names after the script path separated by a space bar
# In this example the script will process S001 to S005 
bash /path/to/run_freesurfer_batch.sh S001 S002 S003 S004 S005
```

## Output 
The script creates a FreeSurfer recon-all output directory for each subject within the specified SUBJECTS_DIR.

## Contact Information 
For queries or bug reports, please contact: kkaur.aiims@gmail.com
