function inv = invbw(I)
% Invert a black and white image of size 64 x 64 pixels
inv = zeros(64);
for i = 1:64
    for j = 1:64
        inv(i,j) = not(I(i,j));
    end
end
