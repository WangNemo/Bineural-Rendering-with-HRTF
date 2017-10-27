function [ hrtf_l, hrtf_r] = hrir2hrtf( hrir_l, hrir_r, database, fft_order)
%Fourier Transform of the hrir coefficients

if isequal(database,'SYMARE')
    hrtf_l = fft(hrir_l,fft_order,1);
    hrtf_r = fft(hrir_r,fft_order,1);
    
    hrtf_l = hrtf_l(1:(fft_order/2),:);
    hrtf_r = hrtf_l(1:(fft_order/2),:);
else
    hrtf_l = fft(hrir_l,fft_order,3);
    hrtf_r = fft(hrir_r,fft_order,3);
    
    hrtf_l = hrtf_l(:,:,1:(fft_order/2));
    hrtf_r = hrtf_l(:,:,1:(fft_order/2));
end

end

