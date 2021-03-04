% Allison Hazebrouck

% Function which converts XYZ tristimulus values into Dolby ICtCp based on
% the white paper, and using the SMPTE 2084 PQ curve for the non-linearity

% Inputs: 3xN matrix of the absolute radiometric XYZ values
%   to be converted
%   3x1 matrix of absolute XYZ values of the white point 
% Output: 3xN matrix of ICtCp 

function ICtCp = XYZ2ICtCp(XYZ, XYZw)

%constant matrices and variables
HPE_XYZ2LMS_D65 = [0.4002, 0.7076, -0.0808; -0.2263, 1.1653, 0.0457; 0, 0, 0.9182];
cross_talk = [0.92, 0.04, 0.04; 0.04, 0.92, 0.04; 0.04, 0.04, 0.92];
m = 78.844; n = 0.159;
c1 = 0.836; c2 = 18.852; c3 = 18.688;
LMS_nonlin2ICtCp = [0.5, 0.5, 0.0; 1.6137, -3.3234, 1.7097; 4.3781, -4.2455, -0.1325];

%normalize HPE matrix for white point
XYZw_norm = XYZw/XYZw(2,1);
norm_scalars = HPE_XYZ2LMS_D65*XYZw_norm;
HPE_XYZ2LMS_LG = HPE_XYZ2LMS_D65./norm_scalars;

%conversions 
LMS = cross_talk*HPE_XYZ2LMS_LG*XYZ; %convert XYZ to LMS
LMS_nonlin = ((c1+c2.*(LMS/10000).^n)./(1+c3.*(LMS/10000).^n)).^m; %inverse EOTF nonlinearization
LMS_nonlin(LMS_nonlin<0)=0; %clip to legal boundries
ICtCp = LMS_nonlin2ICtCp*LMS_nonlin; %convert L'M'S' to ICtCp

end
