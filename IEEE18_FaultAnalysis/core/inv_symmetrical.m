/**
** @brief Inverse symmetrical component transformation
**
** @param V0 Zero sequence voltage
** @param V1 Positive sequence voltage
** @param V2 Negative sequence voltage
** @return Phase voltages Va,Vb,Vc
*/
function Vabc = inv_symmetrical(V0, V1, V2)
    % Inverse transform: V0,V1,V2 -> Va,Vb,Vc
    a = exp(1j*2*pi/3);
    Tinv = [1 1 1;
            1 a^2 a;
            1 a a^2];
    Vabc = Tinv * [V0; V1; V2];
end