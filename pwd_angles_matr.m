function [ pwd_matr ] = pwd_angles_matr( pwd_coeff, hrtf_angles )
%pwd_angles_matr: inserts the pwd array into a matrix. Each column of a
%matrix rapresents an azimuth, a row rapresents an elevation. Azimuth from
%[-pi,pi]; elevation from [-pi/2,pi/2]. For both azimuth and elevation, the
%sampling is constant
%   pwd_coeff: array of pwd coefficents (dimension: n,1)
%   hrtf_angles: couple of angles [azi,ele] (dimension: n,2) that
%		corresponds to a pwd value.

samp = 30;	%pi sampling
ele = (-pi/2):(pi/samp):(pi/2);
azi = -pi:(pi/samp):pi;

pwd_matr = NaN(size(ele,2),size(azi,2));

for i=1:length(pwd_coeff)
	value = pwd_coeff(i);
	azi_idx = find(azi<=hrtf_angles(i,1));
	ele_idx = find(ele<=hrtf_angles(i,2));
	pwd_matr(ele_idx(end),azi_idx(end)) = value;
end

pwd_matr = fillmissing(pwd_matr,'linear','EndValues',0);

end

