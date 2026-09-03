clear; clc; close all;

% parâmetros para visualização "contínua"
dt = 0.0005;
t  = -1.0:dt:1.0;

A1 = 1; f1 = 2;
A2 = 0.5; f2 = 18;

x1_t = senoide(A1, f1, t, 'cos');
x2_t = senoide(A2, f2, t, 'cos');
x_t = x1_t + x2_t;

%exibe_sinal_tempo('Sinais no tempo x(t)', t, x1_t, x2_t, x_t);

f = -20:1:20;

x_f = espectro_senoides(f, [A1, A2], [f1, f2]);

fc = 4;

xf_f = filtro_aa(f, fc, x_f);

%exibe_sinal_frequencia('Espectro do sinal', f, xf_f);

xf_t = espectro_para_tempo(f, xf_f, t);

%exibe_sinal_tempo('Sinal x(t) após filtro AA', t, xf_t);

fs = 5;
Ts = 1 / fs;

% amostragem ideal

p_t_ideal = trem_impulsos(t, Ts);

%exibe_sinal_tempo('Trem de impulsos', t, p_t_ideal);

xs_t_ideal = xf_t .* p_t_ideal;

%exibe_sinal_tempo('Impulsos * x(t)', t, xs_t_ideal);

xs_f_ideal = amostragem_ideal(f, fs, xf_f);

%exibe_sinal_frequencia('Amostragem ideal', f, xs_f_ideal);

%exibe_sinal_tempo('', t, espectro_para_tempo(f, xs_f_ideal, t));

% amostragem natural

tau = 0.1; % 0 < tau < Ts

p_t_natural = trem_pulsos_retangulares(f, t, tau, Ts);

%exibe_sinal_tempo('Trem de pulsos retangulares espaçados por tau', t, p_t_natural);

xs_t_natural = xf_t .* p_t_natural;

%exibe_sinal_tempo('Trem de pulsos * x(t)', t, xs_t_natural);

xs_f_natural = amostragem_natural(tau, Ts, fs, f, xf_f);

%exibe_sinal_frequencia('Amostragem natural', f, xs_f_natural);

% amostragem flat-top

h0_t = pulso_retangular(t, tau);

dt = t(2) - t(1);
conv_full = conv(xs_t_ideal, h0_t) * dt;
xs_t_flattop = conv_full(1:length(t));

%exibe_sinal_tempo('Xs_ideal(t) convoluído com h0_t', t, xs_t_flattop);

xs_f_flattop = amostragem_flattop(tau, Ts, fs, f, xf_f);

%exibe_sinal_frequencia('Amostragem Flat-top', f, xs_f_flattop);

%exibe_sinal_tempo('', t, espectro_para_tempo(f, xs_f_flattop, t));

% Reconstrução do tempo a partir da frequência (limitada)
xs_t_reconstruido = real(espectro_para_tempo(f, xs_f_ideal, t));

% reconstrucao










