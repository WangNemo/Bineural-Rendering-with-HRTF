function [ M, N ] = nmic_To_MN( nmic )
%From the number of microphones, returns the number of modes. Mainly used
%for notations
%   nmic: number of microphones (scalar)
%
%   M: number of microphones (scalar)
%   N: number of modes (scalar)

M = nmic;
N = floor(sqrt(M)-1);   %inverse of M = (N+1)^2

end

