function [ hrir_l, hrir_r ] = load_subject_hrir( subject_number, database )
%Loads the HRIR of the chosen subject, if available
%   subject_number: string
%   database: SYMARE or CIPIC

if isequal(database, 'SYMARE')
    path = fullfile(pwd, 'SymareDatabaseTenSubjects', 'SymareDatabaseTenSubjects', 'HRIRs', 'Acoustic');
    if (str2double(subject_number)>=1) && (str2double(subject_number)<=10)
        filename = fullfile(path, strcat('HA', subject_number));
        storeddata = load(filename);
        hrir_l = storeddata.hL;
        hrir_r = storeddata.hR;
    else
        disp('SYMARE: The chosen subject is not available')
    end
    
%%CIPIC
else 
    path = fullfile(pwd, 'CIPIC_hrtf_database', 'standard_hrir_database');
    folder = fullfile(path, strcat('subject_', subject_number));
    if exist(folder, 'dir') == 7
        filename = fullfile(folder, 'hrir_final');
        storeddata = load(filename);
        hrir_l = storeddata.hrir_l;
        hrir_r = storeddata.hrir_r;
    else
        disp('CIPIC: The chosen subject is not available')
    end 
end

end

