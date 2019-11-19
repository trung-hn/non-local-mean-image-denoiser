
% mse = norm(image-denoised, 'fro')/numel(image);
% psnr = 10*log10(255^2/mse)
%%
clc;clear;%close all;
% original = imread('D:\Workspace\cell-tracking-challenge\Data\raw\2d\Fluo-N2DL-HeLa\01\t006.tif');

original = imread('D:\Workspace\cell-tracking-challenge\Data\raw\Fluo-N2DH-GOWT1\01\t000.tif');

original = im2double(original);
t = 3;
f = 2;
h1 = 1;
h2 = 10;
selfsim = 0;
%% Denoising, this takes a while
denoised = simple_nlm_modified(original,t,f,h1,h2,selfsim);
%% HIP denoising
% denoised = HIP.NLMeans(original, 0.05, [3], [2], []);

%% Applying LoG
sigmas = [2,2,1];   
original_LOG=HIP.LoG(original, sigmas, []);
denoised_LOG=HIP.LoG(denoised, sigmas, []);
denoised_LOG_sharpened=HIP.LoG(imsharpen(denoised), sigmas, []);

%% Plot
figure(1); clf;
subplot(2,3,1), imagesc(original), title('Original');
subplot(2,3,2), imagesc(denoised), title('Denoised');
subplot(2,3,3),imagesc(original-denoised),title('Residuals');

subplot(2,3,4), imagesc(original_LOG), title('Original');
subplot(2,3,5), imagesc(denoised_LOG), title('Denoised');
subplot(2,3,6), imagesc(imsharpen(denoised_LOG)), title('Denoised');

%% sharpen
figure(2); clf;
subplot(2,2,1), imagesc(original), title('Original');
subplot(2,2,2), imagesc(imsharpen(original)), title('Denoised');
subplot(2,2,3),imagesc(original-denoised),title('Residuals');