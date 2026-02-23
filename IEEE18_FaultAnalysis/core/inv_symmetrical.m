## -*- texinfo -*-
## @deftypefn {Function File} {@var{Vabc} =} inv_symmetrical (@var{V0}, @var{V1}, @var{V2})
## @brief Inverse symmetrical component transform
##
## Converts sequence components (V0, V1, V2) back into phase voltages (Va, Vb, Vc).
##
## @param V0 Zero sequence voltage
## @param V1 Positive sequence voltage
## @param V2 Negative sequence voltage
## @return Vabc Vector of phase voltages [Va; Vb; Vc]
## @note Uses the inverse transformation matrix with operator a = exp(j*2*pi/3).
## @see symmetrical
## @end deftypefn
function Vabc = inv_symmetrical(V0, V1, V2)
    % Inverse transform: V0,V1,V2 -> Va,Vb,Vc
    a = exp(1j*2*pi/3);
    Tinv = [1 1 1;
            1 a^2 a;
            1 a a^2];
    Vabc = Tinv * [V0; V1; V2];
end