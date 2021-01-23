function [outImg] = D_luminance_NL(inImg)
% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);

% declare and initialize array having same dimension in 2D, which means channel size is 1
% Don't forget data type.
outImg = zeros(myrow, mycol, 1, class(myinput));

% Loop to assign new value after processing original pixel value.
% resulting value will be 255 - original value.
outImg = 0.299 * myinput(:,:,1) + 0.587 * myinput(:,:,2) + 0.114 * myinput(:,:,3)

[filepath, name, ext] = fileparts(inImg);
% filepath = './test/'
newfilepathname = strcat(filepath, name,'_luminance_NL',ext)

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 6')