%% HRTF project
clear
close all
clc

%% microphones properties
load_mic_properties;

%% hrtf properties
%database = 'CIPIC';
database = 'SYMARE';
[hrtf_azimuth, hrtf_elevation, hrtf_angles] = load_database_properties(database);

subject_number = '03';
[hrir_l, hrir_r] = load_subject_hrir(subject_number, database);

%% signal generation - white noises
filename = fullfile(pwd, 'Sounds', 'peepers.wav');
[S, Fs] = audioread(filename);
S = S';
l = size(S,2)/3;						%signal length

audio_left = zeros(1,l);
audio_right = zeros(1,l);

%% WAVE FIELD ANALYSIS and BINEURAL SYNTHESIS
%STFT parameters
nfft = 2048;
wlen = nfft/2;
hopsize = wlen/4;

win = hamming(wlen);
%win_synth = triang(nfft)./blackmanharris(nfft);
win_synth = hamming(nfft);

% form the stft matrix
rown = nmic;                        % calculate the total number of rows
coln = ceil((nfft)/2);				% calculate the total number of columns
stft = zeros(rown, coln);           % form the stft matrix

%zeropad the resulting audio vectors
audio_left = [audio_left, zeros(1,nfft)];
audio_right = [audio_right, zeros(1,nfft)];

% initialize the index
indx = 0;

%hrtf conversion
[hrtf_l, hrtf_r] = hrir2hrtf(hrir_l, hrir_r, database, nfft);
clear hrir_l;
clear hrir_r;

while indx + wlen <= l
    
    %% perform STFT
    for s_indx = 1:nmic
        sw = S(s_indx, indx+1:indx+wlen).*win'; %windowing
        X = fft(sw, nfft);                      %fft
        stft(s_indx, :) = X(1:coln); 
    end
    
    %% SHD
    shd_coeff = shd(stft, mic_angles, mic_r);
    
    %% PWD
    pwd_coeff = pwdec(shd_coeff, nmic, mic_r, hrtf_angles, database);
    
    %% HRFT conv
    if isequal(database,'SYMARE')
        X_right = sum(hrtf_r.*pwd_coeff',2)';
        X_left = sum(hrtf_l.*pwd_coeff',2)';
    else %CIPIC
        pwd_coeff = vec2matr_pwd(pwd_coeff, hrtf_azimuth, hrtf_elevation, hrtf_angles);
        
        X_right = sum(sum(hrtf_r.*pwd_coeff,1),2);
        X_left = sum(sum(hrtf_l.*pwd_coeff,1),2);
        
        X_right = reshape(X_right,[1,(nfft/2)]);
        X_left = reshape(X_right,[1,(nfft/2)]);
	end
	
    %% ISTFT
    X_right = [X_right, conj(X_right(end:-1:1))];
    X_left = [X_left, conj(X_left(end:-1:1))];
    
    x_right = real(ifft(X_right));
    x_left = real(ifft(X_left));
        
    % OLA
    audio_right((indx+1):(indx+nfft)) = audio_right((indx+1):(indx+nfft)) + (x_right.*win_synth');
    audio_left((indx+1):(indx+nfft)) = audio_left((indx+1):(indx+nfft)) + (x_left.*win_synth');
    
    % update the indexes
    indx = indx + hopsize;
	
	if mod(indx,2*wlen)==0
		display(['Analized ', num2str(indx), '/', num2str(l), ' input samples...'])
	end
end

%sound(audio_right, Fs)
FILEN