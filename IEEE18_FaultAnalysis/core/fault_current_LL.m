## -*- texinfo -*-
## @deftypefn {Function File} {@var{If} =} fault_current_LL (@var{Vprefault}, @var{Z1}, @var{Z2})
## @brief Line-to-Line fault current calculation
##
## Computes the fault current for LL faults using sequence impedances.
##
## @param Vprefault Prefault voltage at the bus
## @param Z1 Positive sequence impedance
## @param Z2 Negative sequence impedance
## @return Fault current in per-unit
## @end deftypefn

function If = fault_current_LL(Vprefault, Z1, Z2)
    % Line-to-Line fault current
    If = sqrt(3)*Vprefault / (Z1 + Z2);
end