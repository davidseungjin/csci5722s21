function HAClusteringTest_3A(visualize)
% Tests your implementation of HAClustering.m by comparing its output on a
% test dataset with the output of our reference implementation on the same
% dataset.
%
% INPUT
% visualize - Whether or not to visualize each step of the clustering
%             algorithm. Optional; default is true.

    if nargin < 1
        visualize = true;
    end
    load('test_data/HAClusteringTest.mat');
    % Select a random subset from X of 20 points to make the data more
    % sparse to better see the results of this algorithm.
    subset_X = X(randperm(30),:);
    my_idx = HAClustering_3A(subset_X, k, visualize);
end