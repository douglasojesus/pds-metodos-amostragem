function xf_filtrado = filtro_aa(f, fc, xf)

    H = abs(f) <= fc;

    xf_filtrado = xf .* H;

end
