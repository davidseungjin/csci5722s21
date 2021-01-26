function [outImg] = redFilter(inImg, redVal)

[numRows, numColumns, numColorChannels] = size(inImg);

width = floor(numColumns/3);

% Left   1/3: grayscale
leftImg = inImg(:,1:width,:);
leftImg = luminance_L(leftImg);
temp = zeros(numRows, width, 3, class(inImg));
temp(:,:,1) = leftImg(:,:); % just copying the same grayscale value 3x to get the same color in RGB
temp(:,:,2) = leftImg(:,:);
temp(:,:,3) = leftImg(:,:);
leftImg = temp;

% Middle 1/3: original image
middleImg = inImg(:,width+1:width*2,:);

% Right  1/3: red filter
rightImg = inImg(:,width*2+1:numColumns,:);
remainder = (1-redVal) / 2;
rightImg(:,:,1) = redVal*rightImg(:,:,1);
rightImg(:,:,2) = remainder*rightImg(:,:,2);
rightImg(:,:,3) = remainder*rightImg(:,:,3);

% Concat
outImg = [leftImg middleImg rightImg];

end

