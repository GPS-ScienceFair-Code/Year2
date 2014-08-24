function ecef = llh2ecef(llh)
%
%  LLH2EC: Convert lat/lon/height coordinates to Earth-Centered
%  Earth-Fixed (ECEF) coordinates (WGS84).
%
%  Input:  llh  = lat,long,height location (rad,rad,user units)
%  Output: ecef = x,y,z (user units)
%
%  OU-ECE-AEC  Oct. 1988  FvG

A = 6378137.0;            % Earth's radius (m)
E = 8.1819190842622e-02;  % Eccentricity
ESQ = E * E;

SP = sin(llh(1,1));
CP = cos(llh(1,1));
SL = sin(llh(2,1));
CL = cos(llh(2,1));
GSQ = 1.0 - (ESQ*SP*SP);
EN = A / sqrt(GSQ);
Z = (EN + llh(3,1)) * CP;
ecef(1,1) = Z * CL;
ecef(2,1) = Z * SL;
EN = EN - (ESQ * EN);
ecef(3,1) = (EN + llh(3,1)) * SP;

