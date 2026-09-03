% xs(f) = fs * somatorio ( xf(f-kfs) )

function xs_f = amostragem_ideal(f, fs, xf_f)
    xs_f = zeros(size(f));

    for k = -10:10

        deslocamento = k * fs;

        fprintf('k = %d, deslocamento = %.1f Hz\n', k, deslocamento);

        % Xf(f-kfs)
        for i = 1:length(f)

            f_deslocada = f(i) - deslocamento;

            % verifica se essa frequência existe no vetor f
            idx = find(f == f_deslocada);

            if ~isempty(idx)
                xs_f(i) = xs_f(i) + xf_f(idx);
            end

        end

    end

    % multiplicação por fs
    xs_f = fs * xs_f;

end

