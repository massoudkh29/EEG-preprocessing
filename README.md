# EEG-preprocessing
Automatic EEG data preprocessing using EEGLAB

Here are the steps taken:
Channel rejection: using Reject data using Clean Rawdata and ASR. Channels that were deemed problematic were rejected.
Bandpass filtering: A finite impulse response (FIR) filter was applied to the EEG data to pass frequencies between 0.5 Hz and 40 Hz. This filtering step helps to focus on the relevant frequency range for EEG analysis.
Trial extraction: Data epochs or trials were extracted from the preprocessed EEG data. The epoch duration was set from -0.5 seconds to 2.5 seconds relative to the trial onset. This step helps to isolate and analyze specific time periods related to each trial.
Baseline removal: To establish a baseline for each trial, the mean value of the EEG signal in the time period from -0.5 seconds to 0 seconds was computed. This mean value was then subtracted from the rest of the trial, effectively removing the baseline contribution from the data.
Independent Components Analysis (ICA): The remaining preprocessed channels underwent independent components analysis (ICA) using  ICLabel.
