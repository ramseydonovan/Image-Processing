im = imread('kodim20.png'); % type file name here.. 'file.png'
noisy = imnoise(im, 'gaussian', .02);
I = im2double(noisy);
a = im2double(im);

% for black and white
bw = rgb2gray(im);
noisybw = imnoise(bw, 'gaussian', .02);
Ibw = double(noisybw);
abw = double(bw);