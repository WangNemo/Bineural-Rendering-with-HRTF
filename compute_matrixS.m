function [S] = compute_matrixS(r, N, M, fft_order, angles)
% k = wavenumber = w/c
% r = radius of the sphere
% N = max SH order
% M = number of spatial samples
S = zeros(M, (N+1)^2, fft_order);

column = 1;

for w= 1:fft_order
    for row = 1:M
        for n = 1:N+1
            for m = -n:n
                S(row, column, w) = conj(Ynm(n,m,angles(row,1),angles(row,2)));
				
                column = mod(column+1, (N+1)^2) + 1;
            end
        end
    end
end

end