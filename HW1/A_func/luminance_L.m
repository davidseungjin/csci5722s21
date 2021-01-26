% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = luminance_L(inImg)
% Uses the weighted method for calculating luminance in order to convert
% the image to grayscale.

outImg = 0.299*inImg(:,:,1) + 0.587*inImg(:,:,2) + 0.114*inImg(:,:,3);

end

