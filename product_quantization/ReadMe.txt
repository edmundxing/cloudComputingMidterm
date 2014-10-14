(1) introduction
This is an implementation of product quantization method for image retrieval. Please refer to 
http://people.rennes.inria.fr/Herve.Jegou/projects/ann.html for details. 
Compared with original implementation, no yale library is used in this simpler and slow version.
The major purpose of this version is to vertify all the algorithms. A mapreduce version in java language will come soon!

(2) important
This is one component of image retrieval system. No feature extraction code is provided. You should change code in build_feat_database.m
to specify the path of your own feature. 

(3) run
featID = 2;
queryImgs = []; % query images paths
m = 10; % number of example query images if no queryImgs specified
k = 5; % number of neighbors to be returned
resultBaseDir = 'query_examples_small_annu';
queryImgs = pq_cloud_computing_class_query(featID, queryImgs, resultBaseDir, k, m);