
source('run_fault.m');
script_dir = fileparts(mfilename('fullpath'));
data_dir = fullfile(script_dir, '..', 'data');

run(fullfile(data_dir, 'busdata.m'));
run(fullfile(data_dir, 'linedata.m'));
run(fullfile(data_dir, 'gendata.m'));
addpath(fullfile(script_dir, '..', 'core'));


printf('Ybus matrix:\n');
n = size(Ybus,1);
printf('       ');
for j = 1:n
    printf('Bus%-4d ', j);
end
printf('\n');

for i = 1:n
    printf('Bus%-4d ', i);
    for j = 1:n
        printf('%8.2f+%8.2fi ', real(Ybus(i,j)), imag(Ybus(i,j)));
    end
    printf('\n');
end

[V, theta, P, Q] = run_loadflow(bus_data, Ybus, gen_data);


printf('\nBus Voltages:\n');
for i = 1:n
    printf('Bus %d: V = %.4f p.u., Angle = %.2f degrees\n', i, V(i), theta(i));
end

printf('\nBus Power Injections:\n');
for i = 1:n
    printf('Bus %d: P = %.2f MW, Q = %.2f MVAR\n', i, P(i), Q(i));
end