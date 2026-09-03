function exibe_sinal_frequencia(nome_figura, f, xf_f)

    figure('Name', nome_figura, 'Position', [100 100 600 400]);

    stem(f, abs(xf_f), 'filled');

    title('|X(f)|');
    xlabel('Frequência (Hz)');
    ylabel('Amplitude');
    grid on;
    xlim([-20 20]);

end

