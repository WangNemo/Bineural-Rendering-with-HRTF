%load SYMARE infos
path = fullfile(pwd, 'SymareDatabaseTenSubjects', 'SymareDatabaseTenSubjects', 'HRIRs', 'Parameters');
    
%load azimuth
filename = fullfile(path, 'azim.mat');
if exist(filename, 'file') == 2 %if exists the file
    hrtf_azimuth = importdata(filename);
else
    display('HRTF info: SYMARE database info doesn t exists')
end

%load elevation
filename = fullfile(path, 'elev.mat');
if exist(filename, 'file') == 2 %if exists the file
    hrtf_elevation = importdata(filename);
else
    display('HRTF info: SYMARE database info doesn t exists')
end

hrtf_angles = [hrtf_azimuth, hrtf_elevation];