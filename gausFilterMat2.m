function [ Ig ] = gausFilterMat2(I, dt, N)
%This matlab code was written by Donovan Ramsey, Duquesne University
% I is input image, dt is the step size for the gradient decent,
% N is the # of iterations that the gradient decent will be applied.
% Outputs Ig, which is the blurred image

close all 

Ig = padarray(I,[1 1],'replicate');
[m,n] = size(Ig); %storing the size of the x and y demensions 

figure(1); imagesc(Ig); colormap(gray);title('press space to start'); pause();  

for t = 1 : N
    fx = Ig(3:m, 2:n-1) - Ig(2:m-1, 2:n-1); %forwards difference in x 
    bx = Ig(2:m-1, 2:n-1) - Ig(1:m-2, 2:n-1);%backwards difference in x 
    fy = Ig(2:m-1, 3:n) - Ig(2:m-1,  2:n-1); %forwards difference in y
    by =  Ig(2:m-1, 2:n-1) - Ig(2:m-1, 1:n-2); %backwards difference in y 
    ixx = fx - bx; 
    iyy = fy - by; 
    Ig = Ig(2:m-1, 2:n-1); %undo padding 
    Ig = Ig + dt * (ixx + iyy);
    imagesc(Ig); colormap(gray);title(sprintf('time = %d', t)); pause(1e-4); 
    Ig = padarray(Ig,[1 1],'replicate');
end
Ig = Ig(2:m-1, 2:n-1); %undo padding 
end