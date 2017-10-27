nmic = 32;
mic_r = 4.2;
mic_azimuth = [0 32 0 328 0 45 69 45 0 315 291 315 91 90 90 89 180 212 180 148 180 225 249 225 180 135 111  135 269 270 270 271]';
mic_elev = [69 90 111 90 32 55 90 125 148 125 90 55 21 58 121 159 69 90 111 90 32 55 90 125 148 125 90 55 21 58 122 159]';
mic_azimuth = mic_azimuth*(pi/180);
mic_elev = (90 - mic_elev)*(pi/180);

%the angles are azimuth, elevation
mic_angles = [mic_azimuth, mic_elev];