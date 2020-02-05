% Trains a Gaussian Mixture Model (GMM) on the data with reduced dimensionality
% obtained by the autoencoder neural network, and uses the loglikelihood 
% as a performance indicator

clear all; close all;

%% Load the data

% Correct repetitions
Data_NN_ini = csvread('../Data/Autoencoder_output_correct.csv');

% Incorrect repetitions
Data_NN_inc_ini = csvread('../Data/Autoencoder_output_incorrect.csv');


% Rescale the data by multiplying with the scaling value 
% The value was used to scale the data for NN into [-1,1] range 
scaling_value = 141;
Data_NN = Data_NN_ini*scaling_value;
Data_NN_inc = Data_NN_inc_ini*scaling_value;

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

% Incorrect sequences
% Number of inconsistent sequences
n_seq_inc = size(Data_NN_inc,1);

% Create a row for the time indices of incorrect data
Data_inc = repmat([1:L],1,n_seq_inc);

% Concatenate the data
Data_inc_position=[];
for i=1:n_seq_corr
    temp = [];
    for j=1:nDim
        temp = [temp; Data_NN_inc(i,j:nDim:nDim*L)];
    end
    Data_inc_position=[Data_inc_position,temp];
end
Data_inc = [Data_inc;Data_inc_position];

%% Train GMM

% Define the number of states for GMM
nbStates = 5;

% Number of rows in the data matrix
nbVar = size(Data,1);

% Training by EM algorithm, initialized by k-means clustering
[Priors, Mu, Sigma] = EM_init_regularTiming(Data, nbStates);
[Priors, Mu, Sigma] = EM_boundingCov(Data, Priors, Mu, Sigma);

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

%% Calculate data loglikelihood 

% Correct sequences loglikelihood
for j=1:n_seq_corr
    loglikelihood_corr(j) = loglik(Data(:,(j-1)*L+1:j*L), nbStates, Priors, Mu, Sigma);
end
 
% Incorrect sequences loglikelihood
for j=1:n_seq_inc
    loglikelihood_inc(j) = loglik(Data_inc(:,(j-1)*L+1:j*L), nbStates, Priors, Mu, Sigma);
end
 
%% Plot the loglikelihood for both the correct and incorrect sequences 

figure, plot(loglikelihood_corr,'ko', 'MarkerFaceColor','g'), hold on, plot(loglikelihood_inc,'ks', 'MarkerFaceColor','r')
set(findobj('type','axes'),'fontsize',12,'box','off')
xlabel('Sequence Number', 'fontsize',14), ylabel('Log-likelihood', 'fontsize',14);
yticks(-36:2:-20);
legend({'Correct Sequences','Incorrect Sequences'}, 'fontsize',12,'location','SW')
saveas(gcf, '../Results/GMM_Loglikelihood_Scores.png')

