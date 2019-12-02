%% Data Acquisition
clc;clear;%close all;
Root = 'F:\Workspace';
original = imread(strcat(Root, '\Data\training-raw\2d\DIC-C2DH-HeLa\01\t006.tif'));
original = im2double(original);

% original = imread('F:\Workspace\TRUNG stuffs\non-local-mean-image-denoiser\Data\Acquistion Image\image000.tif');

%% Denoising, this takes a while
t = 4;
f = 3;
h1 = 1;
h2 = 10;
selfsim = 0;
denoised = simple_nlm_modified(original,t,f,h1,h2,selfsim);

%% Matlab denoiser
[denoised estDoS] = imnlmfilt(original, 'SearchWindowSize', 5, 'ComparisonWindowSize', 3);

%% HIP denoising
% denoised = HIP.NLMeans(original, 0.05, [3], [2], []);
%% Applying LoG
sigmas = [5,5,1];   
original_LOG=HIP.LoG(original, sigmas, []);
denoised1_LOG=HIP.LoG(denoised, sigmas, []);
denoised2_LOG=HIP.LoG(denoised, sigmas, []);
% sharpened_denoised_LOG=HIP.LoG(imsharpen(denoised), sigmas, []);
%% sharpen
R=2;C=3;
figure(1); clf;
subplot(R,C,1), imagesc(original), title('Original');
subplot(R,C,2), imagesc(denoised), title('Denoised1');
subplot(R,C,3), imagesc(original - denoised), title('Residual');

% Plot LoP
subplot(R,C,4), imagesc(original_LOG), title('Original');
subplot(R,C,5), imagesc(denoised1_LOG), title('Denoised1');
% subplot(R,C,6), imagesc(denoised2_LOG), title('Denoised2');