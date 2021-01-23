function [outImg] = D_makeBright_NL(inImg, brightness)
% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.
% inImg = 'lena1.jpg';
% brightness = 50;

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput);

% declare and initialize array having same dimension. Don't forget the data
% type
outImg = zeros(myrow, mycol,mychannel, class(myinput));

% Need to put condition or adjust value if brightness < -255 or > 255.
% The one option is to use while-loop until it meet the range.
% For this Task, I'll choose the other option. If brightness is over 255,
% it will be 255. Likewise, it will be -255 if brightness is less than -255
if brightness > 255
    brightness = 255;
elseif brightness < -255
    brightness = -255;
end

% No Loop: vector arithmatic.
            outImg = myinput + brightness;

[filepath, name, ext] = fileparts(inImg);
% filepath = './test/'
newfilepathname = strcat(filepath, name,'_brightness_', int2str(brightness),'_NL',ext)

subplot(1,2,1);
imshow(myinput);
title('Task2: inImg');
subplot(1,2,2);
imshow(outImg);
title('Task2: outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 2')