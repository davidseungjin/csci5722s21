% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [pixel] = sampleBilinear(img, factor, i, j)
% Samples an image bilinearly to grab a more accurate representation of the
% pixel in a scaled image.

[numRows, numColumns, numColorChannels] = size(img);

original_i = i/factor;
if original_i < 1
    original_i = 1;
elseif original_i > numRows
    original_i = numRows;
end

original_j = j/factor;
if original_j < 1
    original_j = 1;
elseif original_j > numColumns
    original_j = numColumns;
end

% Grab all four pixels that these indices could possibly round to.
pixels = [ ...
    img(floor(original_i), floor(original_j), :), ...
    img(floor(original_i), ceil(original_j), :), ...
    img(ceil(original_i), floor(original_j), :), ...
    img(ceil(original_i), ceil(original_j), :) ...
];

% Calculate the mean value of all four pixels.
pixel = [mean(pixels(:,:,1)), mean(pixels(:,:,2)), mean(pixels(:,:,3))];

end

