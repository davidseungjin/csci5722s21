function [outImg] = addRandomNoise_L(inImg)

rng('default')

[numRows, numColumns, numColorChannels] = size(inImg);
randNums = randi([-255 255], numRows, numColumns, numColorChannels);
outImg = inImg + uint8(randNums);

end

