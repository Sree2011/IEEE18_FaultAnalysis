function Y = ybus(line_data, n)
  Y = zeros(n,n);   % Step 1: initialize
  
  for k = 1:size(line_data,1)
    i = line_data(k,1);
    j = line_data(k,2);
    R = line_data(k,3);
    X = line_data(k,4);
    B = line_data(k,5);
    
    Z = R + 1i*X;
    Yij = 1/Z;
    Ysh = 1i*B/2;
    
    % Step 3: update diagonal
    Y(i,i) += Yij + Ysh;
    Y(j,j) += Yij + Ysh;
    
    % Step 4: update off-diagonal
    Y(i,j) -= Yij;
    Y(j,i) -= Yij;
  end
end