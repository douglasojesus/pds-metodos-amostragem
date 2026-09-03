% p(t) = somatorio (  delta(t-nTs)  ) = ... + delta(t+Ts) + delta(t) + delta(t-Ts) + delta(t-2Ts) + ...
% vamos ter um pulso (amplitude=1) em cada múltiplo de Ts: ..., t=-Ts, t=0, t=Ts, t=2Ts, ...

function p_t = trem_impulsos(t, Ts)
    p_t = zeros(size(t));

    % para cada múltiplo de Ts dentro de t
    n_min = ceil(min(t)/Ts);
    n_max = floor(max(t)/Ts);

    for n = n_min:n_max % somatório
        % onde está delta: t = nTs
        instante = n * Ts;

        % encontra esse instante no vetor de tempo
        [~, idx] = min(abs(t - instante));

        % coloca o impulso nesse ponto
        p_t(idx) = 1;
    end
end

