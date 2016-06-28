function [ I ] = rudinCC(a, I, dt, N)
%Algorithm described in “Nonlinear Total Variation Based Noise Removal Algorithms” 
% by Leonid Rudin, Stanley Osher, and Emad Fatemi (1992) for colored images
%This matlab code was written by Donovan Ramsey, Duquesne University

%This function takes in a noisy colored image I, a time step dt, and # of 
%iterations N.  'a' is the original image. 

%This function requires my function "calcCurve.m" 

% Sample input: rudinCC(a, I, .005, 500); with lambda = .5

[m,n] = size(I(:,:,1));
m = m+2; 
n = n+2;
%% clean curvature of the original image for all three RGB channels 

% red channel 
    ar = a(:,:,1); 
    aPadded = padarray(ar,[1 1],'replicate');
    ccr = calcCurve(aPadded);
% Green channel   
    ag = a(:,:,2); 
    aPadded = padarray(ag,[1 1],'replicate'); 
    ccg = calcCurve(aPadded);
% Blue channel
    ab = a(:,:,3); 
    aPadded = padarray(ab,[1 1],'replicate'); 
    ccb = calcCurve(aPadded);
%%
close all 

figure(1); imagesc(I);title('press space to start'); pause();  

Ig0r = I(:,:,1);
Ig0g = I(:,:,2);
Ig0b = I(:,:,3);

for t = 1 : N
for rgb = 1 : 3
if rgb == 1
    Igr = I(:,:,1); % Red channel
    Ig0 = Ig0r; 
    Ig = padarray(Igr,[1 1],'replicate');
    cleanCurvature = ccr;
elseif  rgb == 2
    Igg = I(:,:,2); % Green channel
    Ig0 = Ig0g; 
    Ig = padarray(Igg,[1 1],'replicate'); 
    cleanCurvature = ccg;
else 
    Igb = I(:,:,3); % Blue channel
    Ig0 = Ig0b; 
    Ig = padarray(Igb,[1 1],'replicate'); 
    cleanCurvature = ccb;
end

    K  = calcCurve(Ig);
    Ig = Ig(2:m-1, 2:n-1); %undo padding    
    Ig = Ig + dt * (K  - cleanCurvature + .01*(Ig0 - Ig));   
    
if rgb == 1
    I(:,:,1) = Ig; % Red channel
elseif  rgb == 2
    I(:,:,2) = Ig; % Green channel
else 
    I(:,:,3) = Ig; % Blue channel
     imagesc(I);title(sprintf('time = %d', t)); pause(1e-4); %print
end
end
end
end

