function features = ComputeFeatures(img)
% Compute a feature vector for all pixels of an image. You can use this
% function as a starting point to implement your own custom feature
% vectors.
%
% INPUT
% img - Array of image data of size h x w x 3.
%
% OUTPUT
% features - Array of computed features for all pixels of size h x w x f
%            such that features(i, j, :) is the feature vector (of
%            dimension f) for the pixel img(i, j, :).

    height = size(img, 1);
    width = size(img, 2);
    features = zeros(height, width, 6);
    
    % Convert img to grayscale for extracting additional features.
    gs = im2gray(img);
    
    % Compute edges using Canny method.
    % This may help bring outliers sticking out of an area of the image
    % into the correct cluster (i.e. hairs sticking out on a cat).
    edges = edge(gs,'Canny');
    
    % Compute directional gradients using prewitt method.
    % This may help cluster together areas of similar texture, since more
    % textured surfaces in an image will have more changes in direction
    % (i.e. gravel) whereas less textured surfaces will have less changes
    % in direction (i.e. a flat white wall).
    gradients = imgradient(gs, 'prewitt');
    
    % Vector implementation.
    features(:,:,1:3) = img;
    colVal = (1:width);
    features(:,:,4) = repmat(colVal, height, 1);
    
    rowVal = (1:height)';
    features(:,:,5) = repmat(rowVal, 1, width);
    
    features(:,:,6) = edges;
    
%     
%     for i=1:height
%         for j=1:width
%             features(i,j,1) = img(i,j,1);
%             features(i,j,2) = img(i,j,2);
%             features(i,j,3) = img(i,j,3);
%             features(i,j,4) = j;
%             features(i,j,5) = i;
%             features(i,j,6) = edges(i,j);
%             %features(i,j,7) = gradients(i,j);
%         end
%     end
end