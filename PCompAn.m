% Clear the workspace and screen, close all open figure windows
clc; clear all; close all;

% Preprocess the images: 
% Each image will have certain characteristics:
% 64 x 64
% Images touch the border of the canvas
% Each 'outcome' has eight training images 

data = [];
sum = 0;
[data sum] = preprocess('Training Images\wave\piskel_', 8, data, sum);
[data sum] = preprocess('Training Images\bad_wave\bad_test_piskel_', 8, data, sum);

% Get the average image
Iavg = sum / (2*8);

% Training the program to recognize what a wave looks like
% as well as what it doesn't look like
training_vectors = trainMe(data, Iavg);

% Attempt at identifying the input character
good = 'test_piskel_good';
bad = 'test_piskel_bad';
break_im = 'test_piskel_break';

%%%% GOOD TRAINING IMAGE %%%%
result = recognize(good, training_vectors(:,1:16), data, Iavg,...
               training_vectors(:,17:end));
           
if result(2) == 1
    disp('Recognized image is a wave')
else
    disp('Nope, not a wave')
end

pause 

%%%% BAD TRAINING IMAGE %%%%
result = recognize(bad, training_vectors(:,1:16), data, Iavg,...
               training_vectors(:,17:end));
           
if result(2) == 1
    disp('Recognized image is a wave')
else
    disp('Nope, not a wave')
end

pause

%%%% BREAK TRAINING IMAGE %%%%
result = recognize(break_im, training_vectors(:,1:16), data, Iavg,...
               training_vectors(:,17:end));
           
if result(2) == 1
    disp('Recognized image is a wave')
else
    disp('Nope, not a wave')
end


