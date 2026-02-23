## -*- texinfo -*-
## @deftypefn {Function File} {@var{If} =} fault_current_3ph (@var{Vprefault}, @var{Z1})
## @section Description
## Calculates the three-phase fault current (@var{If}) based on
## prefault voltage (@var{Vprefault}) and positive sequence impedance (@var{Z1}).
##
## @subsection Inputs
## @itemize
##   @item @var{Vprefault}: Prefault voltage (p.u.)
##   @item @var{Z1}: Positive sequence impedance (p.u.)
## @end itemize
##
## @subsection Output
## @itemize
##   @item @var{If}: Three-phase fault current (p.u.)
## @end itemize
##
## @example
## Vprefault = 1.0;
## Z1 = 0.1;
## If = fault_current_3ph(Vprefault, Z1);
## disp(['The three-phase fault current is: ', num2str(If), ' p.u.']);
## @end example
##
## @end deftypefn
function If = fault_current_3ph(Vprefault, Z1)
    If = Vprefault / Z1;
end
function If = fault_current_3ph(Vprefault, Z1)
    % Three-phase fault current
    If = Vprefault / Z1;
end