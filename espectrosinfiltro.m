clear all
close all

% ============================================================
% Figura 2: Espectro de amplitudes via DFT
%
% Esta figura muestra el espectro discreto del signo f(x)
% a partir de sus N muestras igualmente espaciadas.
% Usamos la FFT para calcular los coeficientes espectrales
% y luego graficamos sus módulos.
% ============================================================

graphics_toolkit('gnuplot');

% ------------------------------------------------------------
% Parámetros principales
% ------------------------------------------------------------
% N = número de puntos de muestreo.
% Como N es impar, podemos reindexar simétricamente las
% frecuencias desde -m hasta m, donde N = 2m + 1.
N = 63;
m = 31;

% ------------------------------------------------------------
% Pontos de amostragem
% ------------------------------------------------------------
% Definimos os índices discretos j = 0,1,...,N-1.
j   = 0 : N-1;

% Os pontos x_j são igualmente espaçados no intervalo [0, 2pi).
% Esse é o conjunto de amostras da função periódica.
x_j = (2*pi / N) * j;

% ------------------------------------------------------------
% Sinal de teste
% ------------------------------------------------------------
% A função é uma soma de senos com frequências conhecidas.
% A parte de baixa frequência corresponde ao sinal limpo:
%    sin(x) + 1/2 sin(3x) + 1/3 sin(7x)
%
% A parte de alta frequência corresponde ao ruído:
%    0.3 sin(15x) + 0.2 sin(20x)
%
% Assim, sabemos de antemão onde devem aparecer os picos
% no espectro.
f_j = sin(x_j) + (1/2)*sin(3*x_j) + (1/3)*sin(7*x_j) ...
    + 0.3*sin(15*x_j) + 0.2*sin(20*x_j);

% ------------------------------------------------------------
% Transformada de Fourier Discreta (DFT)
% ------------------------------------------------------------
% Aplicamos a FFT ao vetor de dados.
% No Octave, fft(f_j) devolve os coeficientes da transformada
% não normalizada. Como na tese adotamos a convenção com fator
% 1/N na DFT, dividimos o resultado por N.
A = fft(f_j) / N;

% ------------------------------------------------------------
% Reindexação das frequências
% ------------------------------------------------------------
% fftshift reorganiza os coeficientes para que o índice zero
% fique no centro do vetor.
% Assim, as frequências passam a ser lidas em ordem simétrica:
%   -m, ..., -1, 0, 1, ..., m
A_shift = fftshift(A);

% Vetor de índices frequenciais simétricos.
n_vals = -m : m;

% ------------------------------------------------------------
% Amplitudes espectrais
% ------------------------------------------------------------
% O gráfico exibe o módulo de cada coeficiente da DFT.
% Portanto, amplitudes = |A_n|.
% Isso mostra a intensidade de cada modo frequencial.
amplitudes = abs(A_shift);

% ------------------------------------------------------------
% Cor do gráfico
% ------------------------------------------------------------
% Vetor RGB correspondente a azul.
cor = [0.0000 0.4470 0.7410];

% ------------------------------------------------------------
% Criação da figura
% ------------------------------------------------------------
figure;
set(gcf, 'Color', 'w');   % fundo branco
hold on

% ------------------------------------------------------------
% Gráfico tipo stem
% ------------------------------------------------------------
% stem desenha hastes verticais para cada coeficiente,
% o que é ideal para representar um espectro discreto.
%
% n_vals    -> eixo horizontal (frequências)
% amplitudes-> eixo vertical (módulo dos coeficientes)
stem(n_vals, amplitudes, ...
     'filled', ...
     'Color', cor, ...
     'MarkerSize', 4, ...
     'LineWidth', 1.2);

% ------------------------------------------------------------
% Ajustes visuais
% ------------------------------------------------------------
grid on
box on

% Limites do eixo x.
% Usamos um intervalo ligeiramente maior que [-m,m]
% para dar margem visual.
xlim([-m-1, m+1]);

% Limite vertical para destacar os picos principais.
ylim([0, 0.58]);

% ------------------------------------------------------------
% Ticks do eixo x
% ------------------------------------------------------------
% Escolhemos apenas os valores mais importantes para não
% congestionar a figura. Esses pontos correspondem aos modos
% que aparecem no exemplo: 1, 3, 7, 15, 20 e seus simétricos.
set(gca, 'XTick', [-20, -15, -10, -7, -3, -1, 0, 1, 3, 7, 10, 15, 20]);

% Fonte dos eixos menor para manter a figura limpa.
set(gca, 'FontSize', 9);

% Ticks do eixo y.
set(gca, 'YTick', [0, 0.1, 0.2, 0.3, 0.4, 0.5]);

% ------------------------------------------------------------
% Rótulos dos eixos
% ------------------------------------------------------------
% n representa o índice/frequência espectral.
xlabel('n');

% Como estamos graficando o módulo dos coeficientes,
% o eixo vertical recebe o rótulo "Amplitude".
ylabel('Amplitude');



hold off

% ------------------------------------------------------------
% Configuração de página para exportação em PDF
% ------------------------------------------------------------
% Define as dimensões físicas da figura ao exportar.
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf, 'PaperSize', [16 10]);

% ------------------------------------------------------------
% Exportação
% ------------------------------------------------------------
% A linha está comentada porque talvez você queira apenas
% visualizar a figura. Se quiser gerar o PDF, descomente.
%print -dpdf 'fig_espectro.pdf'
