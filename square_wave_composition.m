% Allison Hazebrouck

% Estimates a square wave using the sum of sine waves

% Input: number of sine waves to combine

function square_wave_composition(repetitions)

x = linspace(0,1)';
sin_combined = 0;
iter = 1;
for c = 1:repetitions
    sin_temp = (1/iter)*sin(iter*x*2*pi);
    sin_combined = sin_combined + sin_temp;
    iter = iter + 2;
end
    
square_func = square(x*2*pi);
plot(x,square_func,'-.', x,(4/pi)*sin_combined)

end

