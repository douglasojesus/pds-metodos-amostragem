function exibe_sinal_frequencia(nome_figura, f, varargin)

    quantidade = length(varargin);

    if quantidade < 1 || quantidade > 3
        error('A função deve receber de 1 a 3 sinais.');
    end

    figure('Name', nome_figura, 'Position', [100 100 600 400]);

    for i = 1:quantidade

        subplot(quantidade, 1, i);

        stem(f, abs(varargin{i}), 'filled');

        ylabel('Amplitude');
        grid on;
        xlim([-20 20]);

    end

    xlabel('Frequência (Hz)');

end

