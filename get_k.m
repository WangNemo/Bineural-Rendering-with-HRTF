function [ k ] = get_k( w, fft_order )
%Computation of k0 wave number

c = 340;    %sound speed
k = w*2*pi/(fft_order*c);

end

