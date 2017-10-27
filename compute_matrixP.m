function [ P ] = compute_matrixP( r, N, fft_order, angles )
% k = wavenumber = w/c
% r = radius of the sphere
% N = max SH order
% angles = couples of angles of hrtf (dimension: <nangles, 2>, structure: structure: [altitude angle,azimuth angle])
P = zeros(size(angles,1), (N+1)^2, fft_order);

column = 1;

for w= 1:fft_order
    for row = 1:size(angles,1)
        for n = 1:N+1
            for m = -n:n
                P(row, column, w) = (1/((1i^n) * besselj(n,get_k(w,fft_order)*r)) )*Ynm(n,m,angles(row,1),angles(row,2));
                column = mod(column+1, (N+1)^2) + 1;
            end
        end
	end
	
	if mod(w,100)==0
		display(['Computing P for w index=', num2str(w), '...'])
	end
end

display(['The computation of P is over'])

end

