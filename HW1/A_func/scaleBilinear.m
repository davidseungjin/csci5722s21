function [outImg] = scaleBilinear(inImg, factor)

[numRows, numColumns, numColorChannels] = size(inImg);

newHeight = floor(numRows*factor);
newWidth = floor(numColumns*factor);

outImg = zeros(newHeight, newWidth, numColorChannels, class(inImg));

for i = 1:newHeight
    for j = 1:newWidth
        outImg(i,j,:) = sampleBilinear(inImg, factor, i, j);
    end
end

end

