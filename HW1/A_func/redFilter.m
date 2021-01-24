function [outImg] = redFilter(inImg, redVal)

remainder = (1-redVal) / 2;
outImg = inImg;
outImg(:,:,1) = redVal*outImg(:,:,1);
outImg(:,:,2) = remainder*outImg(:,:,2);
outImg(:,:,3) = remainder*outImg(:,:,3);

end

