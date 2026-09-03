function xs_f = amostragem_natural(tau, Ts, fs, f, xf_f)
    xs_f = zeros(size(f));

    k_min = ceil(min(f) / fs);
    k_max = floor(max(f) / fs);

    fprintf('\nAMOSTRAGEM NATURAL: \n\n');

    for k = k_min:k_max

        Pk = (tau / Ts) * sinc(k * fs * tau);

        deslocamento = k * fs;

        fprintf('k = %d, deslocamento = %.1f Hz, P[k] = %.4f\n', k, deslocamento, Pk);

        for i = 1:length(f)

            f_deslocada = f(i) - deslocamento;

            idx = find(f == f_deslocada);

            if ~isempty(idx)
                xs_f(i) = xs_f(i) + Pk * xf_f(idx);
            end

        end

    end

end
