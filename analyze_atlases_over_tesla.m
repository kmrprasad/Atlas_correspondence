%% Set up samples
hardCodedSampleSize = 30; %thirty subjects per group
Bnaught = [1.5; 3; 7]; %the MRI field strengths

% these are the directories where the 30 data sets are:
data_1T='/Path/to/1.5T/data';
data_3T='/Path/to/3T/data';
data_7T='/Path/to/7T/data';
%concatenate
directories = {data_1T,data_3T,data_7T};

%% Analysis of DKT and Glasser Atlases
% Set up atlas keys
ref_LUT_file='/Path/to/labels/FreeSurferLabels_DKT.mat';
load(ref_LUT_file)
DKT_LUT=Freesurferlabelnames(22:end,:);
DKT_labels = [DKT_LUT{:,2}]';
DKT_values=cell2mat(DKT_LUT(:,1));
sizeDKT=length(DKT_labels);
clear Freesurferlabelnames

tar_LUT_file='/Path/to/labels/FreeSurferLabels_HCP.mat';
load(tar_LUT_file)
HCP_LUT=Freesurferlabelnames(22:end,:);
HCP_labels = [HCP_LUT{:,2}]';
HCP_values=cell2mat(HCP_LUT(:,1));
sizeHCP=length(HCP_labels);
clear Freesurferlabelnames

%% loop and gather data

numberFields = length(Bnaught);
hardCodedSampleSize;

DKT_as_HCP = zeros(sizeDKT,sizeHCP,hardCodedSampleSize,numberFields);
HCP_as_DKT = zeros(sizeHCP,sizeDKT,hardCodedSampleSize,numberFields);

for T = 1:numberFields
    message=sprintf('Beginning Group: %0.1f', Bnaught(T));
    disp(message);
    disp(datetime);

    fieldStrength = Bnaught(T); 
    data_dir = directories{T};
    
    folder_pattern = sprintf('%s/sub-*/',data_dir);
    fstruct    = dir(folder_pattern);
    folders = unique({fstruct.folder})';
    subjects = erase(folders,data_dir);subjects=erase(subjects,'/');
    subjects_ids = erase(subjects,'sub-'); subjects_ids=str2double(subjects_ids);
   
    for H=1:hardCodedSampleSize
        message=sprintf('Subject: %i/%i',H,hardCodedSampleSize);
        disp(message);
        
        HCP_file = sprintf('%s/%s/%s_HCP.nii.gz',data_dir,subjects{H},subjects{H});
        DKT_file = sprintf('%s/%s/%s_DKT.nii.gz',data_dir,subjects{H},subjects{H});

        HCP_atlas_subject_data = niftiread(HCP_file);
        DKT_atlas_subject_data = niftiread(DKT_file);
        
        % now find overlap given directionality
        for d=1:sizeDKT
            message=sprintf('DKT Region: %i/%i',d,sizeDKT);
            disp(message)
            for p=1:sizeHCP
                 ixHCPregion = find(HCP_atlas_subject_data==HCP_values(p));
                 numberDKToverlap = numel(find(DKT_atlas_subject_data(ixHCPregion)==DKT_values(d)));
                 percentHCPregion_thatsDKT = numberDKToverlap/numel(ixHCPregion);

                 ixDKTregion = find(DKT_atlas_subject_data==DKT_values(d));
                 numberHCPoverlap = numel(find(HCP_atlas_subject_data(ixDKTregion)==HCP_values(p)));
                 percentDKTregion_thatsHCP = numberHCPoverlap/numel(ixDKTregion);

                 DKT_as_HCP(d,p,H,T) = percentDKTregion_thatsHCP;
                 HCP_as_DKT(p,d,H,T) = percentHCPregion_thatsDKT;
            end
        end
        %optional subejct level checks:
        %figure; imagesc(DKT_as_HCP(:,:,H,T));
        %figure; imagesc(HCP_as_DKT(:,:,H,T));
        %sum(DKT_as_HCP(:,:,H,T),2); %the column sums should be close to 1
        %sum(HCP_as_DKT(:,:,H,T),2); %the column sums should be close to 1
    end
end

%% save

save_file_location = '/Path/to/outputs/atlas_overlap_data.mat';

