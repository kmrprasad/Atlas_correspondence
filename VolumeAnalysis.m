%% Measure coefficient of variation
%% 7T Analysis
data_loc='/Data/location';
study_name='STUDYNAME';
subject_list=readcell([ data_loc '/' study_name '/sublist.txt']);
output=([ data_loc '/' study_name '/data/AtlasCorr_HCP_DKT/']);
%Volume
load([output 'Voumes_STUDYNAME_.mat'])
%Size of voxels
s=1;
subject=char(subject_list(s,1));

%DKT
nr_D_7=niftiinfo([ data_loc '/' study_name '/data/' subject '/' subject '_DKT.nii.gz']);
vox_size_D7=nr_D_7.PixelDimensions;
vox_vol_D7=vox_size_D7(1)*vox_size_D7(2)*vox_size_D7(3);
%HCP
nr_H_7=niftiinfo([ data_loc '/' study_name '/data/' subject '/' subject '_HCP.nii.gz']);
vox_size_H7=nr_H_7.PixelDimensions;
vox_vol_H7=vox_size_H7(1)*vox_size_H7(2)*vox_size_H7(3);

if vox_vol_D7 == vox_vol_H7
    vol_dkt7=ref_voxels.*vox_vol_D7;
    avg_vol_DKT(:,1)=mean(vol_dkt7, 2);
    std_vol_DKT(:,1)=std(vol_dkt7,0,2);
    cov_dkt(:,1)=std_vol_DKT(:,1)./avg_vol_DKT(:,1);
    
    vol_hcp7=tar_voxels.*vox_vol_H7;
    avg_vol_HCP(:,1)=mean(vol_hcp7, 2);
    std_vol_HCP(:,1)=std(vol_hcp7,0,2);
    cov_hcp(:,1)=std_vol_HCP(:,1)./avg_vol_HCP(:,1);
else
    disp('Voxel Sizes Not Consistent')
end

for r=1:size(per_ref_roi,3)
    avg_per_ref7(:,r)=mean(per_ref_roi(:,:,r), 2);
    std_per_ref7(:,r)=std(per_ref_roi(:,:,r), 0, 2);
    cov_per_ref7(:,r)=std_per_ref7(:,r)./avg_per_ref7(:,r);  
end

for t=1:size(per_tar_roi,3)
    avg_per_tar7(:,t)=mean(per_tar_roi(:,:,t), 2);
    std_per_tar7(:,t)=std(per_tar_roi(:,:,t), 0, 2);
    cov_per_tar7(:,t)=std_per_tar7(:,t)./avg_per_tar7(:,t);  
end

clear tar_voxels ref_voxels per_ref_roi per_tar_roi subject_list

%% 3T Analysis
data_loc='/Data/location';
study_name='STUDYNAME';
subject_list=readcell([ data_loc '/' study_name '/sublist.txt']);
output=([ data_loc '/' study_name '/data/AtlasCorr_HCP_DKT/']);
%Volume
load([output 'Volumes_STUDYNAME.mat'])
%Size of voxels
s=1;
subject=char(subject_list(s,1));

%DKT
nr_D_3=niftiinfo([ data_loc '/' study_name '/data/' subject '/' subject '_DKT.nii.gz']);
vox_size_D3=nr_D_3.PixelDimensions;
vox_vol_D3=vox_size_D3(1)*vox_size_D3(2)*vox_size_D3(3);
%HCP
nr_H_3=niftiinfo([ data_loc '/' study_name '/data/' subject '/' subject '_HCP.nii.gz']);
vox_size_H3=nr_H_3.PixelDimensions;
vox_vol_H3=vox_size_H3(1)*vox_size_H3(2)*vox_size_H3(3);

if vox_vol_D3 == vox_vol_H3
    vol_dkt3=ref_voxels.*vox_vol_D3;
    avg_vol_DKT(:,2)=mean(vol_dkt3, 2);
    std_vol_DKT(:,2)=std(vol_dkt3,0,2);
    cov_dkt(:,2)=std_vol_DKT(:,2)./avg_vol_DKT(:,2);
    
    vol_hcp3=tar_voxels.*vox_vol_H3;
    avg_vol_HCP(:,2)=mean(vol_hcp3, 2);
    std_vol_HCP(:,2)=std(vol_hcp3,0,2);
    cov_hcp(:,2)=std_vol_HCP(:,2)./avg_vol_HCP(:,2);
