function [ hrtf_azimuth, hrtf_elevation, hrtf_angles ] = load_database_properties( database )
%Loads the parameters of the database chosen
%   database: SYMARE or CIPIC

if isequal(database, 'SYMARE')
    load_SYMARE_info;
else
    load_CIPIC_info;
end

end

