function featuresNorm = NormalizeFeatures(features)
% Normalize image features to have zero mean and unit variance. This
% normalization can cause k-means clustering to perform better.
%
% INPUTS
% features - An array of features for an image. features(i, j, :) is the
%            feature vector for the pixel img(i, j, :) of the original
%            image.
%
% OUTPUTS
% featuresNorm - An array of the same shape as features where each feature
%                has been normalized to have zero mean and unit variance.

    features = double(features);

% Suggestion: Vectorization
% Finding mean/std values at each features (each page)
    meanVector = mean(features, [1 2]);
    stdVector = std(features, 0, [1 2]);
    featuresNorm = (features - meanVector) ./ stdVector;

%     featuresNorm = features;        
%     for i=1:size(featuresNorm,3)
%         matrix = featuresNorm(:,:,i);
%         vector = reshape(transpose(matrix),[],1);
%         avg = mean(vector);
%         var = std(vector);
%         featuresNorm(:,:,i) = (featuresNorm(:,:,i) - avg) / var;
%     end
end