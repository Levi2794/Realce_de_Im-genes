clc; clear all; close all;

%% carga una imagen
[imagen dir] = uigetfile('*.tif','Selecciona una imagen');
imagen = strcat(dir, imagen);
im = imread(imagen);

%%Filtro media
f_m = fspecial('average', [10 10]);
im_f = imfilter(im, f_m);

%%Filtro mediana
NN = 10;
B = zeros(size(im));
B = nlfilter(im, [NN NN], @func_mediana);
B = uint8(B);

%%Filtro no lineal de la media
im_f2 = medfilt2(im); 
%%%Cambios muy abrubtos en los pixeles vecionos el filtro los desaparece

%%Filtro gaussiano
f_m2 = fspecial('gaussian', [5 5], 15);
im_f3 = imfilter(im, f_m2);
%im_f3 = imgaussfilt(im, 2);    %%Filtro gaussiano con desviacion estandar 2

%%Filtro kuwahara
K = kuwahara(im,5,true);     %%%Filtro kuwahara sacado de la documentacion de MatLab
                             %%%https://la.mathworks.com/matlabcentral/fileexchange/8171-kuwahara-filter 


%%
[m, n] = size(im);  %%% dimencion de la imagen
N = 5;  %%% dimencion del filtro

b = binomial(N);
b = b'*b;
b = b / sum(b(:));


tf = fft2(im, m+N-1, n+N-1); %transformada de furier
ff = fft2(b, m+N-1, n+N-1); %filtro con tamaño de la imagen
aff = abs(ff);
f = fftshift(aff);

%Multiplicacion de espectros
ce = tf.*ff; %convolucion en el espacio
f2 = fftshift(ce);
i_f = uint8(ifft2(ce));

%% Mostramos la imagen
figure;
%subplot(2,3,1);
imshow(im); colormap(gray(256));
%title('Imagen original c/ruido gaussiano');
%title('Imagen original c/ruido sal y pimienta');
% 
% figure;
% %subplot(2,3,2);
% image(im_f); colormap(gray(256));
% title('Imagen c/filtro media');

figure;
%subplot(2,3,3);
imshow(im_f2); colormap(gray(256));
%title('Imagen c/filtro no lineal de la media');

% figure;
% %subplot(2,3,4.5);
% image(im_f3); colormap(gray(256));
% title('Imagen c/filtro Gaussiano');
% 
% figure;
% %subplot(2,3,5.5);
% image(i_f); colormap(gray(256));
% title('Imagen c/filtrada en fecuencia');
% 
% figure;
% %subplot(1,2,1);
% imshow(K); colormap(gray(256));
% title('Imagen c/filtro Kuwahara');
% 
% figure;
% %subplot(1,2,2);
% imshow(B); colormap(gray(256));
% title('Imagen c/filtro mediana');

%%Filtro de wiener pag. 147 cuaderno de imag

