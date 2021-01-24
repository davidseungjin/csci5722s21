function [outImg] = makeBright_L(inImg, brightness)

[numRows, numColumns, numColorChannels] = size(inImg);

for i = 1:numRows
    for j = 1:numColumns
        for k = 1:numColorChannels
            inImg(i,j,k) = inImg(i,j,k) + brightness;
        end
    end
end

outImg = inImg;

end