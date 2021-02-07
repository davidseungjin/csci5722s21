% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [points] = getPoints(img1, img2)

% Constant for the number of points we're collecting
NUM_POINTS = 10;

figure

% Grab points from first image
subplot(1,2,1)
imagesc(img1);
res1 = ginput(NUM_POINTS);

% Grab points from second image
subplot(1,2,2)
imagesc(img2);
res2 = ginput(NUM_POINTS);

% Return concatenated result
points = [res1 res2];

end

