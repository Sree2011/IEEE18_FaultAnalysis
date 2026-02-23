## --*texinfo*--
# NAME
# fault_current_3ph - Calculate three-phase fault current
# SYNOPSIS
# If = fault_current_3ph(Vprefault, Z1)
# DESCRIPTION
# This function calculates the three-phase fault current (If) based on the prefault voltage (Vprefault) and the positive sequence impedance (Z1) of the system.
# INPUT
# - Vprefault: The prefault voltage at the point of fault (in volts).
# - Z1: The positive sequence impedance of the system (in ohms).
# OUTPUT
# - If: The three-phase fault current (in amperes).
# @end texinfo
function If = fault_current_3ph(Vprefault, Z1)
    % Three-phase fault current
    If = Vprefault / Z1;
end