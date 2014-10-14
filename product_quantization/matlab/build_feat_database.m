% prepare feature data
function build_feat_database(featID)
    % 1 for adeno, 2 for squam
    img_base_path = 'C:\Data\lung_data\small\img\all';
    switch featID
        case 1
            % use llc_feature
            feat_path = 'C:\Data\lung_data\small\feature\features-LLC\all';% put llc feature dir
            d = 21504;
            feat_files = dir([feat_path '\*.mat']);
            n = length(feat_files);
            featData = zeros(d, n); 
            imgPath = cell(n, 1);
            imgLabel = zeros(n, 1);
            for i = 1:n
                fn = feat_files(i).name;
                imgName = fn(1:end-4);
                imgPath{i} = [img_base_path '\' imgName '.tif'];
                
                load([feat_path '\' fn], 'fea', 'label');
                imgLabel(i) = label;
                featData(:, i) = fea(:);
            end
            featDB = [];
            featDB.featData = featData;
            featDB.imgPath = imgPath;
            featDB.imgLabel = imgLabel;
            save('featDB_1.mat', 'featDB', '-v7.3');
        case 2
            % use small_annu
            build_feat_database_2(img_base_path);
        otherwise
            error('not defined, please check the feature')
    end
end

function build_feat_database_2(img_base_path)
            d = 240;
            feat_path_1 = 'C:\Data\lung_data\small\feature\features-small-annu\adeno_small_annuFeature'; % your feature folder here
            feat_files_1 = dir([feat_path_1 '\*.mat']);
            n1 = length(feat_files_1);
            
            feat_path_2 = 'C:\Data\lung_data\small\feature\features-small-annu\squamous_small_annuFeature';% your feature folder here
            feat_files_2 = dir([feat_path_2 '\*.mat']);
            n2 = length(feat_files_2);
            
            n = n1 + n2;
            featData = zeros(d, n); 
            imgPath = cell(n, 1);
            imgLabel = zeros(n, 1);
            for i = 1:n
                if i <= n1
                    fn = feat_files_1(i).name;
                    load([feat_path_1 '\' fn], 'QueryHistMatrixNorm');
                    imgLabel(i) = 1;
                else
                    fn = feat_files_2(i-n1).name;
                    load([feat_path_2 '\' fn], 'QueryHistMatrixNorm');
                    imgLabel(i) = 2;
                end
                imgName = fn(1:end-4);
                imgPath{i} = [img_base_path '\' imgName];
                featData(:, i) = QueryHistMatrixNorm(:);
            end
            featDB = [];
            featDB.featData = featData;
            featDB.imgPath = imgPath;
            featDB.imgLabel = imgLabel;
            save('featDB_2.mat', 'featDB', '-v7.3');
end