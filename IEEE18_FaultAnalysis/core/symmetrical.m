## --*texinfo*--
## @deftypefn {Function File} {@var{V0, V1, V2} =} symmetrical (@var{Vabc})
## @brief Symmetrical component transform
##
## Converts phase voltages (Va, Vb, Vc) into sequence components (V0, V1, V2).
##
## @param Vabc Vector of phase voltages [Va; Vb; Vc]
## @return V0 Zero sequence voltage
## @return V1 Positive sequence voltage
## @return V2 Negative sequence voltage
## @note Uses the transformation matrix with operator a = exp(j*2*pi/3).
## @see inv_symmetrical
## @end deftypefn
function [V0, V1, V2] = symmetrical(Vabc)
    % Forward transform: Va,Vb,Vc -> V0,V1,V2
    a = exp(1j*2*pi/3);
    T = (1/3) * [1 1 1;
                 1 a a^2;
                 1 a^2 a];
    V012 = T * Vabc;
    V0 = V012(1);
    V1 = V012(2);
    V2 = V012(3);
end

