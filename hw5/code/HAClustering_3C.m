function idx = HAClustering_3C(X, k, visualize2D)
% Run the hierarchical agglomerative clustering algorithm.
% 
% The algorithm is conceptually simple:
%
% Assign each point to its own cluster
% While the number of clusters is greater than k:
%   Compute the distance between all pairs of clusters
%   Merge the pair of clusters that are closest to each other
%
% There are many valid ways of determaxing the distance between two
% clusters. For this assignment we will define the distance between two
% clusters to be the average-link inter-cluster distance.
%
% INPUTS
% X - An array of size m x n containing the points to cluster. Each row is
%     an n-dimensional point, so X(i, :) gives the coordinates of the ith
%     point.
% k - The number of clusters to compute.
% visualize2D - OPTIONAL parameter telling whether or not to visualize the
%               progress of the algorithm for 2D data. If not set then 2D
%               data will not be visualized.
%
% OUTPUTS
% idx     - The assignments of points to clusters. idx(i) = c means that the
%           point X(i, :) has been assigned to cluster c.

    if nargin < 3
        visualize2D = false;
    end

    if ~isa(X, 'double')
        X = double(X);
    end

    % The number of points to cluster.
    m = size(X, 1);
        
    % The dimension of each point.
    n = size(X, 2);
    
    % The number of clusters that we currently have.
    num_clusters = m;
    
    % The assignment of points to clusters. If idx(i) = c then X(i, :) is
    % assigned to cluster c. Since each point is initally assigned to its
    % own cluster, we initialize idx to the column vector [1; 2; ...; m].
    idx = (1:m)';

    % The number of points in each cluster. If cluster_sizes(c) = n then
    % cluster c contains n points. Since each point is initially assigned
    % to its own cluster, each cluster size is initialized to 1.
    cluster_sizes = ones(m, 1);
    
    % The average-link distances between all of the clusters. Initially,
    % it's the same as using the centroid method since each cluster only
    % has one element.
    dists = squareform(pdist(X));
    dists = dists + diag(Inf(m, 1));
    
    % If we are going to display the clusters graphically then create a
    % figure in which to draw the visualization.
    figHandle = [];
    if n == 2 && visualize2D
        figHandle = figure;
    end
    
    
    % In the 2D case we can easily visualize the starting points.
    if n == 2 && visualize2D          
        VisualizeClusters2D(X, idx, [], figHandle);
        pause;
    end
    
    while num_clusters > k
        
        
        % Find the pair of clusters that are closest together by average-link.
        % Set i and j to be the indices of the nearest pair of clusters.
        min_dist = min(min(dists));
        [i,j] = find(dists==min_dist, 1);
        
        % Make sure that i < j
        if i > j        
            t = i;
            i = j;
            j = t;
        end
                
        % Next we need to merge cluster j into cluster i.
        %
        % We also need to 'delete' cluster j. We will do this by setting
        % its cluster size to 0 and setting the average-link distance
        % between it and all other clusters to +Inf.
        
        % Assign all points currently in cluster j to cluster i.    
        idx(idx==j) = i;
        
        % Update the size of clusters i and j.
        cluster_sizes(j) = 0;
        cluster_sizes(i) = size(idx(idx==i), 1);
                   
        % Update the dists array using the maximum distance between points
        % of each cluster (average-link method).
        cluster_i = X(idx(idx==i),:);
        for a=1:m
            cluster = X(idx==a,:);
            if a == i || size(cluster,1) == 0
                continue
            end
            sum = 0;
            for b=1:size(cluster_i,1)
                for c=1:size(cluster,1)
                    sum = sum + pdist2(cluster_i(b,:), cluster(c,:));
                end
            end
            avg = sum / size(cluster_i,1)*size(cluster,1);
            dists(i,a) = avg;
            dists(a,i) = avg;
        end
        dists(i,i) = Inf;
        
        dists(j,:) = Inf(1,m);
        dists(:,j) = Inf(1,m);
        
        % If everything worked correctly then we have one less cluster.
        num_clusters = num_clusters - 1;
        
        % In the 2D case we can easily visualize the clusters.
        if n == 2 && visualize2D          
            VisualizeClusters2D(X, idx, [], figHandle);
            pause;
        end
        
    end
    
    % Now we need to reindex the clusters from 1 to k
    idx = ReindexClusters(idx);
end