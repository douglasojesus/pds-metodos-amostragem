function x_t = espectro_para_tempo(f, xf, t)

    % vai aproximar uma integral para soma de len(f) itens

    df = f(2) - f(1);

    x_t = zeros(size(t));

    for k = 1:length(f)

        x_t = x_t + xf(k) * exp(1j * 2 * pi * f(k) * t) * df; % xf(t) = sum( xf(f) * e^{j*2*pi*f*t} * delta_f )

    end

end

% quando fazemos: \sum_{k} X(f_k)e^{j2\pi f_k t}
% na prática temos: x(t) = 0.5e^{-j2\pi 2t} + 0.5e^{j2\pi 2t} = cos(2\pi 2t)

