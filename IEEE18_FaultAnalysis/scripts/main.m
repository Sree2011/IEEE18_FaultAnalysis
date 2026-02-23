## --*texinfo*- --
## @deftypescript {Script File} {main}
## @brief Main script to run load flow, fault analysis, and visualization
##
## This script orchestrates the entire fault analysis process by:
## 1. Loading system data
## 2. Running load flow to get bus voltages and angles
## 3. Computing symmetrical components
## 4. Calculating fault currents for various fault types
## 5. Visualizing results
## @end deftypescript
% Directories
script_dir = fileparts(mfilename('fullpath'));
data_dir   = fullfile(script_dir, '..', 'data');
core_dir   = fullfile(script_dir, '..', 'core');

% Load data
run(fullfile(data_dir, 'busdata.m'));
run(fullfile(data_dir, 'linedata.m'));
run(fullfile(data_dir, 'gendata.m'));
addpath(core_dir);
Ybus = ybus(line_data, size(bus_data,1));
results = run_fault();
visualize(results);