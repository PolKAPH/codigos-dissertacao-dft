# Códigos da dissertação

Códigos em GNU Octave que acompanham a dissertação de mestrado:

**A transformada de Fourier discreta como aproximação da transformada de Fourier periódica**

- Autor: Kelvin Adan Perlacio Hurtado
- Orientadora: Ailin Ruiz de Zarate Fabregas
- Programa: Programa de Pós-Graduação em Matemática (PPGM), Universidade Federal do Paraná (UFPR)
- Ano: 2026

Estes códigos correspondem ao Apêndice A da dissertação e reproduzem as Figuras 4.1 a 4.4 e a Tabela 4.2. Ferramentas de inteligência artificial foram utilizadas como apoio à implementação, sob supervisão e validação do autor.

## Requisitos

- GNU Octave 11.1
- gnuplot instalado (os scripts de figura usam `graphics_toolkit('gnuplot')`)
- Nenhum pacote adicional do Octave

## Como executar

1. Baixe ou clone este repositório.
2. Abra o Octave e entre na pasta do repositório (comando `cd`).
3. Digite o nome do script, sem a extensão.
   Exemplo:
    ```octave
    sinal_amostrado
    ```

Cada script é independente: define seus próprios parâmetros e não precisa dos outros. Os scripts de figura apenas exibem o gráfico na tela. Para exportar, use o menu da janela da figura ou o comando `print`.

## Conteúdo

| Script | O que faz | Dissertação |
|---|---|---|
| `sinal_amostrado.m` | Amostras f(x_j) do sinal, N = 63 | Apêndice A.1, Figura 4.1 |
| `espectro_amplitudes.m` | Amplitudes do espectro via FFT | Apêndice A.2, Figura 4.2 |
| `espectro_filtrado.m` | Espectro com filtro passa-baixa, M = 10 | Apêndice A.3, Figura 4.3 |
| `reconstrucao_filtrada.m` | Reconstrução do sinal a partir do espectro filtrado | Apêndice A.4, Figura 4.4 |
| `coeficientes_onda_triangular.m` | Compara coeficientes de Fourier exatos e discretos (onda triangular) | Apêndice A.5, Tabela 4.2 |

Obs:O último script não gera figura: ele imprime no terminal, para n = 1, 16 e 31, o coeficiente exato, o coeficiente discreto e o erro absoluto.

## Parâmetros

- N = 63 pontos, com x_j = 2πj/63, j = 0, ..., 62
- m = 31, de modo que N = 2m + 1
- M = 10 (corte do filtro passa-baixa)

## Licença

Licença MIT. Veja o arquivo `LICENSE`.

## Como citar

Perlacio Hurtado, K. A. *A transformada de Fourier discreta como aproximação da transformada de Fourier periódica*. Dissertação (Mestrado em Matemática), Universidade Federal do Paraná, 2026.
