% Quantitatively evaluate a segmentation method by comparing its computed
% segments against ground truth foreground-background segmentations.

% This loads cell arrays of string named gtNames and imageNames where
% ../imageNames{i} is the ith image and ../gtNames{i} is the ground truth
% segmentation for this image.
load('../cats.mat');

% Set the parameters for segmentation.
clusteringMethod = ["kmeans", "hac"];
normalizeFeatures = [true, false];
featureFnName = ["ComputeColorFeatures", ...
    "ComputePositionColorFeatures", "ComputeFeatures"];

% Since the images are different sizes, we specify a maximum number of
% pixels that we want to cluster and then use this to determine the resize
% for each image.
maxPixels = 50000;

meanAccuracy = 0;

% Whether or not to manually choose the foreground segments using
% ChooseSegments.
chooseSegmentsManually = false;

Feature_Transform = [];
Feature_Normalization = [];
Clustering_Method = [];
Number_Of_Cluster = [];
Re_Size = [];
Mean_Accuracy = [];

for numClusters = 2:4:10
    for c = 1:length(clusteringMethod)
        for n = 1:length(normalizeFeatures)
            for f = 1:length(featureFnName)
                % Determine the amount of resize required for this image.
                for resize = 0.2:0.4:1.0
                    for i = 1:length(imageNames)
                        img = imread(['../' imageNames{i}]);
                        maskGt = imread(['../' gtNames{i}]);

                        % Determine the number of pixels in this image.
                        height = size(img, 1);
                        width = size(img, 2);
                        numPixels = height * width;
                        if numPixels > maxPixels
                            resize = sqrt(maxPixels / numPixels);
                        end

                        % Compute a segmentation for this image
                        segments = ComputeSegmentation(img, numClusters, ...
                            clusteringMethod(c), str2func(featureFnName(f)), ...
                            normalizeFeatures(n), resize);

                        % Evaluate the segmentation.
                        if chooseSegmentsManually
                            mask = ChooseSegments(segments);
                            accuracy = EvaluateSegmentation(maskGt, mask);
                        else
                            accuracy = EvaluateSegmentation(maskGt, segments);
                        end
                        fprintf('Accuracy for %s is %.4f\n', imageNames{i}, accuracy);
                        meanAccuracy = meanAccuracy + accuracy;
                    end
                    meanAccuracy = meanAccuracy / length(imageNames);
                    fprintf('The mean accuracy for all images is %.4f\n', ...
                        meanAccuracy);
                    Feature_Transform = [Feature_Transform; featureFn(f)];
                    Feature_Normalization = [Feature_Normalization; normalizeFeatures(n)];
                    Clustering_Method = [Clustering_Method; clusteringMethod(c)];
                    Number_Of_Cluster = [Number_Of_Cluster; numClusters];
                    Re_Size = [Re_Size; resize];
                    Mean_Accuracy = [Mean_Accuracy; meanAccuracy];
                end
            end
        end
    end
end
mltable = table(Feature_Transform, Feature_Normalization, ...
    Clustering_Method, Number_Of_Cluster, Re_Size, Mean_Accuracy)

