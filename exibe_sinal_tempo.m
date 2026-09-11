function exibe_sinal_tempo(nome_figura, t, varargin)

    quantidade = length(varargin);

    if quantidade < 1 || quantidade > 3
        error('A função deve receber de 1 a 3 sinais.');
    end

    figure('Name', nome_figura, 'Position', [100 100 600 400]);

    for i = 1:quantidade

        subplot(quantidade, 1, i);

        plot(t, varargin{i});

        %ymax = max(varargin{i});
        %ymin = min(varargin{i});
        %amplitude = ymax - ymin;
        %folga = 0.05 * amplitude;
        %ylim([ymin-folga, ymax+folga]);

        ylabel('Amplitude');
        grid on;
        xlim([-0.5 0.5]);

    end

end


