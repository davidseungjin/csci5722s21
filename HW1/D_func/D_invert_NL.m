function [outImg] = D_invert_NL(inImg)
% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);

% declare and initialize array having same dimension
outImg = zeros(myrow, mycol,mychannel, class(myinput));

% Loop to assign new value after processing original pixel value.
% resulting value will be 255 - original value
outImg = intmax(class(myinput)) - myinput;

[filepath, name, ext] = fileparts(inImg);
% filepath = './test/'
newfilepathname = strcat(filepath, name,'_inverted_NL',ext)

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 4')