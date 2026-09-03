function xf = espectro_senoides(f, amplitudes, frequencias)

    xf = zeros(size(f));

    % para cada senoide
    for k = 1:length(frequencias)

        A = amplitudes(k);
        f0 = frequencias(k);

        xf(f == f0) = xf(f == f0) + A/2;
        xf(f == -f0) = xf(f == -f0) + A/2;

    end

end
