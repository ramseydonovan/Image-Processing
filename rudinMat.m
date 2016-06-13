function [ Ig ] = rudinMat(I, dt, N)
%Algorithm described in “Nonlinear Total Variation Based Noise Removal Algorithms” 
% by Leonid Rudin, Stanley Osher, and Emad Fatemi (1992)
%This matlab code was written by Donovan Ramsey, Duquesne University
%This function takes in an image I, a time step dt, and # of iterations N. 
% A good value for N is 500 - 700. 

close all 
Ig0 = I; 
Ig = padarray(I,[1 1],'replicate');
[m,n] = size(Ig); %storing the size of the x and y demensions 

figure(1); imagesc(Ig); colormap(gray);title('press space to start'); pause();  

for t = 1 : N
    fx = Ig(3:m, 2:n-1) - Ig(2:m-1, 2:n-1); %forwards difference in x 
    bx = Ig(2:m-1, 2:n-1) - Ig(1:m-2, 2:n-1);%backwards difference in x 
    fy = Ig(2:m-1, 3:n) - Ig(2:m-1,  2:n-1); %forwards difference in y
    by =  Ig(2:m-1, 2:n-1) - Ig(2:m-1, 1:n-2); %backwards difference in y 
    fy2 = Ig(1:m-2, 3:n) - Ig(1:m-2, 2:n-1);
    fx2 = Ig(3:m, 1:n-2) - Ig(2:m-1, 1:n-2);
   
    dx =  (fx ./ (sqrt(fx.^2 + fy.^2 + .000001))) - (bx ./ (sqrt(bx.^2 + fy2.^2 + .000001))) ;
    dy =  (fy ./ (sqrt(fy.^2 + fx.^2 + .000001)) - (by ./ (sqrt(by.^2 + fx2.^2 + .000001)))) ;
    Ig = Ig(2:m-1, 2:n-1); %undo padding    
    Ig = Ig + (dt * (dx + dy + .01*(Ig0 - Ig)));   
    imagesc(Ig); colormap(gray);title(sprintf('time = %d', t)); pause(1e-4); %print
    Ig = padarray(Ig,[1 1],'replicate'); %reapply padding
end
end

