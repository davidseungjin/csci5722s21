% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [] = displayAll(img1, img2, img3)
% Display two images on first row and one image on second row.

% Init figure
figure

% Display the last image on first row
subplot(2,2,1:2); 
imagesc(img3);

% Display the first two images on second row
subplot(2,2,3); 
imagesc(img1);
subplot(2,2,4); 
imagesc(img2);

end

