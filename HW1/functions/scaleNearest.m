% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = scaleNearest(inImg, factor)
% Scales an image using the linear sampling technique.

[numRows, numColumns, numColorChannels] = size(inImg);

newHeight = floor(numRows*factor);
newWidth = floor(numColumns*factor);

outImg = zeros(newHeight, newWidth, numColorChannels, class(inImg));

% Set each pixel in the output using linear sampling on the original image.
for i = 1:newHeight
    for j = 1:newWidth
        outImg(i,j,:) = sampleNearest(inImg, factor, i, j);
    end
end

end

