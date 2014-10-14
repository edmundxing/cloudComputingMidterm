% pq_cloud_computing_class_test
clear all; close all; clc
featID = 2;
queryImgs = [];
resultBaseDir = 'query_examples_small_annu';
k = 5; % number of neighbors to be returned
m = 10; % number of example query images if no queryImgs specified
queryImgs = pq_cloud_computing_class_query(featID, queryImgs, resultBaseDir, k, m);
%
% featID = 1;
% %queryImgs = [];
% resultBaseDir = 'query_examples_llc';
% pq_cloud_computing_class_query(featID, queryImgs, resultBaseDir);