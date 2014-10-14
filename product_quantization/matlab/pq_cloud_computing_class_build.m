% pq retrieval for cloud computing class
function pq_cloud_computing_class_build(featID, nsq)
if nargin < 2
    nsq = 8;
end
%% load and organize feature data
%featID = 1; % 1 for llc, 2 for small_annu
featDBPath = sprintf('featDB_%d.mat', featID);
if exist(featDBPath, 'file')
    load(featDBPath, 'featDB')
else
    build_feat_database(featID);
    load(featDBPath, 'featDB')
end

vtrain = single(featDB.featData);
vbase = vtrain;
%% build pq dictionary using training data and build pq reresentation (code) for base data
%nsq = 8; % num of groups
pq = pq_new (nsq, vtrain);
cbase = pq_assign (pq, vbase);
pqDB = [];
pqDB.pq = pq;
pqDB.cbase = cbase;
pqDB.imgPath = featDB.imgPath;
pqDB.imgLabel = featDB.imgLabel;
pqDB.featData = featDB.featData;
pqDBPath = sprintf('pqDB_%d.mat', featID);
save(pqDBPath, 'pqDB', '-v7.3');

