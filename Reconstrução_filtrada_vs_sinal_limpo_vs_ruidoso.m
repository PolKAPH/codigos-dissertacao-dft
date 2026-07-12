clear all
close all

% ============================================================
% Figura de reconstrucción filtrada via DFT
%
% Contexto:
% - Partimos de N muestras de una señal periódica.
% - Aplicamos la DFT para obtener el espectro discreto.
% - Filtramos las frecuencias altas (ruido).
% - Volvemos al dominio físico mediante la transformada inversa.
%
% La figura compara:
%   1) el sinal ruidoso f(x_j),
%   2) el sinal limpio f_0(x),
%   3) la reconstrucción filtrada a partir de la DFT.
% ============================================================

graphics_toolkit('gnuplot');

% Número total de muestras.
% Como N = 63 es impar, podemos reindexar simétricamente
% las frecuencias como n = -m, ..., m con m = 31.
N = 63;
m = 31;

% Umbral del filtro pasa-bajas ideal.
% Aquí se conservan solo los modos con |n| <= M.
% En tu ejemplo, M = 10 preserva todos los modos del sinal limpio
% (que están hasta 7) y elimina el ruido (que está en 15 y 20).
M = 10;

% ------------------------------------------------------------
% Puntos de muestreo
% ------------------------------------------------------------
% Índices discretos de los datos.
j   = 0 : N-1;

% Malla uniforme en [0, 2pi).
% Estos son los puntos donde se observan las muestras.
x_j = (2*pi / N) * j;

% ------------------------------------------------------------
% Señal de prueba
% ------------------------------------------------------------
% Sinal total = sinal limpio + ruido de alta frecuencia.
%
% Sinal limpio:
%   sin(x) + 1/2 sin(3x) + 1/3 sin(7x)
%
% Ruido:
%   0.3 sin(15x) + 0.2 sin(20x)
%
% Este ejemplo está diseñado para que el filtro M=10
% elimine exactamente las componentes de alta frecuencia.
f_j = sin(x_j) + (1/2)*sin(3*x_j) + (1/3)*sin(7*x_j) ...
    + 0.3*sin(15*x_j) + 0.2*sin(20*x_j);

% ------------------------------------------------------------
% DFT, reindexación e filtrado
% ------------------------------------------------------------
% fft(f_j) calcula la DFT de las muestras.
% Dividimos por N para usar la convención normalizada
% de los coeficientes de Fourier discretos.
A       = fft(f_j) / N;

% fftshift reordena el espectro para que la frecuencia cero
% quede en el centro y los modos aparezcan como
%   -m, ..., -1, 0, 1, ..., m.
A_shift = fftshift(A);

% Inicializamos el vector filtrado con ceros.
% Esto equivale a eliminar todas las frecuencias.
A_filtrado            = zeros(1, N);

% Índices que corresponden a las frecuencias conservadas:
% |n| <= M.
% Como el índice central en la versión reordenada es m+1,
% el intervalo conservado va de (m+1-M) a (m+1+M).
idx_passa             = (m+1-M) : (m+1+M);

% Conservamos solo los modos de baja frecuencia.
% Todas las demás frecuencias quedan anuladas.
A_filtrado(idx_passa) = A_shift(idx_passa);

% ------------------------------------------------------------
% Reconstrucción
% ------------------------------------------------------------
% ifftshift deshace la reindexación aplicada por fftshift,
% devolviendo el vector al orden estándar de Octave.
A_filtrado_orig = ifftshift(A_filtrado);

% ifft aplica la transformada inversa.
% Multiplicamos por N porque antes dividimos por N en la DFT.
% El resultado es una señal reconstruida a partir de los modos
% filtrados.
%
% real(...) elimina la parte imaginaria residual numéricamente
% nula, debida solo a errores de redondeo (~1e-15).
a_reconstruido  = real(ifft(A_filtrado_orig) * N);

% ------------------------------------------------------------
% Sinal limpio continuo
% ------------------------------------------------------------
% Para comparar visualmente, construimos una versión continua
% del sinal limpio f_0(x) en una malla más fina.
x_cont  = linspace(0, 2*pi, 1000);
f0_cont = sin(x_cont) + (1/2)*sin(3*x_cont) + (1/3)*sin(7*x_cont);

% ------------------------------------------------------------
% Colores
% ------------------------------------------------------------
% Azul claro: sinal ruidoso.
% Laranja: sinal limpio de referencia.
% Verde: reconstrucción filtrada.
%
% No usamos transparencia porque gnuplot no soporta alpha
% en este contexto.
cor_ruidoso  = [0.6000 0.7800 0.9200];
cor_limpo    = [0.8500 0.3250 0.0980];
cor_reconstr = [0.4660 0.6740 0.1880];

% ------------------------------------------------------------
% Figura
% ------------------------------------------------------------
figure;
set(gcf, 'Color', 'w');
hold on

% Curva 1: señal ruidosa en los puntos de muestreo.
% Se dibuja primero y con color suave para no dominar la figura.
plot(x_j, f_j, '-', ...
     'LineWidth', 1.0, ...
     'Color', cor_ruidoso);

% Curva 2: señal limpia continua.
% Se usa línea tracejada para diferenciarla de la reconstrucción.
plot(x_cont, f0_cont, '-.-', ...
     'LineWidth', 1.8, ...
     'Color', cor_limpo);

% Curva 3: reconstrucción filtrada.
% Esta es la curva principal del ejemplo.
plot(x_j, a_reconstruido, '-', ...
     'LineWidth', 1.8, ...
     'Color', cor_reconstr);

% Línea de referencia y = 0.
plot([0, 2*pi], [0, 0], 'k-', 'LineWidth', 0.5);

% ------------------------------------------------------------
% Ajustes visuales
% ------------------------------------------------------------
grid on
box on
xlim([0, 2*pi]);
ylim([-1.6, 1.6]);

% Marcas en el eje x para mostrar los puntos geométricamente
% más importantes del intervalo.
set(gca, 'XTick', [0, pi/2, pi, 3*pi/2, 2*pi]);
set(gca, 'XTickLabel', {'0', '\\pi/2', '\\pi', '3\\pi/2', '2\\pi'});

% Marcas en el eje y.
set(gca, 'YTick', [-1, 0, 1]);

% Tamaño de fuente de ejes.
set(gca, 'FontSize', 9);

% Etiqueta del eje x.
xlabel('x');

% Etiqueta del eje y vacía, porque aquí el interés es
% puramente comparativo visual.
ylabel('');

% ------------------------------------------------------------
% Leyenda
% ------------------------------------------------------------
% La leyenda identifica las tres curvas:
% - datos ruidosos,
% - sinal limpio,
% - reconstrucción filtrada.
legend({'f(x_j) (ruidoso)', ...
        'f_0(x) (limpo)', ...
        'Reconstrução filtrada'}, ...
       'Location', 'northoutside', ...
       'Orientation', 'horizontal');
legend boxoff

hold off

% ------------------------------------------------------------
% Configuración de página para exportación
% ------------------------------------------------------------
% Esto deja la figura lista para guardarse con tamaño estable.
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [0 0 16 10]);
set(gcf, 'PaperSize', [16 10]);

% ------------------------------------------------------------
% Exportación a PDF
print -dpdf 'fig_reconstrucao.pdf'
