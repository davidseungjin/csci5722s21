function [outImg] = binaryMask(inImg)

meansAcrossColumns = mean(inImg);
meanValue = mean(meansAcrossColumns);

[numRows, numColumns, numColorChannels] = size(inImg);

for i = 1:numRows
    for j = 1:numColumns
        for k = 1:numColorChannels
            if inImg(i,j,k) < meanValue
                inImg(i,j,k) = 255;
            else
                inImg(i,j,k) = 0;
            end
        end
    end
end

outImg = inImg

end

