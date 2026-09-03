% Se um pulso tem largura tau e está centrado em kTs, ele existe no intervalo: kTs - tau/2 <= t <= kTs + tau/2
% p(t) = somatorio (  rect((t-kTs)/tau)   )


function p_t = trem_pulsos_retangulares(f, t, tau, Ts)
    p_t = zeros(size(t));

    k_min = ceil(min(t) / Ts);
    k_max = floor(max(t) / Ts);

    for k = k_min:k_max
        centro = k * Ts;

        inicio = centro - tau/2;
        fim    = centro + tau/2;

        p_t(t >= inicio & t <= fim) = 1;
    end

end

