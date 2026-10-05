% Apêndice A.5 - Comparação dos coeficientes de Fourier (Tabela 4.2)
% Compara coeficientes exatos e discretos (FFT) da onda triangular
% Imprime no terminal os valores para n = 1, 16 e 31

clear all
close all

N = 63;
m = (N-1)/2;

j = 0:N-1;
x_j = (2*pi/N)*j;
f_j = abs(mod(x_j+pi, 2*pi) - pi);

A = fft(f_j)/N;
A_shift = fftshift(A);
n_vals = -m:m;

n_list = [1, (m+1)/2, m];

for n = n_list
  idx = find(n_vals == n);
  f_disc = real(A_shift(idx));
  if mod(n,2)==0
    f_exato = 0;
  else
    f_exato = -2/(pi*n^2);
  end
  erro = abs(f_disc - f_exato);
  printf("n=%d  exato=%.8f  discreto=%.8f  erro=%.8e\n", ...
         n, f_exato, f_disc, erro);
end
