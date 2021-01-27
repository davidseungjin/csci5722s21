% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [pixel] = sampleBilinear(img, factor, i, j)
% Samples an image bilinearly to grab a more accurate representation of the
% pixel in a scaled image.

[numRows, numColumns, ~] = size(img);

exact_y = (i-1)*(numRows-1) / (factor * numRows - 1) + 1;
exact_x = (j-1)*(numColumns-1) / (factor * numColumns - 1) + 1;

TopLeft_y = floor(exact_y);TopLeft_x =floor(exact_x);
TopRight_y = floor(exact_y);TopRight_x =ceil(exact_x);
BottomLeft_y = ceil(exact_y);BottomLeft_x = floor(exact_x);
BottomRight_y = ceil(exact_y);BottomRight_x = ceil(exact_x);

yAxis_ratio = exact_y - TopLeft_y;
xAxis_ratio = exact_x - TopLeft_x;

pixel = round((1-yAxis_ratio) * ...
    (img(TopLeft_y, TopLeft_x, :) + ...
    xAxis_ratio * ...
    (img(TopRight_y, TopRight_x, :) - img(TopLeft_y, TopLeft_x, :))) + ...
    ...
    yAxis_ratio * ...
    (img(BottomLeft_y, BottomLeft_x, :) + ...
    xAxis_ratio * ...
    (img(BottomRight_y, BottomRight_x, :) - img(BottomLeft_y, BottomLeft_x, :))));


end

