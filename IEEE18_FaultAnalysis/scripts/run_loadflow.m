function [V, theta, P, Q] = run_loadflow(bus_data, Y, gen_data)
    % Newton-Raphson Load Flow Method
    % Inputs:
    %   bus_data: [bus_id, type, Pd, Qd, Gs, Bs, V_mag, V_angle]
    %   Y: admittance matrix (Ybus)
    %   gen_data: [bus_id, Pg, Qg, Qmax, Qmin, V_sp]

    max_iter = 50;
    tolerance = 1e-6;

    n_buses = size(bus_data, 1);
    V = bus_data(:, 7);        % voltage magnitudes
    theta = bus_data(:, 8);    % voltage angles

    % Identify bus types
    slack_bus = find(bus_data(:, 2) == 1);  % Type 1: Slack
    gen_buses  = find(bus_data(:, 2) == 2); % Type 2: Generator (PV)
    load_buses = find(bus_data(:, 2) == 3); % Type 3: Load (PQ)

    iteration = 0;
    converged = false;

    while iteration < max_iter && ~converged
        iteration = iteration + 1;

        % Calculate power injections
        [P_calc, Q_calc] = calc_power(V, theta, Y, n_buses);

        % Specified power (Pd, Qd positive for loads)
        P_spec = -bus_data(:, 3);  % negative sign for loads
        Q_spec = -bus_data(:, 4);

        % Assign generator injections
        for g = 1:size(gen_data,1)
            bus_id = gen_data(g,1);
            P_spec(bus_id) = gen_data(g,2);   % Pg
            Q_spec(bus_id) = gen_data(g,3);   % Qg
        end

        % Mismatch vector
        delta_P = P_spec - P_calc;
        delta_Q = Q_spec - Q_calc;
        mismatch = [delta_P([load_buses; gen_buses]); delta_Q(load_buses)];

        if max(abs(mismatch)) < tolerance
            converged = true;
            break;
        end

        % Build Jacobian
        J = build_jacobian(V, theta, Y, load_buses, gen_buses, P_calc, Q_calc);

        % Solve linear system
        dx = J \ mismatch;

        % Update state variables
        idx = 1;
        % Angles for PQ + PV buses
        theta([load_buses; gen_buses]) = theta([load_buses; gen_buses]) + dx(idx:idx+length(load_buses)+length(gen_buses)-1);
        idx = idx + length(load_buses)+length(gen_buses);

        % Voltages for PQ buses
        V(load_buses) = V(load_buses) + dx(idx:idx+length(load_buses)-1);

        % Enforce voltage setpoint at PV buses
        for g = 1:size(gen_data,1)
            bus_id = gen_data(g,1);
            V(bus_id) = gen_data(g,6);
        end
    end

    [P, Q] = calc_power(V, theta, Y, n_buses);
    fprintf('Converged in %d iterations\n', iteration);
end

function [P, Q] = calc_power(V, theta, Y, n_buses)
    P = zeros(n_buses, 1);
    Q = zeros(n_buses, 1);
    for i = 1:n_buses
        for k = 1:n_buses
            Yik = abs(Y(i,k));
            phi = angle(Y(i,k));
            P(i) = P(i) + V(i)*V(k)*Yik*cos(theta(i)-theta(k)+phi);
            Q(i) = Q(i) + V(i)*V(k)*Yik*sin(theta(i)-theta(k)+phi);
        end
    end
end

function J = build_jacobian(V, theta, Y, load_buses, gen_buses, P, Q)
    n_pq = length(load_buses);
    n_pv = length(gen_buses);
    n_eq = n_pq*2 + n_pv;
    J = zeros(n_eq, n_eq);

    busesPQPV = [load_buses; gen_buses];

    % H block: ∂P/∂θ
    for ii = 1:length(busesPQPV)
        i = busesPQPV(ii);
        for jj = 1:length(busesPQPV)
            k = busesPQPV(jj);
            if i == k
                J(ii,jj) = -Q(i) - imag(Y(i,i))*V(i)^2;
            else
                J(ii,jj) = V(i)*V(k)*abs(Y(i,k))*sin(theta(i)-theta(k)-angle(Y(i,k)));
            end
        end
    end

    % N block: ∂P/∂V
    for ii = 1:length(busesPQPV)
        i = busesPQPV(ii);
        for jj = 1:n_pq
            k = load_buses(jj);
            if i == k
                J(ii,length(busesPQPV)+jj) = P(i)/V(i) + real(Y(i,i))*V(i);
            else
                J(ii,length(busesPQPV)+jj) = V(i)*abs(Y(i,k))*cos(theta(i)-theta(k)-angle(Y(i,k)));
            end
        end
    end

    % M block: ∂Q/∂θ
    for ii = 1:n_pq
        i = load_buses(ii);
        for jj = 1:length(busesPQPV)
            k = busesPQPV(jj);
            if i == k
                J(n_pq+ii,jj) = P(i) - real(Y(i,i))*V(i)^2;
            else
                J(n_pq+ii,jj) = -V(i)*V(k)*abs(Y(i,k))*cos(theta(i)-theta(k)-angle(Y(i,k)));
            end
        end
    end

    % L block: ∂Q/∂V
    for ii = 1:n_pq
        i = load_buses(ii);
        for jj = 1:n_pq
            k = load_buses(jj);
            if i == k
                J(n_pq+ii,length(busesPQPV)+jj) = Q(i)/V(i) - imag(Y(i,i))*V(i);
            else
                J(n_pq+ii,length(busesPQPV)+jj) = V(i)*abs(Y(i,k))*sin(theta(i)-theta(k)-angle(Y(i,k)));
            end
        end
    end
end