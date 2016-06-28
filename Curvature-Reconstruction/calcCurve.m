function [ curvature ] = calcCurve(I)
% takes in a mxn matrix and returns the curvature image  
% I must be padded like such "I = padarray(I,[1 1],'replicate');" before 
% passed to this function. 

    [m,n] = size(I); %storing the size of the x and y demensions 

    fx =  I(3:m, 2:n-1) - I(2:m-1, 2:n-1); %forwards difference in x 
    bx =  I(2:m-1, 2:n-1) - I(1:m-2, 2:n-1);%backwards difference in x 
    fy =  I(2:m-1, 3:n) - I(2:m-1,  2:n-1); %forwards difference in y
    by =  I(2:m-1, 2:n-1) - I(2:m-1, 1:n-2); %backwards difference in y 
    fy2 = I(1:m-2, 3:n) - I(1:m-2, 2:n-1);
    fx2 = I(3:m, 1:n-2) - I(2:m-1, 1:n-2);

    dx =  (fx ./ (sqrt(fx.^2 + fy.^2 + .0001))) - (bx ./ (sqrt(bx.^2 + fy2.^2 + .0001))) ;
    dy =  (fy ./ (sqrt(fy.^2 + fx.^2 + .0001)) - (by ./ (sqrt(by.^2 + fx2.^2 + .0001)))) ;
    
    curvature = dx + dy; 
end

