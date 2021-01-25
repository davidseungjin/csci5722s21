function [] = displaySideBySide(img1, img2, imgPlotFunction)

% Display both images side by side.

if nargin < 3
    imgPlotFunction = @(img) imagesc(img);
end

figure
subplot(1,2,1)
imgPlotFunction(img1);
subplot(1,2,2)
imgPlotFunction(img2);

end

