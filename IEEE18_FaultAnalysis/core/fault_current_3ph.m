function If = fault_current_3ph(Vprefault, Z1)
    % Three-phase fault current
    If = Vprefault / Z1;
end