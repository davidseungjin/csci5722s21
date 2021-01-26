% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = binaryMask(inImg)
% Sets each pixel value to either RGB(0,0,0) or RGB(255,255,255), depending
% on whether or not the existing pixel value is greater than or less than
% the mean pixel value.

meansAcrossColumns = mean(inImg);
meanValue = mean(meansAcrossColumns);

outImg = inImg;
outImg(inImg > meanValue) = 0;
outImg(inImg <= meanValue) = intmax(class(inImg));

end

