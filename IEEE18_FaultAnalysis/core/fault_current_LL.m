/**
** @file fault_current_LL.m
** @brief Compute line-to-line fault current
**
** @param Vprefault Prefault voltage at the bus
** @param Z1 Positive sequence impedance
** @param Z2 Negative sequence impedance
** @return Fault current in per-unit
*/

function If = fault_current_LL(Vprefault, Z1, Z2)
    % Line-to-Line fault current
    If = sqrt(3)*Vprefault / (Z1 + Z2);
end