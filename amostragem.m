clear; clc; close all;
graphics_toolkit("gnuplot");

% parâmetros para visualização "contínua"
dt = 0.0005;
t  = -1:dt:1;

% parametros da simulacao

f = -20:1:20; % qntd de amostras na frequencia
fc = 4; % limitação em banda
fs = 10; % frequencia de amostragem
tau = 0.09; % 0 < tau < Ts
fcrec = 4; % corte de reconstrucao
Ts = 1 / fs;







% sinal

A1 = 1; f1 = 2;
A2 = 0.5; f2 = 18;

x1_t = senoide(A1, f1, t, 'cos');
x2_t = senoide(A2, f2, t, 'cos');
x_t = x1_t + x2_t;

%exibe_sinal_tempo('Sinais no tempo x(t)', t, x1_t, x2_t, x_t);

figure('Name', 'Sinais no tempo x(t)', 'Position', [100 100 600 400]);

subplot(3, 1, 1);
plot(t, x1_t, 'LineWidth', 2);
title('Sinal x_1(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 1, 2);
plot(t, x2_t, 'LineWidth', 2);
title('Sinal x_2(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 1, 3);
plot(t, x_t, 'LineWidth', 2);
title('Sinal x(t) = x_1(t) + x_2(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

x_f = espectro_senoides(f, [A1, A2], [f1, f2]);

% exibe_sinal_frequencia('', f, x_f);

h = pulso_retangular(f, -fc, fc, 1);

%exibe_sinal_frequencia('', f, h);

xf_f = x_f .* h;

%exibe_sinal_frequencia('Espectro do sinal Xf(f)', f, xf_f);

xf_t = espectro_para_tempo(f, xf_f, t); % explicar porque na cossenoide funcionou sem importar o tamanho de amostras da freq. e no outro exemplo não)

% exibe_sinal_tempo('Sinal xf(t) (x(t) após filtro AA)', t, xf_t);

figure('Name', 'Aplicação do filtro anti-aliasing (Haa)', 'Position', [100 100 1000 700]);

subplot(3, 2, 1);
plot(t, x_t, 'LineWidth', 2);
title('Sinal x(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 3);
stem(f, abs(x_f), 'filled');
title('Sinal X(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(3, 2, 5);
stem(f, abs(h), 'filled');
title('Filtro Haa');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(3, 2, 2);
stem(f, abs(xf_f), 'filled');
title('Sinal filtrado Xf(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(3, 2, 4);
plot(t, xf_t, 'LineWidth', 2);
title('Transformação do espectro Xf(f) para tempo xf(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

% amostragem ideal

p_t_ideal = trem_impulsos(t, Ts);

%exibe_sinal_tempo('Trem de impulsos no tempo', t, p_t_ideal);

xs_t_ideal = xf_t .* p_t_ideal;

%exibe_sinal_tempo('[IDEAL SAMPLE] xs_ideal(t) = trem de impulsos * xf(t)', t, xs_t_ideal);

xs_f_ideal = amostragem_ideal(f, fs, xf_f);

%exibe_sinal_frequencia('[IDEAL SAMPLE] Xs_ideal(f) = fs * somatorio ( xf(f-kfs) )', f, xs_f_ideal);

%exibe_sinal_tempo('Xs_ideal(f) transformada em xs_ideal(t). Aproximação da integral para soma de len(f) itens.', t, espectro_para_tempo(f, xs_f_ideal, t));

figure('Name', 'Amostragem ideal', 'Position', [100 100 1000 700]);

subplot(3, 2, 1);
plot(t, xf_t, 'LineWidth', 2);
title('xf(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 3);
plot(t, p_t_ideal, 'LineWidth', 2);
title('Trem de impulsos no tempo p(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 5);
plot(t, xs_t_ideal, 'LineWidth', 2);
title('Amostragem ideal xs(t) = xf(t) * p(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 2);
stem(f, abs(xs_f_ideal), 'filled');
title('Amostragem ideal Xs(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(3, 2, 4);
plot(t, espectro_para_tempo(f, xs_f_ideal, t), 'LineWidth', 2);
title('Xs(f) transformada em xs(t). Aproximação da integral.');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

% amostragem natural



p_t_natural = trem_pulsos_retangulares(f, t, tau, Ts);

xs_t_natural = xf_t .* p_t_natural;

%exibe_sinal_tempo('xf(t) após filtro AA, Trem de pulsos retangulares espaçados por tau (p(t)), xs_natural(t) = xf(t) * p(t)', ...
%                  t, xf_t, p_t_natural, xs_t_natural);

xs_f_natural = amostragem_natural(tau, Ts, fs, f, xf_f);

%exibe_sinal_frequencia('[NATURAL SAMPLE] Xs_natural(f) = (tau / Ts) * sinc(k * fs * tau) * xf(f-k*fs)', f, xs_f_natural);

%exibe_sinal_tempo('Xs_natural(f) transformada em xs_natural(t). Aproximação da integral para soma de len(f) itens.', t, espectro_para_tempo(f, xs_f_natural, t));

figure('Name', 'Amostragem natural', 'Position', [100 100 1000 700]);

subplot(3, 2, 1);
plot(t, xf_t, 'LineWidth', 2);
title('xf(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 3);
plot(t, p_t_natural, 'LineWidth', 2);
title('Trem de pulsos no tempo p(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 5);
plot(t, xs_t_natural, 'LineWidth', 2);
title('Amostragem natural xs(t) = xf(t) * p(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 2);
stem(f, abs(xs_f_natural), 'filled');
title('Amostragem natural Xs(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(3, 2, 4);
plot(t, espectro_para_tempo(f, xs_f_natural, t), 'LineWidth', 2);
title('Xs(f) transformada em xs(t). Aproximação da integral.');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

% amostragem flat-top

h0_t = pulso_retangular(t, 0, tau, 1);
H0_f = tau * sinc(f * tau) .* exp(-1i * pi * f * tau);

dt = t(2) - t(1);
conv_full = conv(xs_t_ideal, h0_t) * dt;
xs_t_flattop = conv_full(1:length(t));

%exibe_sinal_tempo('[FLAT-TOP SAMPLE] xs_flattop(t) = xs_ideal(t) convoluído com h0(t)', t, xs_t_ideal, h0_t, xs_t_flattop);

xs_f_flattop = amostragem_flattop(tau, Ts, fs, f, xf_f, H0_f);

%exibe_sinal_frequencia('[FLAT-TOP SAMPLE] Xs_flattop(f) = ?', f, xs_f_flattop);

%exibe_sinal_tempo('Xs_flattop(f) transformada em xs_flattop(t). Aproximação da integral para soma de len(f) itens.', t, espectro_para_tempo(f, xs_f_ideal, t));

figure('Name', 'Amostragem flat-top', 'Position', [100 100 1000 700]);

subplot(3, 2, 1);
plot(t, xf_t, 'LineWidth', 2);
title('xf(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 3);
plot(t, h0_t, 'LineWidth', 2);
title('Pulso retangular no tempo h0(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 5);
plot(t, xs_t_flattop, 'LineWidth', 2);
title('Amostragem flat-top xs(t) = xf(t) convoluido com h0(t)');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

subplot(3, 2, 2);
stem(f, abs(H0_f), 'filled');
title('Pulso retangular na frequência H0(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(3, 2, 4);
stem(f, abs(xs_f_flattop), 'filled');
title('Amostragem flat-top Xs(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(3, 2, 6);
plot(t, espectro_para_tempo(f, xs_f_flattop, t), 'LineWidth', 2);
title('Xs(f) transformada em xs(t). Aproximação da integral.');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

% reconstrucao ideal

hr_f_ideal = pulso_retangular(f, -fcrec, fcrec, Ts);

xr_f_ideal = xs_f_ideal .* hr_f_ideal;

%exibe_sinal_frequencia('[RECONS. IDEAL] Xr_ideal(f) = Xs_ideal(f) * Hr_ideal(f)', f, xs_f_ideal, hr_f_ideal, xr_f_ideal);

%exibe_sinal_tempo('Xr_ideal(f) transformada em xr_ideal(t). Aproximação da integral para soma de len(f) itens.', t, espectro_para_tempo(f, xr_f_ideal, t));

figure('Name', 'Reconstrução ideal', 'Position', [100 100 1000 600]);

subplot(2, 2, 1);
stem(f, abs(xs_f_ideal), 'filled');
title('Xs_{ideal}(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(2, 2, 3);
stem(f, abs(hr_f_ideal), 'filled');
title('Hr_{ideal}(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(2, 2, 2);
stem(f, abs(xr_f_ideal), 'filled');
title('Xr_{ideal}(f) = Xs_{ideal}(f) * Hr_{ideal}(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(2, 2, 4);
plot(t, espectro_para_tempo(f, xr_f_ideal, t), 'LineWidth', 2);
title('Xr(f) transformada em xr(t). Aproximação da integral.');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

% reconstrucao natural

hr_f_natural = pulso_retangular(f, -fcrec, fcrec, Ts/tau);

xr_f_natural = xs_f_natural .* hr_f_natural;

%exibe_sinal_frequencia('[RECONS. NATURAL] Xr_natural(f) = Xs_natural(f) * Hr_natural(f)', f, xs_f_natural, hr_f_natural, xr_f_natural);

%exibe_sinal_tempo('Xr_natural(f) transformada em xr_natural(t). Aproximação da integral para soma de len(f) itens.', t, espectro_para_tempo(f, xr_f_natural, t));

figure('Name', 'Reconstrução natural', 'Position', [100 100 1000 600]);

subplot(2, 2, 1);
stem(f, abs(xs_f_natural), 'filled');
title('Xs_{natural}(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(2, 2, 3);
stem(f, abs(hr_f_natural), 'filled');
title('Hr_{natural}(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(2, 2, 2);
stem(f, abs(xr_f_natural), 'filled');
title('Xr_{natural}(f) = Xs_{natural}(f) * Hr_{natural}(f)');
ylabel('Amplitude');
xlabel('f');
grid on;
xlim([-20 20]);

subplot(2, 2, 4);
plot(t, espectro_para_tempo(f, xr_f_natural, t), 'LineWidth', 2);
title('Xr(f) transformada em xr(t). Aproximação da integral.');
ylabel('Amplitude');
xlabel('t');
grid on;
xlim([-0.5 0.5]);

% reconstrucao flattop

hr_f_flattop = pulso_retangular(f, -fcrec, fcrec, Ts);

xr_f_flattop = xs_f_flattop .* hr_f_flattop;

%exibe_sinal_frequencia('[RECONS. FLAT-TOP] Xr_flattop(f) = Xs_flattop(f) * Hr_flattop(f)', f, xs_f_flattop, hr_f_flattop, xr_f_flattop);

%exibe_sinal_tempo('Xr_flattop(f) transformada em xr_flattop(t). Aproximação da integral para soma de len(f) itens.', t, espectro_para_tempo(f, xr_f_flattop, t));

% Equalizador calculado apenas na banda do filtro (evita 1/0 e corrige a escala)
heq_f_flattop = zeros(size(f));
idx_banda = (abs(f) <= fcrec);
heq_f_flattop(idx_banda) = 1 ./ H0_f(idx_banda);

xr_f_flattop = xs_f_flattop .* hr_f_flattop;
xeq_f_flattop = xr_f_flattop .* heq_f_flattop;

figure('Name', 'Reconstrução Flat-Top: Sem Equalizador vs Com Equalizador', 'Position', [100 100 1100 850]);

% Espectro Amostrado Xs(f)
subplot(4, 2, 1);
stem(f, abs(xs_f_flattop), 'filled');
title('Xs_{flattop}(f)'); ylabel('Amplitude'); xlabel('f'); grid on; xlim([-20 20]);

% Filtro Passa-Baixas Hr(f)
subplot(4, 2, 3);
stem(f, abs(hr_f_flattop), 'filled');
title('Hr_{flattop}(f) (Filtro Pb)'); ylabel('Amplitude'); xlabel('f'); grid on; xlim([-20 20]);

% Espectro Filtrado Xr(f) = Xs(f) * Hr(f)
subplot(4, 2, 5);
stem(f, abs(xr_f_flattop), 'filled');
title('Xr(f) = Xs(f) * Hr(f)'); ylabel('Amplitude'); xlabel('f'); grid on; xlim([-20 20]);

% Sinal no Tempo xr(t) SEM EQUALIZAÇÃO (Atenuado)
subplot(4, 2, 7);
plot(t, espectro_para_tempo(f, xr_f_flattop, t), 'LineWidth', 2);
title('xr(t) SEM Equalizador'); ylabel('Amplitude'); xlabel('t'); grid on; xlim([-0.5 0.5]);

% Magnitude do Equalizador |Heq(f)| na Banda Passante
subplot(4, 2, 2);
stem(f, abs(heq_f_flattop), 'filled');
title('|Heq(f)|'); ylabel('Magnitude'); xlabel('f'); grid on; xlim([-20 20]);

% Fase do Equalizador /_Heq(f)
subplot(4, 2, 4);
stem(f, angle(heq_f_flattop) * (180/pi), 'filled');
title('Fase /_ Heq(f) (Compensação)'); ylabel('Graus (°)'); xlabel('f'); grid on; xlim([-20 20]);

% Espectro Equalizado Xeq(f) = Xr(f) * Heq(f)
subplot(4, 2, 6);
stem(f, abs(xeq_f_flattop), 'filled');
title('Xeq(f) = Xr(f) * Heq(f)'); ylabel('Amplitude'); xlabel('f'); grid on; xlim([-20 20]);

% Sinal no Tempo xeq(t) COM EQUALIZAÇÃO (Totalmente Recuperado)
subplot(4, 2, 8);
plot(t, espectro_para_tempo(f, xeq_f_flattop, t), 'LineWidth', 2);
title('xeq(t) COM Equalizador'); ylabel('Amplitude'); xlabel('t'); grid on; xlim([-0.5 0.5]);


% =========================================================================
% EXPORTAÇÃO DE TODAS AS FIGURAS PARA UM ÚNICO PDF
% =========================================================================

% 1. Encontra os "handles" de todas as figuras abertas no sistema
fig_handles = findobj('Type', 'figure');

% 2. O Octave lista da última para a primeira. Vamos inverter para
% salvar no PDF na ordem cronológica de criação (Figura 1, 2, 3...)
fig_handles = flipud(fig_handles);

nome_arquivo = 'simulacao_caso_5.pdf';

disp('Gerando PDF com todos os gráficos...');

for i = 1:length(fig_handles)
    % Traz a figura atual para o foco
    figure(fig_handles(i));

    % Força a interface a atualizar e dá um respiro de 1 segundo
    drawnow;

    % Configura a orientação para paisagem
    set(fig_handles(i), 'PaperType', 'a4');
    set(fig_handles(i), 'PaperOrientation', 'landscape');

    if i == 1
        % Na primeira figura, cria (ou sobrescreve) o arquivo PDF
        print(fig_handles(i), nome_arquivo, '-dpdf', '-bestfit');
    else
        % Nas demais figuras, anexa a página ao arquivo existente
        print(fig_handles(i), nome_arquivo, '-dpdf', '-append', '-bestfit');
    end
end

disp(['Sucesso! Todas as figuras foram salvas em: ', nome_arquivo]);







