% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [points] = getPoints(img1, img2)

NUM_POINTS = 4;

figure
subplot(1,1,1);
title('click four corners with clockwise direction from the top-left')
imagesc(img1);
res1 = ginput(NUM_POINTS);

[img2NumRows, img2NumColumns, ~] = size(img2);
res2 = [1, 1; img2NumColumns, 1; img2NumColumns, img2NumRows; 1, img2NumRows];
% subplot(1,2,2)
% imagesc(img2);
% res2 = ginput(NUM_POINTS);

points = [res1 res2];

end

