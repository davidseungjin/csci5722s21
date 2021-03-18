% Simple script to run ComputeSegmentation.

% Assign image folder
imgfiles = dir('../imgs/');
savepath = '../task6_img/';
% Other than feature function to pass and name to use as fig name,
% everything is okay to use in function because data type is int or string.

for i = 10:length(imgfiles)
    i
    % if component is dir, skip loop.
    if imgfiles(i).isdir
        continue
    end
    % Read each file of the folder
    filename = imgfiles(i).name;
    filepath = strcat('../imgs/', filename)
    [path, filenameOnly, fileExt] = fileparts(filepath);
    img = imread(filepath);
    
    normalizeFeatures = [true, false];
    featureFnName = ["ComputeColorFeatures", "ComputePositionColorFeatures", "ComputeFeatures"];
    clusteringMethod = ["kmeans", "hac"];
    
    % Choose the number of clusters and the clustering method.
    for k = 2:4
        % choose one of two 'kmeans', 'hac'
        for c = 1:1
            % Choose featureFN
            for f = 1: length(featureFnName)
                featureFunction = str2func(featureFnName(f));
                % Normalize or Not
                for n = 1: length(normalizeFeatures)
                    % resize factor
                    for resize = 0.2
                        segments = ComputeSegmentation(img, ...
                            k, clusteringMethod(c), featureFunction, ...
                               normalizeFeatures(n), resize);
                        
                        % Show the computed segments in two different ways.
                        % Also need to store segments image.
                        head = strcat(savepath, filenameOnly, '_');
                        tail = strcat('_', num2str(k), ...
                                    '_', convertStringsToChars(clusteringMethod(c)), ...
                                    '_', convertStringsToChars(featureFnName(f)), ...
                                    '_', num2str(normalizeFeatures(n)), ...
                                    '_', num2str(resize), ...
                                    fileExt);        
                        
                        filepathSegment = strcat(head, 'Segment',tail);
                        filepathMean = strcat(head, 'Mean',tail);
                                
                        ShowSegmentsD(img, segments,filepathSegment);
%                         ShowMeanColorImageD(img, segments, filepathMean);
                    end
                end
            end
        end
    end
end