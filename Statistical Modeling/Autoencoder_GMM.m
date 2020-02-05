% Trains a Gaussian Mixture Model (GMM) on the data with reduced dimensionality
% obtained by an autoencoder neural network

clear all; close all;

%% Load the data

Data_NN_ini = csvread('../Data/Autoencoder_output_correct.csv');

% Rescale the data by multiplying with the scaling value 
% The value was used to scale the data for NN into [-1,1] range 
scaling_value = 141;
Data_NN = Data_NN_ini*scaling_value;

addpath('../Utility Functions')

%% Reshape the data for GMM 
% All individual sequences will be concatenated into one large matrix

% The output dimension of the autoencoder is 4
nDim = 4;

% Number of frames in each movement
L = size(Data_NN,2)/nDim;

% Number of correct sequences
n_seq_corr = size(Data_NN,1);

% Create a row for the time indices of correct data
Data=repmat([1:L],1,n_seq_corr);

% Concatenate the data
Data_position=[];
for i=1:n_seq_corr
    temp = [];
    for j=1:nDim
        temp = [temp; Data_NN(i,j:nDim:nDim*L)];
    end
    Data_position=[Data_position,temp];
end
Data=[Data;Data_position];

%% Train GMM

% Define the number of states for GMM
nbStates = 5;

% Number of rows in the data matrix
nbVar = size(Data,1);

% Training by EM algorithm, initialized by k-means clustering.
[Priors, Mu, Sigma] = EM_init_regularTiming(Data, nbStates);
[Priors, Mu, Sigma] = EM_boundingCov(Data, Priors, Mu, Sigma);

disp(['GMM modeling has been completed!',char(10)])

%% Plot the GMM encoding results

figure('position',[20,120,700,700],'name','GMM Autoencoder');
for n=1:nbVar-1
  subplot(nbVar-1,1,n); hold on;
  plotGMM1(Mu([1,n+1],:), Sigma([1,n+1],[1,n+1],:), [1 0.4 0], 1);
  for j=1:n_seq_corr
     plot(Data(n+1,(j-1)*L+1:j*L)','color', [0, 0, 0, 0.25], 'LineWidth', 0.25), hold on
  end
  axis([min(Data(1,:)) max(Data(1,:)) min(Data(n+1,:))-0.01 max(Data(n+1,:))+0.01]);
  set(findobj('type','axes'),'fontsize',10,'box','off')
  xticks(0:20:229)
  yticks(-200:50:200)
  xlabel('Time Frame', 'fontsize',12)
  ylabel('Angle (Degrees)', 'fontsize',12)
end
saveas(gcf, '../Results/Autoencoder_GMM.png')
