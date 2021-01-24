function [outImg] = invert_L(inImg)

[numRows, numColumns, numColorChannels] = size(inImg);

for i = 1:numRows
    for j = 1:numColumns
        for k = 1:numColorChannels
            inImg(i,j,k) = 255 - inImg(i,j,k);
        end
    end
end

outImg = inImg;

end

