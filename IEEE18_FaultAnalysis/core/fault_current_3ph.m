## @brief Compute three-phase fault current
## @param Vprefault Prefault voltage at the bus
## @param Z1 Positive sequence impedance
## @return Fault current in per-unit
function If = fault_current_3ph(Vprefault, Z1)
    % Three-phase fault current
    If = Vprefault / Z1;
end