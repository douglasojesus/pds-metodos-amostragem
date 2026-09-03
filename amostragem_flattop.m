function xs_f = amostragem_flattop(tau, Ts, fs, f, xf_f)

    X_ideal_sum = zeros(size(f));

    k_min = ceil(min(f) / fs);
    k_max = floor(max(f) / fs);

    fprintf('\nAMOSTRAGEM FLAT-TOP: \n');

    % sum(X(f - k*fs))
    for k = k_min:k_max
        deslocamento = k * fs;

        fprintf('k = %d, deslocamento = %.1f Hz\n', k, deslocamento);

        for i = 1:length(f)
            f_deslocada = f(i) - deslocamento;

            idx = find(abs(f - f_deslocada) < 1e-6);

            if ~isempty(idx)
                X_ideal_sum(i) = X_ideal_sum(i) + xf_f(idx);
            end
        end
    end

    H0_f = tau * sinc(f * tau) .* exp(-1i * pi * f * tau);

    xs_f = fs * X_ideal_sum .* H0_f;

end
