% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [outImg] = makeBright_NL(inImg, brightness)
% Adds a specified amount (brightness) to each RGB value for each pixel in
% an image.

outImg = inImg + brightness;

end