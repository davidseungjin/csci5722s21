% Simple script to run ComputeSegmentation.
% Many for loops are negligible. Just because it was
% originated from the function for Task6.

% Assign image folder
imgfiles = dir('../imgs/');
savepath2 = '../task7_img/';
backgroundImg = ["../imgs/backgrounds/beach.jpg", ...
        "../imgs/backgrounds/desert.jpg", ...
        "../imgs/backgrounds/grass.jpg"];
background = imread(backgroundImg(3));

% Pick index i depending on which file in imgfiles you want to transfer
% segments
for i = 8
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
    for k = 2
        % choose one of two by c. 1 for 'kmeans', 2 for 'hac'
        for c = 1
            % Choose featureFN by f.
            for f = 1
                featureFunction = str2func(featureFnName(f));
                % Normalize or Not by n. 1 for True, 2 for False
                for n = 1
                    % resize factor
                    for resize = 0.4
                        
                        segments = ComputeSegmentation(img, ...
                            k, clusteringMethod(c), featureFunction, ...
                               normalizeFeatures(n), resize);
                        
                       [mask, simg] = ChooseSegments(segments, background);
                        imshow(simg);
                    end
                end
            end
        end
    end
end