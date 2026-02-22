%{
## @brief Compute single line-to-ground fault current
##
## @param Vprefault Prefault voltage at the bus
## @param Z0 Zero sequence impedance
## @param Z1 Positive sequence impedance
## @param Z2 Negative sequence impedance
## @return Fault current in per-unit
%}
function If = fault_current_SLG(Vprefault, Z0, Z1, Z2)
    % Single Line-to-Ground fault current
    If = 3*Vprefault / (Z0 + Z1 + Z2);
end
