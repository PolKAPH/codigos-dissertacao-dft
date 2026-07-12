clear all
close all

% ============================================================
% Figura 1: Sinal ruidoso f(x_j) — união de segmentos ponto a ponto
% Inspirado na figura do livro Briggs & Henson (1995), que mostra
% dados discretos de turbidez subglaciar unidos por segmentos retos.
% ============================================================

graphics_toolkit('gnuplot');

% ------------------------------------------------------------
% Parâmetros
% ------------------------------------------------------------
N = 63;     % Número de pontos de amostragem: N = 2m+1, m = 31

% ------------------------------------------------------------
% Pontos de amostragem igualmente espaçados em [0, 2*pi)
% x_j = (2*pi/N)*j, j = 0,...,N-1
% Distância entre pontos consecutivos: 2*pi/63 ≈ 0.0997 radianos
% ------------------------------------------------------------
j   = 0 : N-1;
x_j = (2*pi / N) * j;

% ------------------------------------------------------------
% Sinal ruidoso f(x_j):
% f(x) = sin(x) + (1/2)sin(3x) + (1/3)sin(7x)   <- f_0: sinal limpo
%        + 0.3*sin(15x) + 0.2*sin(20x)           <- η: ruído
% Avaliamos nos N = 63 pontos discretos.
% ------------------------------------------------------------
f_j = sin(x_j) + (1/2)*sin(3*x_j) + (1/3)*sin(7*x_j) ...
    + 0.3*sin(15*x_j) + 0.2*sin(20*x_j);

% ------------------------------------------------------------
% Cor consistente com as figuras anteriores da tese
% ------------------------------------------------------------
cor = [0.0000 0.4470 0.7410];   % azul

% ------------------------------------------------------------
% Figura
% ------------------------------------------------------------
figure;
set(gcf, 'Color', 'w');
hold on

% ------------------------------------------------------------
% Único plot: os N pontos unidos por segmentos retos.
% Não há curva contínua — apenas os dados discretos.
% Isso imita exatamente o estilo da figura de Briggs & Henson.
% ------------------------------------------------------------
plot(x_j, f_j, '-', ...
     'LineWidth', 1.6, ...
     'Color', cor);

% ------------------------------------------------------------
% Linha horizontal y = 0 para referência
% ------------------------------------------------------------
plot([0, 2*pi], [0, 0], 'k-', 'LineWidth', 0.5);

% ------------------------------------------------------------
% Ajustes visuais
% ------------------------------------------------------------
grid on
box on
xlim([0, 2*pi]);
set(gca, 'YTick', [-1, 0, 1]);
ylim([-1.6, 1.6]);

% ------------------------------------------------------------
% Marcas no eixo x: múltiplos de pi/2
% ------------------------------------------------------------
set(gca, 'XTick', [0, pi/2, pi, 3*pi/2, 2*pi]);
set(gca, 'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

% ------------------------------------------------------------
% Rótulos
% ------------------------------------------------------------
xlabel('x');
ylabel('f(x_j)');

% ------------------------------------------------------------
% Legenda sem moldura
% A notação f(x_j) deixa claro que são dados discretos,
% não uma função contínua.
% ------------------------------------------------------------
legend({'f(x_j) \ (N = 63 amostras)'}, ...
       'Location', 'northoutside', ...
       'Orientation', 'horizontal');
legend boxoff

hold off

% ------------------------------------------------------------
% Tamanho da página para PDF
% ------------------------------------------------------------
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf, 'PaperSize', [16 10]);

% ------------------------------------------------------------
% Exportação
% ------------------------------------------------------------
%print -dpdf 'fig_sinal_ruidoso.pdf'
