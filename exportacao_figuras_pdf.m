% =========================================================================
% EXPORTAÇÃO DE TODAS AS FIGURAS PARA UM ÚNICO PDF
% =========================================================================

% 1. Encontra os "handles" de todas as figuras abertas no sistema
fig_handles = findobj('Type', 'figure');

% 2. O Octave lista da última para a primeira. Vamos inverter para
% salvar no PDF na ordem cronológica de criação (Figura 1, 2, 3...)
fig_handles = flipud(fig_handles);

nome_arquivo = 'simulacao_caso_1.pdf';

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







