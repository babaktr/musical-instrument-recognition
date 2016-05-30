% Load processed dataset

% Base Experiment
load 'datasets/1-dataset_avgvalue_chunk50.mat'

% Only Attack
% load 'datasets/2-dataset_avgvalue_chunk50_only_attack.mat'

% Without Attack
% load 'datasets/3-dataset_avgvalue_chunk50_without_attack.mat'

% 100 Hz
% load 'datasets/4-dataset_avgvalue_chunk50_100hz.mat'

% 900 Hz
% load 'datasets/5-dataset_avgvalue_chunk50_900hz.mat'

% ---------------------------------------------------------------------

% Functions used to process the data, prelimiarily not available in this
% repo.
% dataset = 'dataset-2/';
% n_chunks = 50;
% [input_data, mapped_label_data] = process_training_data(dataset, n_chunks, '');
% [input_data, mapped_label_data] = process_training_data(dataset, n_chunks, 'only_attack');
% [input_data, mapped_label_data] = process_training_data(dataset, n_chunks, 'without_attack');

% ---------------------------------------------------------------------

n_runs = 10;
sum_error = 0;

for n = 1:n_runs
    fprintf('Running experiment %d of %d', n, n_runs); 

    % Rprop & Early stopping
    net = newff(input_data, mapped_label_data, [30], {'tansig' 'logsig'}, 'trainrp', '', 'mse', {}, {}, 'dividerand');

    net = init(net);

    % Custom parameters
    net.trainParam.epochs = 500;
    net.trainParam.lr = 0.1;
    net.trainParam.min_grad = 0;
    net.trainParam.max_fail = 150;
    
    % Train network
    [trained_net, stats] = train(net, input_data, mapped_label_data);

    plotconfusion(mapped_label_data, sim(trained_net, input_data))
    [c, cm] = confusion(mapped_label_data, sim(trained_net, input_data));
    sum_error = sum_error + c;
    fprintf(' - %f%% accuracy \n', 1 - c);
    
end

avg_accuracy = (n_runs - sum_error) / n_runs;
fprintf('\nAverage accuracy: %f%% \n', avg_accuracy);