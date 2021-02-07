% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [points] = setFrame(img1, img2)
% Finds the 4 coordinates in img1 to put img2 into

NUM_POINTS = 4;

% Get the four corners in img1
figure
subplot(1,1,1);
title('click four corners with clockwise direction from the top-left')
imagesc(img1);
res1 = ginput(NUM_POINTS);

% Grabs the four corners of img2 to set as the corresponding points
[img2NumRows, img2NumColumns, ~] = size(img2);
res2 = [1, 1; img2NumColumns, 1; img2NumColumns, img2NumRows; 1, img2NumRows];

% Concat results
points = [res1 res2];

end

