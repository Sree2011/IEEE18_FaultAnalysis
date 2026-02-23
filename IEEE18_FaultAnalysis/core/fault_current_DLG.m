

function If = fault_current_DLG(Vprefault, Z0, Z1, Z2)
    % Double Line-to-Ground fault current
    Zeq = (Z0*(Z1+Z2)) / (Z0 + Z1 + Z2);  % equivalent impedance
    If = 3*Vprefault / (Zeq);
end