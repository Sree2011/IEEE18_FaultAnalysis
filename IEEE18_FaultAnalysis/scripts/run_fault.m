% Form ybus

script_dir = fileparts(mfilename('fullpath'));
data_dir = fullfile(script_dir, '..', 'data');
core_dir = fullfile(script_dir, '..', 'core');
% Load data
run(fullfile(data_dir, 'busdata.m'));
run(fullfile(data_dir, 'linedata.m'));
run(fullfile(data_dir, 'gendata.m'));
addpath(core_dir);
% run(fullfile(core_dir, 'symmetrical.m'));
%run(fullfile(core_dir, 'fault_analysis.m'));

% Number of buses
n = size(bus_data,1);

% Form Ybus
Ybus = ybus(line_data, n);

% Run load flow
[V, theta, P, Q] = run_loadflow(bus_data, Ybus, gen_data);

% Print results
printf('\nBus Voltages:\n');
for i = 1:n
    printf('Bus %d: V = %.4f p.u., Angle = %.2f degrees\n', i, V(i), theta(i)*180/pi);
end

printf('\nBus Power Injections:\n');
for i = 1:n
    printf('Bus %d: P = %.2f MW, Q = %.2f MVAR\n', i, P(i), Q(i));
end

% ==============================
% Symmetrical Components Section
% ==============================

% Example: compute symmetrical components for bus 1 (Va,Vb,Vc)
% Here we assume balanced system, so we generate Va,Vb,Vc from V and theta.
% In practice, you’d use actual phase voltages from measurement or simulation.

bus_id = 10;   % choose bus
Va = V(bus_id) * exp(1j*theta(bus_id));              % phase A
Vb = V(bus_id) * exp(1j*(theta(bus_id) - 2*pi/3));  % phase B (shifted -120°)
Vc = V(bus_id) * exp(1j*(theta(bus_id) + 2*pi/3));  % phase C (shifted +120°)

[V0, V1, V2] = symmetrical([Va; Vb; Vc]);

printf('\nSymmetrical Components at Bus %d:\n', bus_id);
printf('V0 (Zero Seq)     = %.4f ∠ %.2f°\n', abs(V0), angle(V0)*180/pi);
printf('V1 (Positive Seq) = %.4f ∠ %.2f°\n', abs(V1), angle(V1)*180/pi);
printf('V2 (Negative Seq) = %.4f ∠ %.2f°\n', abs(V2), angle(V2)*180/pi);


% ...existing code...
Vabc = inv_symmetrical(V0, V1, V2);
Va = Vabc(1); Vb = Vabc(2); Vc = Vabc(3);
% Assume prefault voltage at bus 5 (positive sequence voltage)
printf('\nInverse Symmetrical Components at Bus %d:\n', bus_id);
printf('Va (Zero Seq)     = %.4f ∠ %.2f°\n', abs(Va), angle(Va)*180/pi);
printf('Vb (Positive Seq) = %.4f ∠ %.2f°\n', abs(Vb), angle(Vb)*180/pi);
printf('Vc (Negative Seq) = %.4f ∠ %.2f°\n', abs(Vc), angle(Vc)*180/pi);

Vprefault = V(5) * exp(1j*theta(5));

% Example sequence impedances (replace with actual system values)
Z0 = 0.2 + 1j*0.8;
Z1 = 0.1 + 1j*0.4;
Z2 = 0.15 + 1j*0.5;

% Fault currents
If_SLG = fault_current_SLG(Vprefault, Z0, Z1, Z2);
If_LL  = fault_current_LL(Vprefault, Z1, Z2);
If_DLG = fault_current_DLG(Vprefault, Z0, Z1, Z2);
If_3ph = fault_current_3ph(Vprefault, Z1);

