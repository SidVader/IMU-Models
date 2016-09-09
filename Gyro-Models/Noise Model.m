% X[n] = a*X[n-1] + b*N[n-1], sd_X = B, sd_N = sqrt(1-((a*a*B)/b))
% a = exp(-0.01/T), b = T*(1-exp(-0.01/T)), T is the discrete time parameter
% gyro_noise = X + arw
% Rate Random Walk is not considered as parameter related to it was not found in the DataSheet.

T = 120; % T is discrete time parameter and is to be decided by us.
a = exp(-0.01/T);
b = T*(1-exp(-0.01/T));
B = 3*power(10,-3);
sd_arw = 25*power(10, -3);
sd_X = B;
sd_N = sqrt(1-((power(a,2)*B)/b)); % Standard Deviation of White Noise.
X0 = 0;
num = 1000; % Number of readings.

arw = normrnd(0, sd_arw, 1, num); % Normal Distribution of Angular Random Walk based on SD = sd_arw
N = normrnd(0, sd_N, 1, num); % Normal Distribution of White Noise based on SD = sd_N
X(1) = a*X0 + b*N(1);
gyro_noise(1) = X(1) + arw(1); 
for i=2:num,
  X(i) = a*X(i-1) + N(i);
  gyro_noise(i) = X(i) + arw(i);    
end;

% I have no idea of the code following, just copy pasted it to plot gyro_noise.
M=50;
Rx=Rx_est(gyro_noise,M);   
plot(gyro_noise)
title('Gyro Noise Model')
pause
