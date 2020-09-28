clc; clear all; close all;

im = imread('aorta-chest1.tif');
%im = imread('aorta-chest2.tif');

%%Filtro para aorta-chest2.tif
%F = medfilt2(im); 


%%Filtro para aorta-chest1.tif
[m, n] = size(im);
N = 5;
h = binomial(N);
h = h'*h;
h = h / sum(h(:));
FA = fft2(im, m+N-1, n+N-1);
FH = fft2(h, m+N-1, n+N-1);
FHS = fftshift(FH);

FBS = FA.*FH;
FB = fftshift(FBS);
FB2 = ifft2(FB);
B = uint8(abs(FB2));

figure;
image(im); colormap(gray(256));
title('Imagen original');

figure;
image(B); colormap(gray(256));
title('Imagen filtrada en fecuencia');

%Imagen aorta-chest2.tif
% figure;
% image(F); colormap(gray(256));
% title('filtro no lineal');