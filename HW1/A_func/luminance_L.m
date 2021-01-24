function [outImg] = luminance_L(inImg)

outImg = 0.299*inImg(:,:,1) + 0.587*inImg(:,:,2) + 0.114*inImg(:,:,3);

end

