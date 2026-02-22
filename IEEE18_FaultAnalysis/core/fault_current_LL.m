function If = fault_current_LL(Vprefault, Z1, Z2)
    % Line-to-Line fault current
    If = sqrt(3)*Vprefault / (Z1 + Z2);
end