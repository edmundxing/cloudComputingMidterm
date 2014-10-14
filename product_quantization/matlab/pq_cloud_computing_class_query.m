% pq retrieval for cloud computing class
function queryImages = pq_cloud_computing_class_query(featID, queryImages, resultBaseDir, k, m)
%featID = 2;
if nargin < 5
    m = 10;
end
if nargin < 4
    k = 5; % nearest neighbors to be returned
end

pqDBPath = sprintf('pqDB_%d.mat', featID);
if ~exist(pqDBPath, 'file')
    pq_cloud_computing_class_build(featID);
end
load(pqDBPath, 'pqDB');

pq = pqDB.pq;
cbase = pqDB.cbase;
imgPath = pqDB.imgPath;
imgLabel = pqDB.imgLabel;
featData = pqDB.featData;
n = size(featData, 2);
%%
if isempty(queryImages)
    fprintf('%d query images are randomly select. \n', m)
    queryID = randperm(n, m);
    queryImages = cell(m, 1);
else
    m = length(queryImages);
    queryID = zeros(1, m);
    for i = 1:m
        for j = 1:n
            if strcmp(queryImages{i}, imgPath{j})
                queryID(i) = j;
                break;
            end
        end
    end
end

for i = 1:length(queryID)
    imgID = queryID(i);
    if ~exist(imgPath{imgID}, 'file')
        warning('Sorry, the image path does not exist! \n ');
    end
    if imgLabel(imgID) == 1
        fprintf('query image %d (adeno):', imgID)
    else
        fprintf('query image %d (squma):', imgID)
    end
    
    if imgLabel(imgID) == 1 % adeno
        resultPath = [resultBaseDir '\adeno'];
    else
        resultPath = [resultBaseDir '\squma'];
    end
    if ~exist(resultPath, 'dir')
        mkdir(resultPath);
    end
    
    [~, queryName, ext] = fileparts(imgPath{imgID});
    copyfile(imgPath{imgID}, [resultPath '\' queryName '.' ext]);
    queryImages{i} = imgPath{imgID};
    
    queryResultDir = [resultPath '\' queryName];
    if ~exist(queryResultDir, 'dir')
        mkdir(queryResultDir);
    end
    vquery = featData(:, imgID);
    [ids_pqc, dis_pqc] = pq_search (pq, cbase, vquery, k+1);
    for j = 1:length(ids_pqc)
        imgID = ids_pqc(j);
        [~, resultName, ext] = fileparts(imgPath{imgID});
        rankID = sprintf('%d', j-1);
        if imgLabel(imgID) == 1
            fprintf('%d (a)  ', imgID)
        else
            fprintf('%d (s)  ', imgID)
        end
        if ~exist(imgPath{imgID}, 'file')
            warning('Sorry, the image path does not exist!');
            continue;
        end
        if imgLabel(imgID) == 1
            copyfile(imgPath{imgID}, [queryResultDir '\' rankID '_' resultName '(a)' ext]);
        else
            copyfile(imgPath{imgID}, [queryResultDir '\' rankID '_' resultName '(s)' ext]);
        end
    end
    fprintf('\n')
end


