%% Load Data
source_file = '/Path/to/outputs/atlas_overlap_data_Schaef_HCP.mat';
load(source_file);

%% Set up atlas keys
ref_LUT_file='/Path/to/labels/FreeSurferLabels_HCP.mat';
load(ref_LUT_file)
HCP_LUT=Freesurferlabelnames(22:end,:);
HCP_labels = [HCP_LUT{:,2}]';
HCP_values=cell2mat(HCP_LUT(:,1));
sizeHCP=length(HCP_labels);
clear Freesurferlabelnames

tar_LUT_file='/Path/to/labels/FreeSurferLabels_Schaefer.mat';
load(tar_LUT_file)
Schaef_LUT=Freesurferlabelnames(22:end,:);
Schaef_labels = [Schaef_LUT{:,2}]';
Schaef_values=cell2mat(Schaef_LUT(:,1));
sizeSchaef=length(Schaef_labels);
clear Freesurferlabelnames

%% Overlap Figure

%HCP as Schaef
U1_D = mean(HCP_as_Schaef(:,:,1,1),3);
U3_D = mean(HCP_as_Schaef(:,:,3,2),3);
U7_D = mean(HCP_as_Schaef(:,:,3,3),3);

U1_D(isnan(U1_D))=0;
U3_D(isnan(U3_D))=0;
U7_D(isnan(U7_D))=0;

V1_D = reshape(U1_D,numel(U1_D),1);
V3_D = reshape(U3_D,numel(U3_D),1);
V7_D = reshape(U7_D,numel(U7_D),1);

% Schaef as HCP
U1_H = mean(Schaef_as_HCP(:,:,1,1),3);
U3_H = mean(Schaef_as_HCP(:,:,3,2),3);
U7_H = mean(Schaef_as_HCP(:,:,3,3),3);

U1_H(isnan(U1_H))=0;
U3_H(isnan(U3_H))=0;
U7_H(isnan(U7_H))=0;

V1_H = reshape(U1_H,numel(U1_H),1);
V3_H = reshape(U3_H,numel(U3_H),1);
V7_H = reshape(U7_H,numel(U7_H),1);

%% Eliminate 0,0 points
V_Dsum=V1_D+V3_D+V7_D;
V1_D(V_Dsum==0,:)=[];
V3_D(V_Dsum==0,:)=[];
V7_D(V_Dsum==0,:)=[];

V_Hsum=V1_H+V3_H+V7_H;
V1_H(V_Hsum==0,:)=[];
V3_H(V_Hsum==0,:)=[];
V7_H(V_Hsum==0,:)=[];

%% Generate Figure
figure;
sgtitle('Similarity of Percent Correspondance by Field Strength (T)');
subplot(2,3,1)
scatter(V1_D,V3_D,'filled','k','MarkerFaceAlpha',0.2);
xlabel('1.5T PC');
ylabel('3T PC')
mdl=fitlm(V1_D,V3_D)
textmessage=sprintf('Adjusted R^2 = %.4f',mdl.Rsquared.Adjusted)
text(0.03,0.9,textmessage);
ax = gca; 
ax.FontSize = 14; 


subplot(2,3,2)
scatter(V3_D,V7_D,'filled','k','MarkerFaceAlpha',0.2);
title('Glasser to Schaefer') 
xlabel('3T PC');
ylabel('7T PC')
mdl=fitlm(V3_D,V7_D)
textmessage=sprintf('Adjusted R^2 = %.4f',mdl.Rsquared.Adjusted)
text(0.03,0.9,textmessage);
ax = gca; 
ax.FontSize = 14; 

subplot(2,3,3)
scatter(V1_D,V7_D,'filled','k','MarkerFaceAlpha',0.2);
xlabel('1.5T PC');
ylabel('7T PC')
mdl=fitlm(V1_D,V7_D)
textmessage=sprintf('Adjusted R^2 = %.4f',mdl.Rsquared.Adjusted)
text(0.03,0.9,textmessage);
ax = gca; 
ax.FontSize = 14; 

subplot(2,3,4)
scatter(V1_H,V3_H,'filled','k','MarkerFaceAlpha',0.2);
xlabel('1.5T PC');
ylabel('3T PC')
mdl=fitlm(V1_H,V3_H)
textmessage=sprintf('Adjusted R^2 = %.4f',mdl.Rsquared.Adjusted)
text(0.03,0.9,textmessage);
ax = gca; 
ax.FontSize = 14; 


subplot(2,3,5)
scatter(V3_H,V7_H,'filled','k','MarkerFaceAlpha',0.2);
title('Schaefer to Glasser') 
xlabel('3T PC');
ylabel('7T PC')
mdl=fitlm(V3_H,V7_H)
textmessage=sprintf('Adjusted R^2 = %.4f',mdl.Rsquared.Adjusted)
text(0.03,0.9,textmessage);
ax = gca; 
ax.FontSize = 14; 

subplot(2,3,6)
scatter(V1_H,V7_H,'filled','k','MarkerFaceAlpha',0.2);
xlabel('1.5T PC');
ylabel('7T PC')
mdl=fitlm(V1_H,V7_H)
textmessage=sprintf('Adjusted R^2 = %.4f',mdl.Rsquared.Adjusted)
text(0.03,0.9,textmessage);
ax = gca; 
ax.FontSize = 14; 

%% Absolute Difference

% 1.5 vs 3T
abs_dif_1v3H=abs(V1_H-V3_H);
abs_dif_1v3D=abs(V1_D-V3_D);

% 1.5 vs 7T
abs_dif_1v7H=abs(V1_H-V7_H);
abs_dif_1v7D=abs(V1_D-V7_D);

% 3 vs 7T
abs_dif_3v7H=abs(V3_H-V7_H);
abs_dif_3v7D=abs(V3_D-V7_D);

%% Plot Histograms
figure;
sgtitle('Absolute Difference in Percent Correspondance by Field Strength (T)');
subplot(2,3,1)
histogram(abs_dif_1v3D)
xlabel('1.5T vs 3T')

subplot(2,3,2)
histogram(abs_dif_1v7D)
xlabel('1.5T vs 7T')
title('Glasser to Schaefer')

subplot(2,3,3)
histogram(abs_dif_3v7D)
xlabel('3T vs 7T')

subplot(2,3,4)
histogram(abs_dif_1v3H)
xlabel('1.5T vs 3T')

subplot(2,3,5)
histogram(abs_dif_1v7H)
xlabel('1.5T vs 7T')
title('Schaefer to Glasser')

subplot(2,3,6)
histogram(abs_dif_3v7H)
xlabel('3T vs 7T')
