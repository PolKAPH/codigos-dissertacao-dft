clear all
close all

% ============================================================
% Figura 3: Espectro filtrado |f~_{N,n}^{(M)}|
% Mostra o efeito do filtro passa-baixas ideal com M = 10:
% os coeficientes com |n| > 10 são zerrados.
% Reutilizamos todos os cálculos da Figura 2.
% ============================================================

graphics_toolkit('gnuplot');

% ------------------------------------------------------------
% Parâmetros (idênticos à Figura 2)
% ------------------------------------------------------------
N = 63;
m = 31;
M = 10;

j   = 0 : N-1;
x_j = (2*pi / N) * j;

f_j = sin(x_j) + (1/2)*sin(3*x_j) + (1/3)*sin(7*x_j) ...
    + 0.3*sin(15*x_j) + 0.2*sin(20*x_j);

% ------------------------------------------------------------
% DFT normalizada e reindexação via fftshift
% (mesmo procedimento da Figura 2)
% ------------------------------------------------------------
A       = fft(f_j) / N;
A_shift = fftshift(A);      % índices reordenados: {-31,...,31}
n_vals  = -m : m;

% ------------------------------------------------------------
% Filtragem: zeramos os coeficientes com |n| > M.
% A_shift tem 63 entradas; o índice central (n=0) está na
% posição m+1 = 32. Portanto:
%   |n| <= M  <=>  posições (m+1-M):(m+1+M) = 21:43
% Todas as outras posições recebem zero.
% ------------------------------------------------------------
A_filtrado = zeros(1, N);                    % começa tudo zerado
idx_passa  = (m+1-M) : (m+1+M);             % posições com |n| <= 10
A_filtrado(idx_passa) = A_shift(idx_passa);  % conserva só esses

% ------------------------------------------------------------
% Módulo do espectro filtrado
% ------------------------------------------------------------
amplitudes_filtrado = abs(A_filtrado);

% ------------------------------------------------------------
% Cor verde: diferente do azul da Figura 2 para distinguir
% visualmente que este é o espectro após o filtro
% ------------------------------------------------------------
cor = [0.4660 0.6740 0.1880];   % verde

% ------------------------------------------------------------
% Figura
% ------------------------------------------------------------
figure;
set(gcf, 'Color', 'w');
hold on

stem(n_vals, amplitudes_filtrado, ...
     'filled', ...
     'Color', cor, ...
     'MarkerSize', 4, ...
     'LineWidth', 1.2);

% ------------------------------------------------------------
% Linhas verticais do limiar M = 10 (mesma posição da Fig. 2)
% Agora mostram onde o filtro cortou: à direita de +10 e à
% esquerda de -10 todas as barras são zero.
% ------------------------------------------------------------
xline( M, '--r', 'LineWidth', 1.0);
xline(-M, '--r', 'LineWidth', 1.0);

% ------------------------------------------------------------
% Ajustes visuais — mesmo ylim da Figura 2 para comparação
% direta entre as duas figuras no texto da tese
% ------------------------------------------------------------
grid on
box on
xlim([-m-1, m+1]);
ylim([0, 0.58]);

% Mesmo XTick da Figura 2 para consistência visual
set(gca, 'XTick', [-20, -15, -10, -7, -3, -1, 0, 1, 3, 7, 10, 15, 20]);
set(gca, 'FontSize', 9);
set(gca, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5]);

% ------------------------------------------------------------
% Rótulos
% ------------------------------------------------------------
xlabel('n');
ylabel('Amplitude');

% ------------------------------------------------------------
% Anotação do limiar (mesma posição da Figura 2)
% ------------------------------------------------------------
text(10.5, 0.54, 'M=10', 'FontSize', 8, 'Color', 'r');

hold off

% ------------------------------------------------------------
% Tamanho da página — igual às figuras anteriores
% ------------------------------------------------------------
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf, 'PaperSize', [16 10]);

%print -dpdf 'fig_espectro_filtrado.pdf'
