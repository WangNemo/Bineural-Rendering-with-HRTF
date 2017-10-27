function [ ] = test( src_azimuth, src_elevation, src_r, mic_azimuth, mic_elevation, mic_r )
%Function used to test the SHD and PWD functions. Generates a ideal source
%in the space (with its coordinates src_azimuth, src_altitude and src_r)
%and applies the SHD and the PWD. In the final plot should see a peak in
%the direction of the source (src_azimuth, src_altitude)
%   src_azimuth: source azimuth
%   src_elevation: source elevation
%   src_r: source radious with respect to the origin
%   mic_azimuth: vector azimuth of the microphones (dimension: <nmic, 1>)
%   mic_elevation: vector elevation of the microphones (dimension: <nmic, 1>)
%   mic_r: radious of the microphones

c = 340;
w = (0:0.4:pi);
w = [pi/10];
nmic = size(mic_azimuth,1);

src_pos = sph2cart(src_azimuth,src_elevation,src_r);

for mic=1:nmic
    %retrieve cartesian coordinates
    mic_pos = sph2cart(mic_azimuth(mic),mic_elevation(mic),mic_r);
    
    %find its transfer function
    tf(mic,:) = (1/(4*pi*norm(src_pos-mic_pos)))*exp(-1i*(w/c)*norm(src_pos-mic_pos));
end

%compute the shd coefficent
shd_coeff = shd(tf, [mic_azimuth, mic_elevation], mic_r);

%simulate hrtf angles
%database = 'CIPIC';
database = 'SYMARE';
[hrtf_azimuth, hrtf_elevation, hrtf_angles] = load_database_properties(database);

%compute pwd
pwd_coeff = pwdec(shd_coeff, nmic, mic_r, hrtf_angles, database);
%pwd_coeff = mean(vec2matr_pwd(pwd_coeff, hrtf_azimuth, hrtf_elevation, hrtf_angles),3);

matrice_bella = pwd_angles_matr(pwd_coeff,hrtf_angles);

figure
%imagesc(hrtf_azimuth, hrtf_elevation, abs(pwd_coeff)), axis equal, axis tight, axis xy
imagesc([-pi,pi],[-pi/2,pi/2],abs(matrice_bella)), axis equal, axis tight, axis xy
title('Pwd'), xlabel('azimuth [rad]'), ylabel('elevation [rad]')

end

