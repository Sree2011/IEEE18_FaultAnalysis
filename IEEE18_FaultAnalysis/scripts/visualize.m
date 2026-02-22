

script_dir = fileparts(mfilename('fullpath'));
data_dir = fullfile(script_dir, '..', 'data');
run(fullfile(script_dir, 'run_fault.m'));

run(fullfile(data_dir, 'busdata.m'));
run(fullfile(data_dir, 'linedata.m'));
run(fullfile(data_dir, 'gendata.m'));
addpath(fullfile(script_dir, '..', 'core'));


% printf('Ybus matrix:\n');
% n = size(Ybus,1);
% printf('       ');
% for j = 1:n
%     printf('Bus%-4d ', j);
% end
% printf('\n');

% for i = 1:n
%     printf('Bus%-4d ', i);
%     for j = 1:n
%         printf('%8.2f+%8.2fi ', real(Ybus(i,j)), imag(Ybus(i,j)));
%     end
%     printf('\n');
% end

[V, theta, P, Q] = run_loadflow(bus_data, Ybus, gen_data);


% printf('\nBus Voltages:\n');
% for i = 1:n
%     printf('Bus %d: V = %.4f p.u., Angle = %.2f degrees\n', i, V(i), theta(i));
% end

% printf('\nBus Power Injections:\n');
% for i = 1:n
%     printf('Bus %d: P = %.2f MW, Q = %.2f MVAR\n', i, P(i), Q(i));
% end

% Ensure results folder exists
results_dir = fullfile(script_dir, '..', 'results');
if ~exist(results_dir, 'dir')
    mkdir(results_dir);
end

figure;
subplot(2,2,1); plot(1:n,V,'b-'); title('Voltage Magnitude');
subplot(2,2,2); plot(1:n,theta*180/pi,'r-'); title('Voltage Angle');
subplot(2,2,3); plot(1:n,P,'k-'); title('Active Power');
subplot(2,2,4); plot(1:n,Q,'m-'); title('Reactive Power');
print(fullfile(results_dir,'summary_before_fault.png'),'-dpng');


%------------------------------
% Symmetrical Components Section
%------------------------------

% Plot symmetrical components
% Plot symmetrical components
figure;
% V0 (Zero Sequence) phasor
subplot(3,1,1);
plot([0 real(V0)], [0 imag(V0)], 'b-', 'LineWidth', 2.5);
hold on;
plot(real(V0), imag(V0), 'bo', 'MarkerSize', 8, 'MarkerFaceColor','b');
axis equal;
grid on;
xlabel('Real');
ylabel('Imaginary');
title(sprintf('V0 (Zero Seq) - Bus %d\nMag: %.4f, Angle: %.2f°', bus_id, abs(V0), angle(V0)*180/pi));

% V1 (Positive Sequence) phasor
subplot(3,1,2);
plot([0 real(V1)], [0 imag(V1)], 'r-', 'LineWidth', 2.5);
hold on;
plot(real(V1), imag(V1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor','r');
axis equal;
grid on;
xlabel('Real');
ylabel('Imaginary');
title(sprintf('V1 (Pos Seq) - Bus %d\nMag: %.4f, Angle: %.2f°', bus_id, abs(V1), angle(V1)*180/pi));

% V2 (Negative Sequence) phasor
subplot(3,1,3);
plot([0 real(V2)], [0 imag(V2)], 'g-', 'LineWidth', 2.5);
hold on;
plot(real(V2), imag(V2), 'go', 'MarkerSize', 8, 'MarkerFaceColor','g');
axis equal;
grid on;
xlabel('Real');
ylabel('Imaginary');
title(sprintf('V2 (Neg Seq) - Bus %d\nMag: %.4f, Angle: %.2f°', bus_id, abs(V2), angle(V2)*180/pi));

saveas(gcf, fullfile(script_dir, '..', 'results', 'sym_components_phasor_before_fault.png'));
% ...existing code...

figure;
% Line chart showing magnitude comparison
plot([1 2 3], [abs(V0) abs(V1) abs(V2)], 'b-o', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
plot([1 2 3], [abs(V0) abs(V1) abs(V2)], 'ro', 'MarkerSize', 10);
set(gca,'xtick',[1 2 3],'xticklabel',{'V0 (Zero)','V1 (Pos)','V2 (Neg)'});
ylabel('Magnitude (p.u.)');
title(sprintf('Magnitude Comparison - Bus %d', bus_id));
grid on;

saveas(gcf, fullfile(script_dir, '..', 'results', 'sym_components_mag_before_fault.png'));
% ...existing code...


%----
% Fault Current Calculation
%----

% Print results
printf('\nFault Currents at Bus 5:\n');
printf('Single Line-to-Ground: %.2f ∠ %.2f° pu\n', abs(If_SLG), angle(If_SLG)*180/pi);
printf('Line-to-Line:          %.2f ∠ %.2f° pu\n', abs(If_LL), angle(If_LL)*180/pi);
printf('Double Line-to-Ground: %.2f ∠ %.2f° pu\n', abs(If_DLG), angle(If_DLG)*180/pi);
printf('Three-Phase:           %.2f ∠ %.2f° pu\n', abs(If_3ph), angle(If_3ph)*180/pi);

% Plot fault currents
figure;
% Line chart showing fault current magnitudes
plot([1 2 3 4], [abs(If_SLG) abs(
If_LL) abs(If_DLG) abs(If_3ph)], 'm-s', 'LineWidth', 2, 'MarkerSize', 8);
hold on;
plot([1 2 3 4], [abs(If_SLG) abs(If_LL) abs(If_DLG) abs(If_3ph)], 'ks', 'MarkerSize', 10);
set(gca,'xtick',[1 2 3 4],'xticklabel',{'SLG','LL','DLG','3-Ph'});
ylabel('Fault Current Magnitude (p.u.)');
title('Fault Current Magnitudes at Bus 5');
grid on;
saveas(gcf, fullfile(script_dir, '..', 'results', 'fault_currents_mag.png'));
