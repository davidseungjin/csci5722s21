% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = invert_L(inImg)
% Inverts the image by subtracting each RGB value for each pixel by 255.

[numRows, numColumns, numColorChannels] = size(inImg);

% Iterate over all the pixels and RGB values, then updating accordingly.
for i = 1:numRows
    for j = 1:numColumns
        for k = 1:numColorChannels
            inImg(i,j,k) = 255 - inImg(i,j,k);
        end
    end
end

outImg = inImg;

end

