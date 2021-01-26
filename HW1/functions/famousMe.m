% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = famousMe(backgroundImg, humanImg, x, y, factor)
% Crops out an image of a human and places it onto a background in a
% specified position. Also allows for the human image to be scaled by a
% factor.

% Scale human image
scaledHumanImg = scaleBilinear(humanImg, factor);

% Generate binary mask
humanImgBinaryMask = binaryMask(scaledHumanImg);

% Place the human image on the background image.
% When the human image's corresponding pixel is white on the binary mask,
% then we will update the pixel on the background image to use the human
% image's pixel. Otherwise (binary mask pixel is black), we will leave the
% background image's pixel the same.
WHITE = [255, 255, 255];

[numRowsHumanImg, numColumnsHumanImg, numColorChannels] = size(scaledHumanImg);
[numRowsBackgroundImg, numColumnsBackgroundImg, numColorChannels] = size(backgroundImg);

outImg = backgroundImg;
i = 1;
j = 1;
% These loop conditions certify that we don't go out of bounds of either
% image.
while i <= numRowsHumanImg && i+y <= numRowsBackgroundImg
    j = 1;
    while j <= numColumnsHumanImg && j+x <= numColumnsBackgroundImg
        if humanImgBinaryMask(i,j,:) == WHITE
            outImg(i+y,j+x,:) = scaledHumanImg(i,j,:);
        end
        j = j+1;
    end
    i = i+1;
end

end

