function If = fault_current_SLG(Vprefault, Z0, Z1, Z2)
    % Single Line-to-Ground fault current
    If = 3*Vprefault / (Z0 + Z1 + Z2);
end
