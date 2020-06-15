function [inputs,outputs] = geoSIR_wrapper()
%
% geoSIR, written by Max van wyk de vries and Lekaashree rambabu, 04/2020.
%
%
%This function is used to call on to load parameters, run the model, etc.
%in an ordered way.

clear all

%% Load input parameters
[inputs] = geoSIR_inputs_theoretical_eruption();


%% Run the model
[outputs] = geoSIR_run_theoretical_eruption(inputs);


%% Plot the results and save
geoSIR_plot(inputs,outputs);