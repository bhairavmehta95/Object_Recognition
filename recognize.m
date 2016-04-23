function result = recognize(imageIn, weight_vectors, data, imageAvg, eigenV)
% Preprocess the input image, '1' specifies that there's only one image

% Load image and convert to grayscale
fileName = strcat(imageIn, '.png');

% Read image
img = double(imread(fileName));

% Convert to BW
I_bw = bwlabel(im2bw(img, graythresh(img)));

% Inverse the image to get the character in white over a black canvas
I_bw = invbw(I_bw);

% Find the bounding box
bbox = regionprops(I_bw, 'BoundingBox');

% Now resize the image in the bounding box to 64 x 64
img = res_bbox(img, bbox);

% Convert the input image into a vector and normalize it about the mean
% which is equivalent to removing redundant data common to all images

img = img(:) - imageAvg;       %% img is a 4096 x 1 vector

% Get the projections of the input pattern on the training vectors
W = eigenV * img;        

eig_img = zeros(1,4096);
for i = 1:16
    eig_img = eig_img + eigenV(i, :)*W(i);
end
eig_img = eig_img';
%imshow(vec2mat(eig_img./max(max(eig_img)), 64));

% Find the 'distance' between the 'input pattern weights' and the
% 'training weights' (Mahalanobis), calculates the one that it is "closest
% to" based on its distance away from each of the training vectors
dist = [];
for i = 1:16
    dist = [dist pdist([W'; weight_vectors(:,i)'])];
end

[mDist ID] = min(dist);
ID = floor(ID/8)+1;

result = [mDist ID];