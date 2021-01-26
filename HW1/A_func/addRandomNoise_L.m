% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = addRandomNoise_L(inImg)
% Adds random noise to each pixel of inImg within the range of -255 to +255.

% Let's first grab the dimensions of inImg so we know how many random
% numbers we need to generate.
[numRows, numColumns, numColorChannels] = size(inImg);

% Use the default RNG, and generate the numbers.
rng('default')
randNums = randi([-255 255], numRows, numColumns, numColorChannels, class(inImg));

% Add the numbers. Use int64() as it allows us to take the pixel values below zero.
outImg = int64(inImg) + int64(randNums);

% Force the negative pixel values to be equal to zero with uint8().
outImg = uint8(outImg);

end

