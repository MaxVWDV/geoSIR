function [inputs] = population_density_generate(inputs);


%Load population dataset, calculate dimensions and convert to population
%density, normalize to percentiles.

% inputs.min_lat = 39.922;
% inputs.max_lat = 41.569;
% inputs.min_long =  13.677;
% inputs.max_long = 15.876;
% 
% inputs.minimum_density = 0.3;
% inputs.maximum_density = 1;


population_amount = Tiff(inputs.path_to_population);

population_amount = flipud(double(read(population_amount)));

population_amount(population_amount<=0) = NaN;

%Calculate grid resolution

[EW_resolution] = coordtom([inputs.min_lat inputs.min_long],[inputs.min_lat inputs.max_long]); %in m

[NS_resolution] = coordtom([inputs.min_lat inputs.min_long],[inputs.max_lat inputs.min_long]); %in m

EW_resolution = round(EW_resolution/1000); %in km

NS_resolution = round(NS_resolution/1000); %in km

% Resample to an even 1km resolution

total_prior = nansum(population_amount,'all');

population_amount = (interp2(population_amount, linspace(1, size(population_amount,2), EW_resolution).', linspace(1, size(population_amount,1), NS_resolution)));

total_after = nansum(population_amount,'all');

population_amount = (population_amount*total_prior)/total_after;

%Note- this is now also POPULATION DENSITY!

population_density = population_amount;

% Normalize to maximum value

population_density= population_density/max(population_density,[],'all');


population_density = inputs.minimum_density + (((population_density)*(inputs.maximum_density-inputs.minimum_density)));

%%% We now have our ready to use population density map!

% read to inputs array

inputs.population_amount_matrix = population_amount;

inputs.population_density_matrix = population_density;

%%%Read in Red and Yellow zones

red_zone = imread(inputs.path_to_red);

yellow_zone = imread(inputs.path_to_yellow);


red_zone = double(red_zone(:,:,1))+double(red_zone(:,:,2))+double(red_zone(:,:,3));

yellow_zone = double(yellow_zone(:,:,1))+double(yellow_zone(:,:,2))+double(yellow_zone(:,:,3));

red_zone(red_zone>10) = NaN;

red_zone(red_zone >= 0) = 1;

red_zone(isnan(red_zone)) = 0;

yellow_zone(yellow_zone>10) = NaN;

yellow_zone(yellow_zone >= 0) = 1;

yellow_zone(isnan(yellow_zone)) = 0;

hazard_matrix = red_zone+yellow_zone;

hazard_matrix =flipud(round(imfilter(hazard_matrix,ones(3,3))/9)); %remove some graininess around edges of mask.

inputs.hazard_matrix = hazard_matrix;













