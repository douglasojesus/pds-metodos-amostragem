function h = pulso_retangular(eixo, inicio, fim, amplitude)
    h = amplitude * double((eixo >= inicio) & (eixo <= fim));
end
