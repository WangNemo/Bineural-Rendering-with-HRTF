function [ coefficents ] = shd( fft, angles, radious)
%SHD: retrieves the Sperical Harmonic Decomposition coefficents
%   fft: spectrum of a frame for each microphone (dimension: <nmic,fft_length>)
%   angles: matrix with microphone angles (dimension: <nmic,2>, structure: [altitude angle,azimuth angle])
%   radious: eigenmic radious
%
%   coefficents: matrix of spherical harmonic decomposition coefficents (dimension: <M=(N+1)^2,fft_length>)

[M,N] = nmic_To_MN(size(fft,1));

coefficents = zeros((N+1)^2, size(fft,2));

fft_order = size(fft,2);

%Check if the stored data is available, otherwise calculate the inverse
filename = 'shd_matrix.mat';
if exist(filename, 'file') == 2 %if exists the file
    stored_data = importdata(filename);

    if isequal(stored_data.angles, angles) & isequal(stored_data.radious, radious) & isequal(stored_data.fft_order, fft_order)
        %Same values, can use the stored data!
        S = stored_data.S;

    else
        display('SHD: Different data, we ve got some work to do')
        
        S = compute_matrixS(radious, N, M, fft_order, angles);
        
        save(filename, 'S'); 
        save(filename, 'angles', '-append');
        save(filename, 'radious', '-append');
        save(filename, 'fft_order', '-append');
    end
else
    display(['SHD: No such file exists(', filename, '), we ve got some work to do'])
    
    S = compute_matrixS(radious, N, M, fft_order, angles);
    
    save(filename, 'S');
    save(filename, 'angles', '-append');
    save(filename, 'radious', '-append');
    save(filename, 'fft_order', '-append');
end

mu = 0.001;
for i=1:fft_order
	inverse(:,:,i) = ((S(:,:,i)')*S(:,:,i)+mu*eye(size(S,2)))\S(:,:,i)';
end

for i = 1:fft_order
   %coefficents(:,i) = fft(:,i)'*S(:,:,i);
   coefficents(:,i) = inverse(:,:,i)*fft(:,i);
end

end