save(save_file_location,'DKT_as_HCP','HCP_as_DKT',...
'DKT_labels','HCP_labels','Bnaught',...
'hardCodedSampleSize','sizeHCP','sizeDKT','numberFields');

%% Analysis of DKT and Schaefer Atlases

% Set up atlas keys
ref_LUT_file='/Path/to/labels/atlas_keys/FreeSurferLabels_DKT.mat';
load(ref_LUT_file)
DKT_LUT=Freesurferlabelnames(22:end,:); %Remove subcortical
DKT_labels = [DKT_LUT{:,2}]';
DKT_values=cell2mat(DKT_LUT(:,1));
sizeDKT=length(DKT_labels);
clear Freesurferlabelnames

tar_LUT_file='/Path/to/labels/FreeSurferLabels_Schaefer.mat';
load(tar_LUT_file)
Schaef_LUT=Freesurferlabelnames;
Schaef_labels = [Schaef_LUT{:,2}]';
Schaef_values=cell2mat(Schaef_LUT(:,1));
sizeSchaef=length(Schaef_labels);
clear Freesurferlabelnames

%% loop and gather data

numberFields = length(Bnaught);
hardCodedSampleSize;

DKT_as_Schaef = zeros(sizeDKT,sizeSchaef,hardCodedSampleSize,numberFields);
Schaef_as_DKT = zeros(sizeSchaef,sizeDKT,hardCodedSampleSize,numberFields);

for T = 1:numberFields
    message=sprintf('Beginning Group: %0.1f', Bnaught(T));
    disp(message);
    disp(datetime);

    fieldStrength = Bnaught(T); 
    data_dir = directories{T};
    
    folder_pattern = sprintf('%s/sub-*/',data_dir);
    fstruct    = dir(folder_pattern);
    folders = unique({fstruct.folder})';
    subjects = erase(folders,data_dir);subjects=erase(subjects,'/');
    subjects_ids = erase(subjects,'sub-'); subjects_ids=str2double(subjects_ids);
   
    for H=1:hardCodedSampleSize
        message=sprintf('Subject: %i/%i',H,hardCodedSampleSize);
        disp(message);
        
        Schaef_file = sprintf('%s/%s/%s_Schaefer.nii.gz',data_dir,subjects{H},subjects{H});
        DKT_file = sprintf('%s/%s/%s_DKT.nii.gz',data_dir,subjects{H},subjects{H});

        Schaef_atlas_subject_data = niftiread(Schaef_file);
        DKT_atlas_subject_data = niftiread(DKT_file);
        
        % now find overlap given directionality
        for d=1:sizeDKT
            message=sprintf('DKT Region: %i/%i',d,sizeDKT);
            disp(message)
            for p=1:sizeSchaef
                 ixSchaefregion = find(Schaef_atlas_subject_data==Schaef_values(p));
                 numberDKToverlap = numel(find(DKT_atlas_subject_data(ixSchaefregion)==DKT_values(d)));
                 percentSchaefregion_thatsDKT = numberDKToverlap/numel(ixSchaefregion);

                 ixDKTregion = find(DKT_atlas_subject_data==DKT_values(d));
                 numberSchaefoverlap = numel(find(Schaef_atlas_subject_data(ixDKTregion)==Schaef_values(p)));
                 percentDKTregion_thatsSchaef = numberSchaefoverlap/numel(ixDKTregion);

                 DKT_as_Schaef(d,p,H,T) = percentDKTregion_thatsSchaef;
                 Schaef_as_DKT(p,d,H,T) = percentSchaefregion_thatsDKT;
            end
        end
        %optional subejct level checks:
        %figure; imagesc(DKT_as_Schaef(:,:,H,T));
        %figure; imagesc(Schaef_as_DKT(:,:,H,T));
        %sum(DKT_as_Schaef(:,:,H,T),2); %the column sums should be close to 1
        %sum(Schaef_as_DKT(:,:,H,T),2); %the column sums should be close to 1
    end
end

%% save

save_file_location = '/Path/to/outputs/atlas_overlap_data_Schaef_DKT.mat';

save(save_file_location,'DKT_as_Schaef','Schaef_as_DKT',...
'DKT_labels','Schaef_labels','Bnaught',...
'hardCodedSampleSize','sizeSchaef','sizeDKT','numberFields');

