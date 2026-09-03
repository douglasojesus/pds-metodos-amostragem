function x = senoide(A, f, t, tipo)

    if strcmp(tipo, 'cos')
        x = A * cos(2 * pi * f * t);

    elseif strcmp(tipo, 'sen')
        x = A * sin(2 * pi * f * t);

    else
        error('Tipo deve ser "cos" ou "sen".');
    end

end

