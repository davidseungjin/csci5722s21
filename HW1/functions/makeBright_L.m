% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = makeBright_L(inImg, brightness)
% Adds a specified amount (brightness) to each RGB value for each pixel in
% an image.

[numRows, numColumns, numColorChannels] = size(inImg);

% Iterate over all rows, columns, and color channels; and update
% accordingly.
for i = 1:numRows
    for j = 1:numColumns
        for k = 1:numColorChannels
            inImg(i,j,k) = inImg(i,j,k) + brightness;
        end
    end
end

outImg = inImg;

end