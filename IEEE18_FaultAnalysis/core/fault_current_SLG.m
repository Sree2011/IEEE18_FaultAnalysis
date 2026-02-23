## -*- texinfo -*-
## @deftypefn {Function File} {@var{If} =} fault_current_SLG (@var{Vprefault}, @var{Z0}, @var{Z1}, @var{Z2})
## @brief Single line-to-ground fault current calculation
##
## Computes the fault current for SLG faults using sequence impedances.
##
## @param Vprefault Prefault voltage at the bus
## @param Z0 Zero sequence impedance
## @param Z1 Positive sequence impedance
## @param Z2 Negative sequence impedance
## @return Fault current in per-unit
## @end deftypefn
function If = fault_current_SLG(Vprefault, Z0, Z1, Z2)
    % Single Line-to-Ground fault current
    If = 3*Vprefault / (Z0 + Z1 + Z2);
end
