function [outImg] = D_binaryMask(inImg)
% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

% mychannel should be 1 because input image is gray scale.
myinput = imread(inImg);

% declare and initialize array having same dimension
outImg = myinput

% Conditional value assign.
outImg(myinput > intmax(class(myinput))/2) = 0;
outImg(myinput <= intmax(class(myinput))/2) = intmax(class(myinput));

[filepath, name, ext] = fileparts(inImg);
newfilepathname = strcat(filepath, name,'_binaryMask',ext)

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 8')