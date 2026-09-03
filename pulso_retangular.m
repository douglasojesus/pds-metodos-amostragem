function h0 = pulso_retangular(t, tau)
    h0 = (t >= 0) & (t <= tau);

    h0 = double(h0);
end
