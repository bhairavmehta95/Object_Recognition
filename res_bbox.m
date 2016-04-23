function img = res_bbox(I, bbox)
% Resize the image such that the white character inside the image touches
% the canvas borders

% Get the coordinates of the bounding box from the structure
numcol = floor(bbox.BoundingBox(3));
numrow = floor(bbox.BoundingBox(4));

irow = ceil(bbox.BoundingBox(2));
icol = ceil(bbox.BoundingBox(1));

% This will store the portion of the image to be resized, that is, the
% part of the image contained by the bounding box
tmp = zeros(numrow, numcol);

% Get the portion of the image to be resized
for i = irow:irow+numrow-1
    for j = icol:icol+numcol-1
        tmp(i-irow+1, j-icol+1) = I(i,j);
    end
end

% Resize the part of the image contained in the bounding box to a 64 x 64
% pixel image
img = imresize(tmp, [64 64],'bicubic');
