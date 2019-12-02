function denoise_all_image(path, output_path)
    files = dir(strcat(path, '\*.tif'));
    
    % Loop thru each file
    for n=1:length(files)
        % Get Image
        original_image = imread(fullfile(path, files(n).name));
        % Denoise
        denoised_image = imnlmfilt(original_image, 'SearchWindowSize', 17, 'ComparisonWindowSize', 13);
        % Save denoised image
%         imwrite(denoised_image, fullfile(output_path, files(n).name));
        
        % Update figure with each frame
        figure(1)
        clf
        R=2;C=3;
        subplot(R,C,1), imagesc(original_image), title('Original');
        subplot(R,C,2), imagesc(denoised_image), title('Denoised');
        subplot(R,C,3), imagesc(original_image-denoised_image), title('Residual');
    end

end