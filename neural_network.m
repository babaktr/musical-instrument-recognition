% Load dataset
n_chunks = 50;

dataset = 'dataset-2/';

[input_data, mapped_label_data] = process_training_data(dataset, n_chunks, '');
%[input_data, mapped_label_data] = process_training_data(dataset, n_chunks, 'only_attack');
%[input_data, mapped_label_data] = process_training_data(dataset, n_chunks, 'without_attack');

n_runs = 10;
sum_error = 0;
for n = 1:n_runs
    fprintf('Running experiment %d of %d', n, n_runs); 

    % Regular NN training
    % net = newff(input_data, mapped_label_data, [2], {'tansig' 'logsig'}, 'trainrp', '', 'mse', {}, {}, '');

    % Early stopping
    net = newff(input_data, mapped_label_data, [30], {'tansig' 'logsig'}, 'trainrp', '', 'mse', {}, {}, 'dividerand');

    net = init(net);

    % Custom parameters
    net.trainParam.epochs = 500;
    net.trainParam.lr = 0.1;
    net.trainParam.min_grad = 0;
    net.trainParam.max_fail = 150;
    [trained_net, stats] = train(net, input_data, mapped_label_data);

    % while (stats.best_perf > 0.0002)
    %     net = init(net);
    %     [trained_net, stats] = train(net, input_data, mapped_label_data);
    %     disp(stats.best_perf)
    % end

    plotconfusion(mapped_label_data, sim(trained_net, input_data))
    [c, cm] = confusion(mapped_label_data, sim(trained_net, input_data));
    sum_error = sum_error + c;
    fprintf(' - %f%% accuracy \n', 1 - c);
end
avg_accuracy = (n_runs - sum_error) / n_runs;
fprintf('\nAverage accuracy: %f%% \n', avg_accuracy);