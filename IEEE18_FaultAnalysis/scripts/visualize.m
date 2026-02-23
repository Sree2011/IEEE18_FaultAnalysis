## -*- texinfo -*-
## @deftypefn {Function File} {} visualise (@var{results})
## @brief Visualize load flow, symmetrical components, and fault currents
##
## Generates plots for bus voltages, symmetrical components, and fault currents
## using results from run_fault.m.
##
## @param results Struct containing fields:
##   V, theta, P, Q, bus_id, V0, V1, V2, If_SLG, If_LL, If_DLG, If_3ph
## @end deftypefn
function visualize(results)

    % Ensure results folder exists
    script_dir = fileparts(mfilename('fullpath'));
    results_dir = fullfile(script_dir, '..', 'results');
    core_dir = fullfile(script_dir, '..', 'core');
    addpath(core_dir);
    if ~exist(results_dir, 'dir')
        mkdir(results_dir);
    end

    

    n = length(results.V);

    % -------------------------
    % Bus Voltage & Power Plots
    % -------------------------
    figure;
    subplot(2,2,1); plot(1:n, results.V, 'b-'); title('Voltage Magnitude');
    subplot(2,2,2); plot(1:n, results.theta*180/pi, 'r-'); title('Voltage Angle');
    subplot(2,2,3); plot(1:n, results.P, 'k-'); title('Active Power');
    subplot(2,2,4); plot(1:n, results.Q, 'm-'); title('Reactive Power');
    print(fullfile(results_dir,'summary_before_fault.png'),'-dpng');

    % ------------------------------
    % Symmetrical Components Phasors
    % ------------------------------


    figure;
    subplot(3,1,1);
    plot([0 real(results.V0)], [0 imag(results.V0)], 'b-', 'LineWidth', 2.5);
    hold on;
    plot(real(results.V0), imag(results.V0), 'bo', 'MarkerSize', 8, 'MarkerFaceColor','b');
    axis equal; grid on;
    xlabel('Real'); ylabel('Imaginary');
    title(sprintf('V0 (Zero Seq) - Bus %d\nMag: %.4f, Angle: %.2f°', ...
        results.bus_id, abs(results.V0), angle(results.V0)*180/pi));

    subplot(3,1,2);
    plot([0 real(results.V1)], [0 imag(results.V1)], 'r-', 'LineWidth', 2.5);
    hold on;
    plot(real(results.V1), imag(results.V1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor','r');
    axis equal; grid on;
    xlabel('Real'); ylabel('Imaginary');
    title(sprintf('V1 (Pos Seq) - Bus %d\nMag: %.4f, Angle: %.2f°', ...
        results.bus_id, abs(results.V1), angle(results.V1)*180/pi));

    subplot(3,1,3);
    plot([0 real(results.V2)], [0 imag(results.V2)], 'g-', 'LineWidth', 2.5);
    hold on;
    plot(real(results.V2), imag(results.V2), 'go', 'MarkerSize', 8, 'MarkerFaceColor','g');
    axis equal; grid on;
    xlabel('Real'); ylabel('Imaginary');
    title(sprintf('V2 (Neg Seq) - Bus %d\nMag: %.4f, Angle: %.2f°', ...
        results.bus_id, abs(results.V2), angle(results.V2)*180/pi));

    saveas(gcf, fullfile(results_dir, 'sym_components_phasor_before_fault.png'));

    % ------------------------------
    % Symmetrical Components Magnitude
    % ------------------------------
    figure;
    plot([1 2 3], [abs(results.V0) abs(results.V1) abs(results.V2)], 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
    hold on;
    plot([1 2 3], [abs(results.V0) abs(results.V1) abs(results.V2)], 'ro', 'MarkerSize', 10);
    set(gca,'xtick',[1 2 3],'xticklabel',{'V0 (Zero)','V1 (Pos)','V2 (Neg)'});
    ylabel('Magnitude (p.u.)');
    title(sprintf('Magnitude Comparison - Bus %d', results.bus_id));
    grid on;
    saveas(gcf, fullfile(results_dir, 'sym_components_mag_before_fault.png'));

    % ------------------------------
    % Fault Currents
    % ------------------------------
    printf('\nFault Currents at Bus %d:\n', results.bus_id);
    printf('Single Line-to-Ground: %.2f ∠ %.2f° pu\n', abs(results.If_SLG), angle(results.If_SLG)*180/pi);
    printf('Line-to-Line:          %.2f ∠ %.2f° pu\n', abs(results.If_LL), angle(results.If_LL)*180/pi);
    printf('Double Line-to-Ground: %.2f ∠ %.2f° pu\n', abs(results.If_DLG), angle(results.If_DLG)*180/pi);
    printf('Three-Phase:           %.2f ∠ %.2f° pu\n', abs(results.If_3ph), angle(results.If_3ph)*180/pi);

    figure;
    plot([1 2 3 4], [abs(results.If_SLG) abs(results.If_LL) abs(results.If_DLG) abs(results.If_3ph)], ...
         'm-s', 'LineWidth', 2, 'MarkerSize', 8);
    hold on;
    plot([1 2 3 4], [abs(results.If_SLG) abs(results.If_LL) abs(results.If_DLG) abs(results.If_3ph)], ...
         'ks', 'MarkerSize', 10);
    set(gca,'xtick',[1 2 3 4],'xticklabel',{'SLG','LL','DLG','3-Ph'});
    ylabel('Fault Current Magnitude (p.u.)');
    title(sprintf('Fault Current Magnitudes at Bus %d', results.bus_id));
    grid on;
    saveas(gcf, fullfile(results_dir, 'fault_currents_mag.png'));

end
