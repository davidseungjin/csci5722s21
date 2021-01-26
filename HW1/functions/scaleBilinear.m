% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = scaleBilinear(inImg, factor)
% Scales an image using the bilinear sampling technique.

[numRows, numColumns, numColorChannels] = size(inImg);

% Round down to the nearest integer when scaling.
newHeight = floor(numRows*factor);
newWidth = floor(numColumns*factor);

outImg = zeros(newHeight, newWidth, numColorChannels, class(inImg));

% Set each pixel in the output using bilinear sampling on the original
% image.
for i = 1:newHeight
    for j = 1:newWidth
        outImg(i,j,:) = sampleBilinear(inImg, factor, i, j);
    end
end

end

