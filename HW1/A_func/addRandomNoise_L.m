function [outImg] = addRandomNoise_L(inImg)

rng('default')

[numRows, numColumns, numColorChannels] = size(inImg);
randNums = randi([-255 255], numRows, numColumns, numColorChannels, class(inImg));
outImg = int64(inImg) + int64(randNums); % Allows us to take the pixel values below zero.
outImg = uint8(outImg); % Forces all negative pixel values to be equal to zero.

end

