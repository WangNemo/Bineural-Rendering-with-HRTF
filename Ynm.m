function [Ynm] = Ynm(n,m,azimuth,elevation) %%computation of the spherical harmonic  function

    Pnm = legendre(n,sin(elevation));
    
    if n~=0
        Pnm = squeeze(Pnm(abs(m)+1,:,:));
    end

    a = ((2*n+1)/(4*pi));
    b = factorial(n-m)/factorial(n+m);
    c = sqrt(a*b);

    Ynm = ((-1)^m)*c*Pnm.*exp(1i*m*azimuth);

end