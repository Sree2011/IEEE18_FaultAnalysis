% Form ybus

script_dir = fileparts(mfilename('fullpath'));
data_dir = fullfile(script_dir, '..', 'data');

run(fullfile(data_dir, 'busdata.m'));
run(fullfile(data_dir, 'linedata.m'));
addpath(fullfile(script_dir, '..', 'core'));

% Number of buses
n = size(bus_data,1);

% Form Ybus
Ybus = ybus(line_data, n);
