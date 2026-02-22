/**
** @file symmetrical.m
** @brief Symmetrical component transformation
**
** @param Vabc Phase voltages Va,Vb,Vc
** @return V0 Zero sequence voltage, V1 Positive sequence voltage, V2 Negative sequence voltage
*/
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

