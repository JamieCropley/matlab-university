%Clear the command window
clc

% Creates a new FIS called 'tipper' and assign it to variable 'a'
a = newfis('cw');

% The inputs
a = addvar(a, 'input', 'Water Temperature in Centigrade (Hot to cold in Degrees)', [0 90]); %common sense dictates water temp, but 90 Degrees Centigrade is usually as high as washing machines go up to
a = addvar(a, 'input', 'Spin Speed (Revolutions Per Minute) (RPM))', [0 1600]); %max speed is actually 1600 rpm
a = addvar(a, 'input', 'Water hardness (Calcium Carbonate Content) CaCO_3)', [0 120]); %water is very hard (max) at 120 CaCO_3

% The Output
a = addvar(a, 'output', 'Wash time (minutes)', [0 95]); %maximum wash time is 95 minutes

% The membership functions

% gaussmf: [SIGMA, Center] (bell shaped curve)
% trimf: [left foot, center, right foot]
% sigmf: [left foot, center, right foot] (smooth version of trimf)
% trapmf: [left foot, left shoulder, right shoulder, right foot]
% pimf: [left foot, left shoulder, right shoulder, right foot] (smooth version of trapmf)


% addmf(the system, 'input' or 'output', Name of membership function, type of function, parameters of function)
a = addmf(a, 'input', 1, 'Very Cold', 'gaussmf', [12 0]);
a = addmf(a, 'input', 1, 'Cold', 'gaussmf', [12 10]);
a = addmf(a, 'input', 1, 'Hot', 'gaussmf', [12 40]);
a = addmf(a, 'input', 1, 'Very Hot', 'gaussmf', [12 90]);

a = addmf(a, 'input', 2, 'Very Slow', 'trimf', [0 0 400]);
a = addmf(a, 'input', 2, 'Slow', 'trimf', [400 600 800]);
a = addmf(a, 'input', 2, 'Fast', 'trimf', [600 800 1000]);
a = addmf(a, 'input', 2, 'Very Fast', 'trapmf', [800 1200 1600 1600]); %this one serves a much bigger range thus trapmf chosen

a = addmf(a, 'input', 3, 'Soft', 'trapmf', [0 0 20 20]); 
a = addmf(a, 'input', 3, 'Moderately soft', 'trapmf', [20 20 40 40]); 
a = addmf(a, 'input', 3, 'Moderately hard', 'trapmf', [40 40 80 80]);
a = addmf(a, 'input', 3, 'Hard', 'trapmf', [80 80 120 120]);
a = addmf(a, 'input', 3, 'Very hard', 'trapmf', [120 120 120 120]);

% The output membership functions
a = addmf(a, 'output', 1, 'Not a long time', 'trapmf', [0 10 25 45]);
a = addmf(a, 'output', 1, 'A long time', 'gaussmf', [65 95]);


%Plot the the membership functions for the inputs
figure(1)
%subplot(x,y,z)
subplot(4,1,1), plotmf(a,'input',1);
subplot(4,1,2), plotmf(a,'input',2);
subplot(4,1,3), plotmf(a,'input',3);

subplot(4,1,4), plotmf(a,'output',1);


getfis(a);