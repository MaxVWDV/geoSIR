% function [inputs,outputs] = geoSIR_wrapper_V2_1()
%
% geoSIR, written by Max van wyk de vries and Lekaashree rambabu, 04/2020.
%
%
%This function is used to call on to load parameters, run the model, etc.
%in an ordered way.



%% Load input parameters
[inputs] = V4_1();


%% Run the model
[outputs] = geoSIR_run(inputs);


%% Plot the results and save
geoSIR_plot(inputs,outputs);
