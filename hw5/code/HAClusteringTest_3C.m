function HAClusteringTest_3C(visualize)
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
    my_idx = HAClustering_3C(X, k, visualize);
end