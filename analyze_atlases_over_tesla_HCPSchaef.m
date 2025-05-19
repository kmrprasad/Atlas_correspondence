%% Analysis of Glasser and Schaefer Atlases
hardCodedSampleSize = 30; %thirty subjects per group
Bnaught = [1.5; 3; 7]; %the MRI field strengths

% these are the directories where the 30 data sets are:
data_1T='/Path/to/1.5T/data';
data_3T='/Path/to/3T/data';
data_7T='/Path/to/7T/data';
%concatenate
directories = {data_1T,data_3T,data_7T};

%% Set up atlas keys
ref_LUT_file='/Path/to/labels/FreeSurferLabels_HCP.mat';
load(ref_LUT_file)
HCP_LUT=Freesurferlabelnames(22:end,:); %Remove subcortical
HCP_labels = [HCP_LUT{:,2}]';
HCP_values=cell2mat(HCP_LUT(:,1));
sizeHCP=length(HCP_labels);
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

HCP_as_Schaef = zeros(sizeHCP,sizeSchaef,hardCodedSampleSize,numberFields);
Schaef_as_HCP = zeros(sizeSchaef,sizeHCP,hardCodedSampleSize,numberFields);

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
        HCP_file = sprintf('%s/%s/%s_HCP.nii.gz',data_dir,subjects{H},subjects{H});

        Schaef_atlas_subject_data = niftiread(Schaef_file);
        HCP_atlas_subject_data = niftiread(HCP_file);
        
        % now find overlap given directionality
        for d=1:sizeHCP
            message=sprintf('HCP Region: %i/%i',d,sizeHCP);
            disp(message)
            for p=1:sizeSchaef
                 ixSchaefregion = find(Schaef_atlas_subject_data==Schaef_values(p));
                 numberHCPoverlap = numel(find(HCP_atlas_subject_data(ixSchaefregion)==HCP_values(d)));
                 percentSchaefregion_thatsHCP = numberHCPoverlap/numel(ixSchaefregion);

                 ixHCPregion = find(HCP_atlas_subject_data==HCP_values(d));
                 numberSchaefoverlap = numel(find(Schaef_atlas_subject_data(ixHCPregion)==Schaef_values(p)));
                 percentHCPregion_thatsSchaef = numberSchaefoverlap/numel(ixHCPregion);

                 HCP_as_Schaef(d,p,H,T) = percentHCPregion_thatsSchaef;
                 Schaef_as_HCP(p,d,H,T) = percentSchaefregion_thatsHCP;
            end
        end
        %optional subejct level checks:
        %figure; imagesc(HCP_as_Schaef(:,:,H,T));
        %figure; imagesc(Schaef_as_HCP(:,:,H,T));
        %sum(HCP_as_Schaef(:,:,H,T),2); %the column sums should be close to 1
        %sum(Schaef_as_HCP(:,:,H,T),2); %the column sums should be close to 1
    end
end

%% save

save_file_location = '/Path/to/outputs/atlas_overlap_data_Schaef_HCP.mat';

save(save_file_location,'HCP_as_Schaef','Schaef_as_HCP',...
'HCP_labels','Schaef_labels','Bnaught',...
'hardCodedSampleSize','sizeSchaef','sizeHCP','numberFields');
