% Apêndice A.2 - Espectro de amplitudes (Figura 4.2)
% Amplitudes dos coeficientes de Fourier discretos obtidos via FFT

clear all
close all
graphics_toolkit('gnuplot');
N = 63;
m = 31;
j = 0:N-1;
x_j = (2*pi / N) * j;
f_j = sin(x_j) + (1/2)*sin(3*x_j) + (1/3)*sin(7*x_j) ...
    + 0.3*sin(15*x_j) + 0.2*sin(20*x_j);
A = fft(f_j) / N;
A_shift = fftshift(A);
n_vals = -m:m;
amplitudes = abs(A_shift);

cor = [0.0000 0.4470 0.7410];
figure;
set(gcf, 'Color', 'w');
hold on

stem(n_vals, amplitudes, ...
    'filled', ...
    'Color', cor, ...
    'MarkerSize', 4, ...
    'LineWidth', 1.2);
grid on
box on
xlim([-m-1, m+1]);
ylim([0, 0.58]);
set(gca, 'XTick', [-20, -15, -10, -7, -3, -1, 0, 1, 3, 7, 10, 15, 20]);
set(gca, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5]);
set(gca, 'FontSize', 9);

xlabel('n');
ylabel('Amplitude');
hold off
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf, 'PaperSize', [16 10]);
