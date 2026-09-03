clear; clc; close all;

% parâmetros para visualização "contínua"
dt = 0.0005;
t  = -1.0:dt:1.0;

A1 = 1; f1 = 2;
A2 = 0.5; f2 = 18;

x1_t = senoide(A1, f1, t, 'cos');
x2_t = senoide(A2, f2, t, 'cos');
x_t = x1_t + x2_t;

exibe_sinal_tempo('Sinais no tempo x(t)', t, x1_t, x2_t, x_t);

f = -20:1:20;

x_f = espectro_senoides(f, [A1, A2], [f1, f2]);

fc = 4;

xf_f = filtro_aa(f, fc, x_f);

exibe_sinal_frequencia('Espectro do sinal', f, xf_f);

xf_t = espectro_para_tempo(f, xf_f, t);

exibe_sinal_tempo('Sinal x(t) após filtro AA', t, xf_t);



