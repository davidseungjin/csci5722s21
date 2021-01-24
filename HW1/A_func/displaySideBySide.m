function [] = displaySideBySide(img1, img2, colorMap)

% Display both images side by side.

figure
subplot(1,2,1)
imshow(img1);
subplot(1,2,2)
if nargin > 2 % optional parameter for when we want the output to use a gray colormap
    colormap(colorMap);
end
imshow(img2);

end