else
    disp('Voxel Sizes Not Consistent')
end

for r=1:size(per_ref_roi,3)
    avg_per_ref3(:,r)=mean(per_ref_roi(:,:,r), 2);
    std_per_ref3(:,r)=std(per_ref_roi(:,:,r), 0, 2);
    cov_per_ref3(:,r)=std_per_ref3(:,r)./avg_per_ref3(:,r);  
end

for t=1:size(per_tar_roi,3)
    avg_per_tar3(:,t)=mean(per_tar_roi(:,:,t), 2);
    std_per_tar3(:,t)=std(per_tar_roi(:,:,t), 0, 2);
    cov_per_tar3(:,t)=std_per_tar3(:,t)./avg_per_tar3(:,t);  
end

clear tar_voxels ref_voxels per_ref_roi per_tar_roi subject_list

%% 1.5T Analysis
data_loc='/Data/location';
study_name='STUDYNAME';
subject_list=readcell([ data_loc '/' study_name '/sublist.txt']);
output=([ data_loc '/' study_name '/data/AtlasCorr_HCP_DKT/']);
%Volume
load([output 'Volumes_STUDYNAME.mat'])
%Size of voxels
s=1;
subject=char(subject_list(s,1));

%DKT
nr_D_1=niftiinfo([ data_loc '/' study_name '/data/' subject '/' subject '_DKT.nii.gz']);
vox_size_D1=nr_D_1.PixelDimensions;
vox_vol_D1=vox_size_D1(1)*vox_size_D1(2)*vox_size_D1(3);
%HCP
nr_H_1=niftiinfo([ data_loc '/' study_name '/data/' subject '/' subject '_HCP.nii.gz']);
vox_size_H1=nr_H_1.PixelDimensions;
vox_vol_H1=vox_size_H1(1)*vox_size_H1(2)*vox_size_H1(3);

if vox_vol_D1 == vox_vol_H1
    vol_dkt1=ref_voxels.*vox_vol_D1;
    avg_vol_DKT(:,3)=mean(vol_dkt1, 2);
    std_vol_DKT(:,3)=std(vol_dkt1,0,2);
    cov_dkt(:,3)=std_vol_DKT(:,3)./avg_vol_DKT(:,3);
    
    vol_hcp1=tar_voxels.*vox_vol_H1;
    avg_vol_HCP(:,3)=mean(vol_hcp1, 2);
    std_vol_HCP(:,3)=std(vol_hcp1,0,2);
    cov_hcp(:,3)=std_vol_HCP(:,3)./avg_vol_HCP(:,3);
else
    disp('Voxel Sizes Not Consistent')
end

for r=1:size(per_ref_roi,3)
    avg_per_ref1(:,r)=mean(per_ref_roi(:,:,r), 2);
    std_per_ref1(:,r)=std(per_ref_roi(:,:,r), 0, 2);
    cov_per_ref1(:,r)=std_per_ref1(:,r)./avg_per_ref1(:,r);  
end

for t=1:size(per_tar_roi,3)
    avg_per_tar1(:,t)=mean(per_tar_roi(:,:,t), 2);
    std_per_tar1(:,t)=std(per_tar_roi(:,:,t), 0, 2);
    cov_per_tar1(:,t)=std_per_tar1(:,t)./avg_per_tar1(:,t);  
end

clear tar_voxels ref_voxels per_ref_roi per_tar_roi subject_list


%% Figures
%Average volume 
figure(1)
subplot(2,1,1)
scatter(1:358, avg_vol_HCP(:,1), 'g')
hold on
scatter(1:358, avg_vol_HCP(:,2), 'r')
hold on
scatter(1:358, avg_vol_HCP(:,3), 'b')
hold on
legend('7T', '3T', '1.5T')
xlabel('HCP Node Number')
ylabel('Volume in mm^3')
title('HCP Volume dependent on Field Strength')

subplot(2,1,2)
scatter(1:66, avg_vol_DKT(:,1), 'g')
hold on
scatter(1:66, avg_vol_DKT(:,2), 'r')
hold on
scatter(1:66, avg_vol_DKT(:,3), 'b')
hold on
legend('7T', '3T', '1.5T')
xlabel('DKT Node Number')
ylabel('Volume in mm^3')
title('DKT Volume dependent on Field Strength')

