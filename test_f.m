clear 
close all
clc

%% source properties
src_r = 120;
src_azi = 0;
src_el = 0;


%% mic properties
load_mic_properties;


test(src_azi, src_el, src_r, mic_angles(:,1), mic_angles(:,2), mic_r);
