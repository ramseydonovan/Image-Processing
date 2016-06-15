function [ Ig ] = iterativeMedian(I, layers, N)
% This matlab code was written by Donovan Ramsey, Duquesne University
% Applies the median filter to an image
% 'I' is the matrix of intensity values of an image 
% 'layers' is the amount of surrounding 'neighborhoods'
% Each neighborhood is a square frame of pixels with center I(x,y)
% layers = 1 calculates the median of 3x3 sub-matricies
% layers = 2 does the same for 5x5 sub-matricies 
% N is the number of iterations that the median filter will be applied
close all 
Ig = padarray(I,[layers layers],'replicate');
figure(1); imagesc(Ig); colormap(gray);title('press space to start'); pause();

[m,n] = size(Ig); % storing the size of the x and y demensions 
for t = 1 : N
    IgCopy = Ig;
    for x = (1+layers)  : m-layers
        for y = (1+layers)  : n-layers
           %A = zeros(layers, layers); 
           A = IgCopy(x-layers:x+layers, y-layers:y+layers); 
           B = A(:)';
           sortedArray = sort(B);
         Ig(x,y) = sortedArray((((layers + 2)^2 / 2) + .5)); % retrieves the median value 
        end 
    end
    imagesc(Ig); colormap(gray);title(sprintf('time = %d', t)); pause(1e-4);
end
Ig = Ig(2:m-layers, 2:n-layers); %undo padding 
end