%COV
figure(2)
subplot(2,1,1)
scatter(1:358, cov_hcp(:,1), 'g')
hold on
scatter(1:358, cov_hcp(:,2), 'r')
hold on
scatter(1:358, cov_hcp(:,3), 'b')
hold on
legend('7T', '3T', '1.5T')
xlabel('HCP Node Number')
ylabel('Coefficient of Variation of Volume')
title('HCP Volume Variation dependent on Field Strength')

subplot(2,1,2)
scatter(1:66, cov_dkt(:,1), 'g')
hold on
scatter(1:66, cov_dkt(:,2), 'r')
hold on
scatter(1:66, cov_dkt(:,3), 'b')
hold on
legend('7T', '3T', '1.5T')
xlabel('DKT Node Number')
ylabel('Coefficient of Variation of Volume')
title('DKT Volume Variation dependent on Field Strength')

%% TTests

[h,p_D_7v3,ci,stats_D_7v3] = ttest2(cov_dkt(:,1),cov_dkt(:,2)); %DKT 7v3
[h,p_D_7v1,ci,stats_D_7v1] = ttest2(cov_dkt(:,1),cov_dkt(:,3)); %DKT 7v1
[h,p_D_1v3,ci,stats_D_1v3] = ttest2(cov_dkt(:,3),cov_dkt(:,2)); %DKT 1v3

valuesD(1,:)=mean(cov_dkt, 1, 'omitnan');
valuesD(2,:)=std(cov_dkt, 0, 1, 'omitnan');

[h,p_H_7v3,ci,stats_H_7v3] = ttest2(cov_hcp(:,1),cov_hcp(:,2)); %HCP 7v3
[h,p_H_7v1,ci,stats_H_7v1] = ttest2(cov_hcp(:,1),cov_hcp(:,3)); %HCP 7v1
[h,p_H_1v3,ci,stats_H_1v3] = ttest2(cov_hcp(:,3),cov_hcp(:,2)); %HCP 1v3

valuesH(1,:)=mean(cov_hcp, 1, 'omitnan');
valuesH(2,:)=std(cov_hcp, 0, 1, 'omitnan');

%% Comparison of volume and cov

[R_D_7_volcov,P_D_7_volcov] = corrcoef(cov_dkt(:,1),avg_vol_DKT(:,1),'rows','complete'); %DKT 7T Vol vs CoV
[R_D_3_volcov,P_D_3_volcov] = corrcoef(cov_dkt(:,2),avg_vol_DKT(:,2),'rows','complete'); %DKT 3T Vol vs CoV
[R_D_1_volcov,P_D_1_volcov] = corrcoef(cov_dkt(:,3),avg_vol_DKT(:,3),'rows','complete'); %DKT 1.5T Vol vs CoV

[R_H_7_volcov,P_H_7_volcov] = corrcoef(cov_hcp(:,1),avg_vol_HCP(:,1)); %DKT 7T Vol vs CoV
[R_H_3_volcov,P_H_3_volcov] = corrcoef(cov_hcp(:,2),avg_vol_HCP(:,2)); %DKT 3T Vol vs CoV
[R_H_1_volcov,P_H_1_volcov] = corrcoef(cov_hcp(:,3),avg_vol_HCP(:,3)); %DKT 1.5T Vol vs CoV

figure(1)
subplot(1,2,1)
scatter( avg_vol_DKT(:,1), cov_dkt(:,1), 'r')
hold on
scatter( avg_vol_DKT(:,2), cov_dkt(:,2), 'b')
hold on
scatter( avg_vol_DKT(:,3), cov_dkt(:,3), 'g')
hold on
legend('7T', '3T', '1.5T')
ylabel('Volume Coefficient of Variation')
xlabel('Volume (mm^3)')
title('DKT Relationship of Regional Volume and Coeff. of Variation across subjects')

subplot(1,2,2)
scatter( avg_vol_HCP(:,1), cov_hcp(:,1), 'r')
hold on
scatter( avg_vol_HCP(:,2), cov_hcp(:,2), 'b')
hold on
scatter( avg_vol_HCP(:,3), cov_hcp(:,3), 'g')
hold on
legend('7T', '3T', '1.5T')
ylabel('Volume Coefficient of Variation')
xlabel('Volume (mm^3)')
title('HCP Relationship of Regional Volume and Coeff. of Variation across subjects')


