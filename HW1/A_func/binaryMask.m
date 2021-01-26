function [outImg] = binaryMask(inImg)

meansAcrossColumns = mean(inImg);
meanValue = mean(meansAcrossColumns);

outImg = inImg;
outImg(inImg > meanValue) = 0;
outImg(inImg <= meanValue) = intmax(class(inImg));

end

