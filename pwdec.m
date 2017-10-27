function [ pwd_coefficents ] = pwdec( shd_coeff, nmic, radious, angles, database)
%PWD: returns the Plane Wave Decomposition coefficents
%   shd_coeff: matrix with spherical harmonic decomposition coefficents (dimension: <(N+1)^2,fft_order>)
%   nmic: number of microphones (dimension <1,1>)
%   radious: radious of the eigenmic
%   angles: couples of angles of hrtf (dimension: <nangles, 2>, structure: structure: [altitude angle,azimuth angle])
%
%   pwd_coefficents: matrix with pwd coefficents (dimension: <nangles, fft_order>)

[M,N] = nmic_To_MN(nmic);

fft_order = size(shd_coeff,2);

pwd_coefficents = zeros(size(angles,1), fft_order);

%Check if the stored data is available, otherwise calculate the matrix
if isequal(database,'SYMARE')
    filename = 'pwd_matrix_symare.mat';
elseif isequal(database,'CIPIC')
    filename = 'pwd_matrix_cipic.mat';
else
	filename = 'pwd_matrix.mat';	%test case
end

if exist(filename, 'file') == 2 %if exists the file
    stored_data = importdata(filename);

    if isequal(stored_data.angles, angles) & isequal(stored_data.radious, radious) & isequal(stored_data.fft_order, fft_order)
        %Same values, can use the stored data!
        P = stored_data.P;

    else
        display('PWD: Different data, we ve got some work to do')
        
        P = compute_matrixP(radious, N, fft_order, angles);
        
        save(filename, 'P'); 
        save(filename, 'angles', '-append');
        save(filename, 'radious', '-append');
        save(filename, 'fft_order', '-append');
    end
else
    display(['PWD: No such file exists (', filename, '), we ve got some work to do'])
    
    P = compute_matrixP(radious, N, fft_order, angles);
    
    save(filename, 'P');
    save(filename, 'angles', '-append');
    save(filename, 'radious', '-append');
    save(filename, 'fft_order', '-append');
end


for i = 1:fft_order
    pwd_coefficents(:,i) = P(:,:,i)*shd_coeff(:,i);
end

end

