% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [points] = getPoints(img1, img2)

NUM_POINTS = 10;

figure
subplot(1,2,1)
imagesc(img1);
res1 = ginput(NUM_POINTS);
subplot(1,2,2)
imagesc(img2);
res2 = ginput(NUM_POINTS);
points = [res1 res2];

end

