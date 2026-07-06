
close all;clear all;clc
addpath(genpath('low_light_code_CNN'));
addpath(genpath('YIQ'));
inputImage = imread("dataset\D2.jpg");
I1 = LLIE(inputImage);   % YIQ result
I2 = CNN(inputImage);    % CNN result

I1 = im2double(I1);
I2 = im2double(I2);
figure;imshow(I1);title('YIQ Output');
figure;imshow(I2);title('CNN Output');
%% WLE Fusion

E1 = WLE(double(rgb2gray(I1)));
E2 = WLE(double(rgb2gray(I2)));

W1 = E1 ./ (E1 + E2 + eps);
W2 = E2 ./ (E1 + E2 + eps);

figure;imshow(W1,[]);
title('W1');

figure;imshow(W2,[]);
title('W2');

final = (W1.*I1 + W2.*I2) ./ (W1 + W2);

final = min(max(final,0),1);

figure;
imshow(final);
title('Final Fused');

%% Evaluation

ref = im2double(imread('dataset/D2_ref.jpg'));
ref = imresize(ref,[size(final,1),size(final,2)]);

PSNR = psnr(final,ref);
SSIM = ssim(final,ref);

fprintf('PSNR = %.4f\n',PSNR);
fprintf('SSIM = %.4f\n',SSIM);
metricsr = main_calculate_metrics(ref,final);