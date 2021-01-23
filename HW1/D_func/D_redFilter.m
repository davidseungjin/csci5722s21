function [outImg] = D_redFilter(inImg, redVal)
% declare row,col,channel (according to color or gray)
% need to check 'inImg' is object of imread or not. need to use object of
% imread. If it is already processed, I need to remove inputimage.

myinput = imread(inImg);
[myrow, mycol, mychannel] = size(myinput)

% Assign borders. In this case, not handle row and find the borders of 1/3,
% 2/3 of column.
firstend = floor(mycol/3)
secondend = floor(mycol/3 * 2)

% Direction: Making three different 3D array, and concatenate them.
% The first 1/3 named outImg1
outImg1 = zeros(myrow, firstend, mychannel, class(myinput));
outImg1(:,:,1) = 0.299 * myinput(:,1:firstend,1) + 0.587 * myinput(:,1:firstend,2) + 0.114 * myinput(:,1:firstend,3)
outImg1(:,:,2) = 0.299 * myinput(:,1:firstend,1) + 0.587 * myinput(:,1:firstend,2) + 0.114 * myinput(:,1:firstend,3)
outImg1(:,:,3) = 0.299 * myinput(:,1:firstend,1) + 0.587 * myinput(:,1:firstend,2) + 0.114 * myinput(:,1:firstend,3)

% The second 1/3 named outImg2
outImg2 = myinput(:, firstend+1:secondend,:)

% The third 1/3 named outImg3
% Additional consideration should be the adjusted weight of R/G/B depending
% on redVal.
if redVal > 1
    redVal = 1
elseif redVal < 0
    redVal = 0
end

myred = redVal
mygreen = (1-myred) / 2
myblue = (1-myred) / 2

outImg3 = zeros(myrow, mycol-secondend, mychannel, class(myinput))
outImg3(:,:,1) = myred * myinput(:,secondend+1:mycol,1) + mygreen * myinput(:,secondend+1:mycol,2) + myblue * myinput(:,secondend+1:mycol,3)
outImg3(:,:,2) = myred * myinput(:,secondend+1:mycol,1) + mygreen * myinput(:,secondend+1:mycol,2) + myblue * myinput(:,secondend+1:mycol,3)
outImg3(:,:,3) = myred * myinput(:,secondend+1:mycol,1) + mygreen * myinput(:,secondend+1:mycol,2) + myblue * myinput(:,secondend+1:mycol,3)

% Array concatenate in the direction of column.
outImg = cat(2, outImg1, outImg2, outImg3)

[filepath, name, ext] = fileparts(inImg);
% filepath = './test/'
newfilepathname = strcat(filepath, name,'_redFilter',ext)

subplot(1,2,1);
imshow(myinput);
title('inImg');
subplot(1,2,2);
imshow(outImg);
title('outImg');
imwrite(outImg, newfilepathname);
sgtitle('TASK 7')