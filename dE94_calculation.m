% Allison Hazebrouck

% Calculates delta E 94

% input: two matrices of same size to compare, must be column vectors of
% L*a*b* of size 3xN
% output: vector of delta E values

function dE94 = dE94_calculation(Lab1,Lab2)

dL = Lab1(1,:)-Lab2(1,:);
C1 = (Lab1(2,:).^2+Lab1(3,:).^2).^(1/2);
C2 = (Lab2(2,:).^2+Lab2(3,:).^2).^(1/2);
dC = C1-C2;
dH = (((Lab1(2,:)-Lab2(2,:)).^2)+((Lab1(3,:)-Lab2(3,:)).^2)-dC.^2).^(1/2);
K1 = 0.045; K2 = 0.015;
SC = 1 + K1.*C1; SH = 1 + K2.*C1;

dE94 = (dL.^2 + (dC/SC).^2 + (dH/SH).^2).^(1/2);

end
