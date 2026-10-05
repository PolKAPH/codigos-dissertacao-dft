% Apêndice A.4 - Reconstrução filtrada (Figura 4.4)
% Reconstrução do sinal a partir do espectro filtrado (M = 10)

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

A_filtrado_orig = ifftshift(A_filtrado);
a_reconstruido = real(ifft(A_filtrado_orig) * N);

x_cont = linspace(0, 2*pi, 1000);

f0_cont = sin(x_cont) + (1/2)*sin(3*x_cont) ...
    + (1/3)*sin(7*x_cont);

cor_ruidoso  = [0.6000 0.7800 0.9200];
cor_limpo    = [0.8500 0.3250 0.0980];
cor_reconstr = [0.4660 0.6740 0.1880];

figure;
set(gcf, 'Color', 'w');
hold on

% Pontos de amostragem do sinal ruidoso,
% sem segmentos entre os pontos
plot(x_j, f_j, ...
    'LineStyle', 'none', ...
    'Marker', 'o', ...
    'MarkerSize', 4, ...
    'MarkerFaceColor', cor_ruidoso, ...
    'MarkerEdgeColor', cor_ruidoso);

plot(x_cont, f0_cont, ...
    '-.-', ...
    'LineWidth', 1.8, ...
    'Color', cor_limpo);

plot(x_j, a_reconstruido, ...
    '-', ...
    'LineWidth', 1.8, ...
    'Color', cor_reconstr);

plot([0, 2*pi], [0, 0], ...
    'k-', ...
    'LineWidth', 0.5);

grid on
box on

xlim([0, 2*pi]);
ylim([-1.6, 1.6]);

set(gca, 'XTick', [0, pi/2, pi, 3*pi/2, 2*pi]);
set(gca, 'XTickLabel', ...
    {'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

set(gca, 'YTick', [-1, 0, 1]);
set(gca, 'FontSize', 9);

xlabel('x');
ylabel('');

legend({'f(x_j) (ruidoso)', ...
        'f_0(x) (limpo)', ...
        'Reconstrucao filtrada'}, ...
       'Location', 'northoutside', ...
       'Orientation', 'horizontal');

legend boxoff

hold off

set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf, 'PaperSize', [16 10]);
