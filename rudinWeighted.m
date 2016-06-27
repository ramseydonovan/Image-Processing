function [ I ] = rudinWeighted(I, dt, lambda, N)
%Algorithm described in "Color TV: Total Variation Methods for Restoration
%of Vector Valued Images" by Peter Blomgren, Tony F. Chan
%This matlab code was written by Donovan Ramsey, Duquesne University
%This function takes in a noisy colored image I as a double, a time step dt, 
%value for lambda, and # of iterations N. Returns a image of type double 
%rudinWeighted(I, .005, .1, 5000);  
close all 
figure(1); imagesc(I);title('press space to start'); pause();  
% store original I for the fidelity term
Ig0r = I(:,:,1); 
Ig0g = I(:,:,2); 
Ig0b = I(:,:,3); 

for t = 1 : N
for rgb = 1 : 3
if rgb == 1
    Igr = I(:,:,1); % Red channel
    Ig = padarray(Igr,[1 1],'replicate');
elseif  rgb == 2
    Igg = I(:,:,2); % Green channel
    Ig = padarray(Igg,[1 1],'replicate'); 
else 
    Igb = I(:,:,3); % Blue channel
    Ig = padarray(Igb,[1 1],'replicate'); 
end


   [m,n] = size(Ig); %storing the size of the x and y demensions 

    fx = Ig(3:m, 2:n-1) - Ig(2:m-1, 2:n-1); %forwards difference in x 
    bx = Ig(2:m-1, 2:n-1) - Ig(1:m-2, 2:n-1);%backwards difference in x 
    fy = Ig(2:m-1, 3:n) - Ig(2:m-1,  2:n-1); %forwards difference in y
    by =  Ig(2:m-1, 2:n-1) - Ig(2:m-1, 1:n-2); %backwards difference in y 
    fy2 = Ig(1:m-2, 3:n) - Ig(1:m-2, 2:n-1);
    fx2 = Ig(3:m, 1:n-2) - Ig(2:m-1, 1:n-2);
   
    dx =  (fx ./ (sqrt(fx.^2 + fy.^2 + .000001))) - (bx ./ (sqrt(bx.^2 + fy2.^2 + .000001))) ;
    dy =  (fy ./ (sqrt(fy.^2 + fx.^2 + .000001)) - (by ./ (sqrt(by.^2 + fx2.^2 + .000001)))) ;
    Ig = Ig(2:m-1, 2:n-1); %undo padding    
    Ig = dx + dy;
    tv = sqrt(fx.^2 + fy.^2); %TV(total variation)norm for each channel 
 
if rgb == 1
    sr = Ig; % Red channel
    tvr = sum(tv(:));    
elseif  rgb == 2
     sg = Ig; % Green channel
     tvg = sum(tv(:)); 
else 
     tvb = sum(tv(:)); 
     tvN = sqrt(sr.^2 + sg.^2 + Ig.^2 + .0000000001); % total variation norm  
     tvs = sum(tvN(:)); 
     I(:,:,1) = Igr + (dt * (((tvr/tvs)* sr) - lambda*(Igr - Ig0r)));
     I(:,:,2) = Igg + (dt * (((tvg/tvs)* sg) - lambda*(Igg - Ig0g)));
     I(:,:,3) = Igb + (dt * (((tvb/tvs)* Ig) - lambda*(Igb - Ig0b)));
     imagesc(I);title(sprintf('time = %d', t)); pause(1e-4); %print
end
end
end
end

