% Author: Manish Sapkota
% Copyright: MedIA Group BICI2 lab
% Convert the mat lab features to feature file to be usable for map-reduce
% Read all the files from the folder including foldername
% write all the features with filename as first element
clear all;clc;
root='features';
d = dir(root);
isub = [d(:).isdir]; %# returns logical vector
nameFolds = {d(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];
fileID = fopen('features/llc.txt','a');
for jj=1:length(nameFolds)
    flist=dir([root '/' nameFolds{jj} '/*.mat']);
    disp(nameFolds{jj});
    for ii=1:length(flist)
        [pathstr,name,ext] = fileparts(flist(ii).name) ;
        load([root '/' nameFolds{jj} '/' flist(ii).name]); % load files in workspace
        str= mat2str(fea',3);
        str=str(2:(length(str)-2));
        fprintf(fileID,'%s %s\n',name,str);
        disp(name);
     end
end
% will give you list of specifed files
fclose(fileID);