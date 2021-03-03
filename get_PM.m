% Allison Hazebrouck

% Calculate Phosphor Matrix from chromaticities of primaries and white
% point

% Input(optional): 2x4 matrix of xy chromaticity coordinates of each
% primary and the white point in the order r, g, b, w
% If run without input argument, it will default to hardcoded primaries,
% currently set to ITU Rec BT.2020

function phosphor_mat = get_PM(primaries_xyz)

if ~exist('primaries_xyz','var')
    % primaries_xyz = [0.64, 0.3, 0.15, 0.3127; 0.33, 0.6, 0.06, 0.329]; %Rec709
    primaries_xyz = [0.708, 0.17, 0.131, 0.3127; 0.292, 0.797, 0.046, 0.329]; %Rec2020
    % primaries_xyz = [0.7347, 0, 0.0001, 0.32168; 0.2653, 1, -0.077, 0.33767]; %ACES Primaries
end

primaries_xyz(3,:) = 1 - (primaries_xyz(1,:)+primaries_xyz(2,:));

%get phosphor matrix
c_inv = inv(primaries_xyz(:,1:3));
w_norm = primaries_xyz(:,4)/primaries_xyz(2,4);
j_diag = diag(c_inv*w_norm);
phosphor_mat = primaries_xyz(:,1:3)*j_diag;
inv_phosphor_mat = inv(phosphor_mat);
end