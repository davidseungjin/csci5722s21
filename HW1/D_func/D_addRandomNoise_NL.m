function [outImg] = D_addRandomNoise_NL(inImg)
% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);

% declare and initialize array having random numbers in the range [-255, 255] with the same dimension
myrandom = randi([-255, 255], myrow, mycol, mychannel, class(myinput))

% Question: if uint8 is 0~255, is that any meaning to assign 
% randi [-255, 255] ? In fact, it will apply [0, 255] because of the data type

% Loop to assign new value after processing original pixel value.
% resulting value will be 255 - original value.
outImg = myinput + myrandom;

[filepath, name, ext] = fileparts(inImg);
% filepath = './test/'
newfilepathname = strcat(filepath, name,'_addRandomNoise_NL',ext)

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 5')
