## --*texinfo*--
## @deftypescript {Script File} {run_loadflow}
## @brief Script to run load flow analysis and print results
##
## This script loads system data, forms the admittance matrix, runs the load flow
## using the Newton-Raphson method, and prints bus voltages, angles, and power injections.
## @end deftypescript

script_dir = fileparts(mfilename('fullpath'));
data_dir = fullfile(script_dir, '..', 'data');
core_dir = fullfile(script_dir, '..', 'core');
% Load data
run(fullfile(data_dir, 'busdata.m'));
run(fullfile(data_dir, 'linedata.m'));
run(fullfile(data_dir, 'gendata.m'));
addpath(core_dir);
addpath(script_dir);
% run(fullfile(core_dir, 'symmetrical.m'));
% run(fullfile(core_dir, 'loadflow.m'));

% Number of buses
n = size(bus_data,1);

% Form Ybus
Ybus = ybus(line_data, n);

% Run load flow
[V, theta, P, Q] = load_flow(bus_data, Ybus, gen_data);

% Print results
printf('\nBus Voltages:\n');
for i = 1:n
    printf('Bus %d: V = %.4f p.u., Angle = %.2f degrees\n', i, V(i), theta(i)*180/pi);
end

printf('\nBus Power Injections:\n');
for i = 1:n
    printf('Bus %d: P = %.2f MW, Q = %.2f MVAR\n', i, P(i), Q(i));
end
