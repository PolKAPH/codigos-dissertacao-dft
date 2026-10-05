% Apêndice A.3 - Espectro filtrado (Figura 4.3)
% Espectro com filtro passa-baixa de corte M = 10

clear all
close all
graphics_toolkit('gnuplot');
N = 63;
m = 31;
M = 10;
j = 0:N-1;
x_j = (2*pi / N) * j;
f_j = sin(x_j) + (1/2)*sin(3*x_j) + (1/3)*sin(7*x_j) ...
    + 0.3*sin(15*x_j) + 0.2*sin(20*x_j);
A = fft(f_j) / N;
A_shift = fftshift(A);
n_vals = -m:m;
A_filtrado = zeros(1, N);
idx_passa = (m+1-M):(m+1+M);
A_filtrado(idx_passa) = A_shift(idx_passa);
amplitudes_filtrado = abs(A_filtrado);

cor = [0.4660 0.6740 0.1880];
figure;
set(gcf, 'Color', 'w');
hold on

stem(n_vals, amplitudes_filtrado, ...
    'filled', ...
    'Color', cor, ...
    'MarkerSize', 4, ...
    'LineWidth', 1.2);

xline(M, '--r', 'LineWidth', 1.0);
xline(-M, '--r', 'LineWidth', 1.0);

grid on
box on
xlim([-m-1, m+1]);
ylim([0, 0.58]);

set(gca, 'XTick', [-20, -15, -10, -7, -3, -1, 0, 1, 3, 7, 10, 15, 20]);
set(gca, 'FontSize', 9);
set(gca, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5]);

xlabel('n');
ylabel('Amplitude');
text(10.5, 0.54, 'M=10', 'FontSize', 8, 'Color', 'r');

hold off
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf, 'PaperSize', [16 10]);
