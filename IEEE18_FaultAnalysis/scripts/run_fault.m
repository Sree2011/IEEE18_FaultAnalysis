## -*- texinfo -*-
## @deftypefn {Function File} {@var{results} =} run_fault ()
## @brief Perform fault analysis and compute symmetrical components
##
## Runs load flow, computes symmetrical components, inverse transform,
## and calculates fault currents for a chosen bus.
##
## @return results Struct containing:
##   V, theta, P, Q, bus_id, Va, Vb, Vc, V0, V1, V2,
##   Vprefault, If_SLG, If_LL, If_DLG, If_3ph
## @end deftypefn
function results = run_fault()

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
    % Run load flow
    [V, theta, P, Q] = load_flow(bus_data, Ybus, gen_data);

    % ==============================
    % Symmetrical Components Section
    % ==============================
    bus_id = 10;   % choose bus

    Va = V(bus_id) * exp(1j*theta(bus_id));
    Vb = V(bus_id) * exp(1j*(theta(bus_id) - 2*pi/3));
    Vc = V(bus_id) * exp(1j*(theta(bus_id) + 2*pi/3));

    [V0, V1, V2] = symmetrical([Va; Vb; Vc]);

    % Inverse transform
    Vabc = inv_symmetrical(V0, V1, V2);
    Va = Vabc(1); Vb = Vabc(2); Vc = Vabc(3);

    % Prefault voltage at bus 5
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

    % ==============================
    % Package results into struct
    % ==============================
    results.bus_id   = bus_id;
    results.V        = V;
    results.theta    = theta;
    results.P        = P;
    results.Q        = Q;
    results.Va       = Va;
    results.Vb       = Vb;
    results.Vc       = Vc;
    results.V0       = V0;
    results.V1       = V1;
    results.V2       = V2;
    results.Vprefault= Vprefault;
    results.If_SLG   = If_SLG;
    results.If_LL    = If_LL;
    results.If_DLG   = If_DLG;
    results.If_3ph   = If_3ph;

end