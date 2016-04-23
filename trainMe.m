function trainingVectors = trainMe(data, AvgImage)
% Obtain the training vectors

% Subtract the average image from each column of the matrix 'data'
len = size(data);
for i = 1:len(2)
    data(:, i) = data(:, i) - AvgImage;
end

% Find the eigenvectors of the covariance matrix using the manipulation as
% discussed in the theory. Get them in the descending order. To do this we
% use eigs() instead of eig() and get the 28 most largest eigenvalues
% (magnitude).
L = data'*data;

[v d] = eigs(L,16);
V = (data*v)';
D = 64 * d;         %% Since we have 64 pixels on each side, n = 64

% Get the weight vectors of the training sets
trainingVectors = [V*data V];

%trainingVectors_size = size(trainingVectors)

% Display the eigenimage
%a = 6;
%imshow(vec2mat(V(a,:)/max(max(V(a,:))), 64));
