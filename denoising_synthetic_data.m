%% Data Acquisition
clc;clear;%close all;

optical_image = imread('D:\OneDrive\Education\Drexel\2019 - 2020\Fall\ECEC 487 Pattern Recognition\Project\Code\Data\Optical Image\image000.tif');
optical_image = rgb2gray(optical_image);

GT_image = imread('D:\OneDrive\Education\Drexel\2019 - 2020\Fall\ECEC 487 Pattern Recognition\Project\Code\Data\Phantom Image\image000.tif');
GT_image = rgb2gray(GT_image);

noisy_image = imread('D:\OneDrive\Education\Drexel\2019 - 2020\Fall\ECEC 487 Pattern Recognition\Project\Code\Data\Acquistion Image\image000.tif');
noisy_image = rgb2gray(noisy_image);
noisy_image = im2double(noisy_image);
%% Denoising, this takes a while
t = 2;
f = 1;
h1 = 1;
h2 = 10;
selfsim = 0;
denoised_image = simple_nlm_modified(noisy_image,t,f,h1,h2,selfsim);
%% HIP denoising
% denoised = HIP.NLMeans(original, 0.05, [3], [2], []);

%% Applying LoG
sigmas = [2,2,1];   
original_LOG=HIP.LoG(noisy_image, sigmas, []);
denoised_LOG=HIP.LoG(denoised_image, sigmas, []);
denoised_LOG_sharpened=HIP.LoG(imsharpen(denoised_image), sigmas, []);

%% Plot
R = 2;C = 2;
figure(2); clf;
subplot(R,C,1), imagesc(noisy_image), title('Noisy Image');
subplot(R,C,2), imagesc(denoised_image), title('Denoised Image');
subplot(R,C,3),imagesc(optical_image),title('Optical Image');
subplot(R,C,4),imagesc(GT_image),title('GT');