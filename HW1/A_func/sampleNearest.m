% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [pixel] = sampleNearest(img, factor, i, j)
% Samples an image linearly to grab a pixel for a scaled image.

[numRows, numColumns, numColorChannels] = size(img);

original_i = floor(i/factor);
if original_i < 1
    original_i = 1;
elseif original_i > numRows
    original_i = numRows;
end

original_j = floor(j/factor);
if original_j < 1
    original_j = 1;
elseif original_j > numColumns
    original_j = numColumns;
end

pixel = img(original_i, original_j, :);

end

