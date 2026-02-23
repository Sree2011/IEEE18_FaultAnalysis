
## @file fault_current_DLG.m
## @brief Compute double line-to-ground fault current
##
## @param Vprefault Prefault voltage at the bus
## @param Z0 Zero sequence impedance
## @param Z1 Positive sequence impedance
## @param Z2 Negative sequence impedance
## @return Fault current in per-unit
function If = fault_current_DLG(Vprefault, Z0, Z1, Z2)
    % Double Line-to-Ground fault current
    Zeq = (Z0*(Z1+Z2)) / (Z0 + Z1 + Z2);  % equivalent impedance
    If = 3*Vprefault / (Zeq);
end