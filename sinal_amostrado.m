% Apêndice A.1 - Sinal amostrado (Figura 4.1)
% Amostras f(x_j) do sinal em N = 63 pontos no intervalo [0, 2*pi]

clear all
close all
graphics_toolkit('gnuplot');

N = 63;
j = 0:N-1;
x_j = (2*pi/N) * j;

f_j = sin(x_j) + (1/2)*sin(3*x_j) + (1/3)*sin(7*x_j) ...
    + 0.3*sin(15*x_j) + 0.2*sin(20*x_j);

cor = [0.0000 0.4470 0.7410];
figure;
set(gcf, 'Color', 'w');
hold on

plot(x_j, f_j, ...
    'LineStyle', 'none', ...
    'Marker', 'o', ...
    'MarkerSize', 5, ...
    'MarkerEdgeColor', cor, ...
    'MarkerFaceColor', cor);

plot([0, 2*pi], [0, 0], 'k-', 'LineWidth', 0.5);

grid on
box on
xlim([0, 2*pi]);
ylim([-1.6, 1.6]);

set(gca, 'YTick', [-1, 0, 1]);
set(gca, 'XTick', [0, pi/2, pi, 3*pi/2, 2*pi]);
set(gca, 'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

xlabel('x');
ylabel('f(x_j)');

legend({'f(x_j) (N = 63 amostras, \Delta x \approx 0.10 rad)'}, ...
    'Location', 'northoutside', ...
    'Orientation', 'horizontal');
legend boxoff

hold off
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf, 'PaperSize', [16 10]);
