%% Data Acquisition
clc;clear;%close all;
original = imread('D:\Workspace\cell-tracking-challenge\Data\raw\Fluo-N2DH-GOWT1\01\t000.tif');
original = im2double(original);
%% Denoising, this takes a while
t = 2;
f = 1;
h1 = 1;
h2 = 10;
selfsim = 0;
denoised = simple_nlm_modified(original,t,f,h1,h2,selfsim);
%% HIP denoising
% denoised = HIP.NLMeans(original, 0.05, [3], [2], []);
%% Applying LoG
sigmas = [5,5,1];   
original_LOG=HIP.LoG(original, sigmas, []);
denoised_LOG=HIP.LoG(denoised, sigmas, []);
sharpened_denoised_LOG=HIP.LoG(imsharpen(denoised), sigmas, []);

%% sharpen
R=2;C=3;
figure(1); clf;
subplot(R,C,1), imagesc(original), title('Original');
subplot(R,C,2), imagesc(denoised), title('Denoised');
subplot(R,C,3), imagesc(imsharpen(denoised)), title('Sharpened Denoised');

% Plot LoP
subplot(R,C,4), imagesc(original), title('Original');
subplot(R,C,5), imagesc(denoised), title('Denoised');
subplot(R,C,6), imagesc(imsharpen(denoised)), title('Sharpened Denoised');