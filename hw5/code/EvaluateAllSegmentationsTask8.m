% Quantitatively evaluate a segmentation method by comparing its computed
% segments against ground truth foreground-background segmentations.

% This loads cell arrays of string named gtNames and imageNames where
% ../imageNames{i} is the ith image and ../gtNames{i} is the ground truth
% segmentation for this image.
load('../cats.mat');

% Set the parameters for segmentation.
clusteringMethod = ["hac", "kmeans"];
normalizeFeatures = [true, false];
featureFnName = ["ComputePositionColorFeatures", "ComputeFeatures"];
Resize = [0.1, 0.3];
numClusters = [3, 4];

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

for nc = 1:length(numClusters)
    for c = 1
%     for c = 1:length(clusteringMethod)
        for n = 1:length(normalizeFeatures)
            for f = 1:length(featureFnName)
                % Determine the amount of resize required for this image.
                for r = 1:length(Resize)
                    for i = 1:3
                        [nc c n f r i]
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
                        % Some array index error happens. So apply try
                        % catch
                        try
                            segments = ComputeSegmentation(img, numClusters(nc), ...
                            clusteringMethod(c), str2func(featureFnName(f)), ...
                            normalizeFeatures(n), Resize(r));
                            % Evaluate the segmentation.
                            if chooseSegmentsManually
                                mask = ChooseSegments(segments);
                                accuracy = EvaluateSegmentation(maskGt, mask);
                            else
                                accuracy = EvaluateSegmentation(maskGt, segments);
                            end
                            fprintf('Accuracy for %s is %.4f\n', imageNames{i}, accuracy);
                            meanAccuracy = meanAccuracy + accuracy;
                        catch
                            continue
                        end
                    end
%                     meanAccuracy = meanAccuracy / length(imageNames);
                    meanAccuracy = meanAccuracy / 3;
                    fprintf('%s\t%d\t%s\t%d\t%.2f\t%.4f\n', ...
                        featureFnName(f), normalizeFeatures(n), ...
                        clusteringMethod(c), numClusters(nc), ...
                        Resize(r), meanAccuracy);
                    Feature_Transform = [Feature_Transform; featureFnName(f)];
                    Feature_Normalization = [Feature_Normalization; normalizeFeatures(n)];
                    Clustering_Method = [Clustering_Method; clusteringMethod(c)];
                    Number_Of_Cluster = [Number_Of_Cluster; numClusters(nc)];
                    Re_Size = [Re_Size; Resize(r)];
                    Mean_Accuracy = [Mean_Accuracy; meanAccuracy];
                end
            end
        end
    end
end
mltable = table(Feature_Transform, Feature_Normalization, ...
    Clustering_Method, Number_Of_Cluster, Re_Size, Mean_Accuracy)

