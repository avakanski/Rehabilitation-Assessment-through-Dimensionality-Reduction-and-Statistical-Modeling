% Codes for reading the data for the Standing Shoulder Adbuction exercise
% from UI-PRMD dataset and preparing the data for NN processing
% The outputs are the csv files Data_Correct and Data_Incorrect

clear all; close all;clc;

%% Load the files (Part 1)

% Read the data for 7 subjects (i.g., ignore subjects 6, 7, and 10)
Subjects = [1 2 3 4 5 8 9];

% We will also ignore the first episode for each subject due to missing
% values during the data recording
nEpisodes = 9;

% Load the correct angle movements for StandingShoulderABD subjects 1 2 3 4 5 8 9
% To read text files use: M = csvread('m07_s01_e02_angles.txt');
for i=Subjects
    for j=2:nEpisodes
        eval(['Train1_ang_cor{',int2str(i),',',int2str(j),'} = csvread(''Segmented Movements\Vicon\Angles\m07_s0',int2str(i),'_e0',int2str(j),'_angles.txt'');']);
    end
end

for i=Subjects
    for j=nEpisodes+1
        eval(['Train1_ang_cor{',int2str(i),',',int2str(j),'} = csvread(''Segmented Movements\Vicon\Angles\m07_s0',int2str(i),'_e',int2str(j),'_angles.txt'');']);
    end
end

% Load the incorrect angle movements for StandingShoulderABD subjects 1 2 3 4 5 8 9
% To read text files use: M = csvread('m07_s01_e02_angles_inc.txt');
for i=Subjects
    for j=2:nEpisodes
        eval(['Test1_ang_inc{',int2str(i),',',int2str(j),'} = csvread(''Incorrect Segmented Movements\Vicon\Angles/m07_s0',int2str(i),'_e0',int2str(j),'_angles_inc.txt'');']);
    end
end

for i=Subjects
    for j=nEpisodes+1
        eval(['Test1_ang_inc{',int2str(i),',',int2str(j),'} = csvread(''Incorrect Segmented Movements\Vicon\Angles/m07_s0',int2str(i),'_e',int2str(j),'_angles_inc.txt'');']);
    end
end

%% Reorganize the data into an initial 1x63 array (Part 2)

% Correct sequences
k = 1;
for i=Subjects
    for j=2:nEpisodes+1
        Correct_Ini{k} = Train1_ang_cor{i,j};
        k = k+1;
    end
end

% Total number of episodes
N = length(Correct_Ini);

% Dimensionality of sequences
nDim = size(Correct_Ini{1},2);

% Incorrect sequences
k = 1;
for i=Subjects
    for j=2:nEpisodes+1
        Incorrect_Ini{k} = Test1_ang_inc{i,j};
        k = k+1;
    end
end

%% Perform linear alignment (Part 3)

% Number of subjects
nSubjects = length(Subjects);

% Find the median sequence in length
for i = 1:nSubjects
    Len_Tr(i) = size(Correct_Ini{i},1);
end
% Length_mean = ceil(mean(Len_Tr));
Length_mean = 229;

% Linear alignment to change the length of correct sequences to Lenght_mean
for i=1:N
    for j=1:nDim
        Correct_Aligned{i}(:,j)=interp1([1:size(Correct_Ini{i},1)],Correct_Ini{i}(:,j),linspace(1,size(Correct_Ini{i},1),Length_mean));
    end
end

% Incorrect sequences
for i=1:N
    for j=1:nDim
        Incorrect_Aligned{i}(:,j)=interp1([1:size(Incorrect_Ini{i},1)],Incorrect_Ini{i}(:,j),linspace(1,size(Incorrect_Ini{i},1),Length_mean));
    end
end

%% Transform into matrices with N x nDim rows and sequence length columns(Part 4)

Correct_Xm = [Correct_Aligned{1}'];
for i = 2:N
    Correct_Xm = [Correct_Xm; Correct_Aligned{i}'];
end

Incorrect_Xm = [Incorrect_Aligned{1}'];
for i = 2:N
    Incorrect_Xm = [Incorrect_Xm; Incorrect_Aligned{i}'];
end

%% Re-center the data to obtain zero mean (Part 5)

Data_mean = repmat(mean(Correct_Xm,2), 1, size(Correct_Xm,2));
centered_Correct_Data = Correct_Xm - Data_mean;

% Recenter the incorrect sequences
Data_mean_inc = repmat(mean(Incorrect_Xm,2), 1, size(Incorrect_Xm,2));
centered_Incorrect_Data = Incorrect_Xm - Data_mean_inc;

% Scale the data between -1 and 1
scaling_value = ceil(max(max(max(centered_Correct_Data)),abs(min(min(centered_Correct_Data)))));
Data_Correct = centered_Correct_Data/scaling_value;
Data_Incorrect = centered_Incorrect_Data/scaling_value;

%% Save the data (Part 6)
csvwrite('Data_Correct.csv',Data_Correct)
csvwrite('Data_Incorrect.csv',Data_Incorrect)

