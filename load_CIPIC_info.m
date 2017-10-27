% CIPIC database infos
%for the azimuth we applied a minus sign since the CIPIC has a different
%notation with respect to the SYMARE and the EIGENMIKE
hrtf_azimuth = -[-80 -65 -55 -45:5:45 55 65 80]*(pi/180);
hrtf_elevation = (-45 + 5.625*(0:49))*(pi/180);

hrtf_angles = zeros(size(hrtf_azimuth,2)*size(hrtf_elevation,2),2);
idx_azimuth = 1;
idx_elevation = 0;
for mat_idx = 1:size(hrtf_angles,1)
   hrtf_angles(mat_idx,:)=[hrtf_azimuth(idx_azimuth),hrtf_elevation(mod(idx_elevation,length(hrtf_elevation))+1)];
   idx_elevation= idx_elevation+1;
   if mod(idx_elevation,length(hrtf_elevation))== 0
       idx_azimuth  = idx_azimuth + 1;
   end
end