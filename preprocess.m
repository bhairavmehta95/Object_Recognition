function [S sum] = preprocess(group_name, max_img, S, sum)
% Pre-processing Module, takes in a group name, number of images, and
% returns a sum as well as a matrix of column vectors (which are appended
% on to the S matrix passed in

I = zeros(64);      %% Images are assumed to be 64 x 64 pixels in size

for i = 1:max_img
    % Load image, convert to grayscale
    fileName = strcat(group_name, int2str(i), '.png');
    
    % Read each image with imread
    I = double(imread(fileName));
    
    % Convert to a BW image
    I_bw = bwlabel(im2bw(I, graythresh(I)));
    
    % Inverse the image
    I_bw = invbw(I_bw);

    % Find the bounding box
    bbox = regionprops(I_bw, 'BoundingBox');

    % Expand image to make it character touch bounding box
    I = res_bbox(I, bbox);
    
    % Get the sum of pixels of the images
    sum = sum + I(:);
    
    % Append the column vectors to the matrix S
    S = [S I(:)];
    
    % Return S
end
