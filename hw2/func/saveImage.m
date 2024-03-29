% Names: Alec Bell, David Lee
% Course #: CSCI 5722
% Assignment #: 1
% Instructor: Fleming

function [] = saveImage(img)
% Saves img to corresponding fileName

answer = inputdlg('Enter a file name to save the new image:', ...
   'Save Image', 1, {'results/myimage.jpg'});
if ~isempty(answer)
    imwrite(img, answer{1});
end

end

