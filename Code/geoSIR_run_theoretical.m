function [outputs] = geoSIR_run_theoretical(inputs)
%
% geoSIR, written by Max van wyk de vries and Lekaashree rambabu, 04/2020.
%
%
%This function calculated the spread of a disease according to the
%parameters defined in the previous file.




%% Initialize hazard zones and population density matrix, create agent based set-up

% % % population_density_matrix = inputs.population_density_matrix;
% % % 
% % % hazard_zones = inputs.hazard_matrix;
% % % 
% % % size_required = sqrt(inputs.Number_of_people/...          %Calculate the size of matrix required to have the correct population
% % %     (size(population_density_matrix(population_density_matrix>0),1)*nanmean(population_density_matrix,'all')));
% % % 
% % % population_density_matrix = (interp2(population_density_matrix,...                          %Resize
% % %     linspace(1, size(population_density_matrix,2), size(population_density_matrix,2)*size_required).',...
% % %     linspace(1, size(population_density_matrix,1), size(population_density_matrix,1)*size_required)));
% % % 
% % % hazard_zones = (interp2(hazard_zones,...
% % %     linspace(1, size(hazard_zones,1), size(population_density_matrix,2)).',...
% % %     linspace(1, size(hazard_zones,1), size(population_density_matrix,1))));
% % % 
% % % population_temp = zeros(size(population_density_matrix,1),size(population_density_matrix,2),9); %9th layer for evacuation status
% % % population_temp(:,:,1) = rand(size(population_density_matrix,1),size(population_density_matrix,2),1);
% % % 
% % % 
% % % for yaxis_loop_popdens = 1:size(population_density_matrix,1)                                %Randomly populate according to population density
% % %     for xaxis_loop_popdens = 1:size(population_density_matrix,2)
% % %         if population_temp(yaxis_loop_popdens,xaxis_loop_popdens,1) < population_density_matrix(yaxis_loop_popdens,xaxis_loop_popdens)
% % %             population_temp(yaxis_loop_popdens,xaxis_loop_popdens,1) = 0;
% % %         elseif ~isnan(population_density_matrix(yaxis_loop_popdens,xaxis_loop_popdens))
% % %             population_temp(yaxis_loop_popdens,xaxis_loop_popdens,1) = -1;
% % %         else
% % %            population_temp(yaxis_loop_popdens,xaxis_loop_popdens,1) = NaN; 
% % %         end
% % %     end
% % % end
% % % 
% % % n_red = 0;                  %Calculate the number in each hazard zone
% % % n_yellow = 0;
% % % n_white = 0;
% % % tot_red = 0;
% % % tot_yellow = 0;
% % % tot_white = 0;
% % % 
% % % for yaxis_loop_zone = 1:size(population_density_matrix,1)
% % %     for xaxis_loop_zone = 1:size(population_density_matrix,2)
% % %         if hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==2 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == 0;
% % %             n_red = n_red+1;
% % %             tot_red = tot_red + 1;
% % %         elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==1 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == 0;
% % %             n_yellow = n_yellow + 1;
% % %             tot_yellow = tot_yellow +1;
% % %         elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==0 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == 0;
% % %          n_white = n_white+1;   
% % %          tot_white = tot_white + 1;
% % %         elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==2 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == -1;
% % %             tot_red = tot_red + 1;
% % %         elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==1 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == -1;
% % %             tot_yellow = tot_yellow +1;
% % %         elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==0 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == -1;
% % %          tot_white = tot_white + 1;
% % %         end
% % %     end
% % % end


%Prescribed city location.
 city_location_y = ceil(0.3*sqrt(inputs.Number_of_people)); 
 city_location_x = ceil(0.3*sqrt(inputs.Number_of_people));
 
 %Prescribed volcano location.
 volcano_location_y = ceil(0.35*sqrt(inputs.Number_of_people)); 
volcano_location_x = ceil(0.45*sqrt(inputs.Number_of_people));

population_density_matrix = zeros(round(sqrt(inputs.Number_of_people)),...
    round(sqrt(inputs.Number_of_people)));

% Assign popualtion densities around the city
for yaxis_loop_city = 1:size(population_density_matrix,1)
    for xaxis_loop_city = 1:size(population_density_matrix,2)
        distance_to_city_centre = sqrt(abs(city_location_y-yaxis_loop_city)^2+abs(city_location_x-xaxis_loop_city)^2);
        if distance_to_city_centre >= sqrt(inputs.Number_of_people)*0/75 && distance_to_city_centre < sqrt(inputs.Number_of_people)*1/75
           population_density_matrix(yaxis_loop_city,xaxis_loop_city) = 1;
        elseif distance_to_city_centre >= sqrt(inputs.Number_of_people)*1/75 && distance_to_city_centre < sqrt(inputs.Number_of_people)*2/75
           population_density_matrix(yaxis_loop_city,xaxis_loop_city) = 0.9;
        elseif distance_to_city_centre >= sqrt(inputs.Number_of_people)*2/75 && distance_to_city_centre < sqrt(inputs.Number_of_people)*3/75
           population_density_matrix(yaxis_loop_city,xaxis_loop_city) = 0.8;
        elseif distance_to_city_centre >= sqrt(inputs.Number_of_people)*3/75 && distance_to_city_centre < sqrt(inputs.Number_of_people)*5/75
           population_density_matrix(yaxis_loop_city,xaxis_loop_city) = 0.7;
        elseif distance_to_city_centre >= sqrt(inputs.Number_of_people)*5/75 && distance_to_city_centre < sqrt(inputs.Number_of_people)*7/75
           population_density_matrix(yaxis_loop_city,xaxis_loop_city) = 0.6;
        elseif distance_to_city_centre >= sqrt(inputs.Number_of_people)*7/75 && distance_to_city_centre < sqrt(inputs.Number_of_people)*14/75
           population_density_matrix(yaxis_loop_city,xaxis_loop_city) = 0.4;
        else
           population_density_matrix(yaxis_loop_city,xaxis_loop_city) = 0.3;
        end
    end
end

hazard_zones = zeros(round(sqrt(inputs.Number_of_people)),...
    round(sqrt(inputs.Number_of_people)));

% Assign hazard zones around volcano
for yaxis_loop_volcano = 1:size(hazard_zones,1)
    for xaxis_loop_volcano = 1:size(hazard_zones,2)
        distance_to_volcano = sqrt(abs(volcano_location_y-yaxis_loop_volcano)^2+abs(volcano_location_x-xaxis_loop_volcano)^2);
        if distance_to_volcano >= sqrt(inputs.Number_of_people)*0/20 && distance_to_volcano < sqrt(inputs.Number_of_people)*1/20
           hazard_zones(yaxis_loop_volcano,xaxis_loop_volcano) = 2;
        elseif distance_to_volcano >= sqrt(inputs.Number_of_people)*1/20 && distance_to_volcano < sqrt(inputs.Number_of_people)*3/20
           hazard_zones(yaxis_loop_volcano,xaxis_loop_volcano) = 1;
        else
           hazard_zones(yaxis_loop_volcano,xaxis_loop_volcano) = 0;
        end
    end
end

population_density_matrix = (interp2(population_density_matrix,...
    linspace(1, size(population_density_matrix,1), size(population_density_matrix,1)/sqrt(mean(population_density_matrix,'all'))).',...
    linspace(1, size(population_density_matrix,1), size(population_density_matrix,1)/sqrt(mean(population_density_matrix,'all')))));

hazard_zones = (interp2(hazard_zones,...
    linspace(1, size(hazard_zones,1), size(population_density_matrix,1)).',...
    linspace(1, size(hazard_zones,1), size(population_density_matrix,1))));

population_temp = zeros(size(population_density_matrix,1),size(population_density_matrix,2),9); %9th layer for evacuation status
population_temp(:,:,1) = rand(size(population_density_matrix,1),size(population_density_matrix,2),1);


for yaxis_loop_popdens = 1:size(population_density_matrix,1)
    for xaxis_loop_popdens = 1:size(population_density_matrix,2)
        if population_temp(yaxis_loop_popdens,xaxis_loop_popdens,1) < population_density_matrix(yaxis_loop_popdens,xaxis_loop_popdens)
            population_temp(yaxis_loop_popdens,xaxis_loop_popdens,1) = 0;
        else
            population_temp(yaxis_loop_popdens,xaxis_loop_popdens,1) = -1;
        end
    end
end

n_red = 0;
n_yellow = 0;
n_white = 0;
tot_red = 0;
tot_yellow = 0;
tot_white = 0;

for yaxis_loop_zone = 1:size(population_density_matrix,1)
    for xaxis_loop_zone = 1:size(population_density_matrix,2)
        if hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==2 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == 0;
            n_red = n_red+1;
            tot_red = tot_red + 1;
        elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==1 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == 0;
            n_yellow = n_yellow + 1;
            tot_yellow = tot_yellow +1;
        elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==0 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == 0;
         n_white = n_white+1;   
         tot_white = tot_white + 1;
        elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==2 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == -1;
            tot_red = tot_red + 1;
        elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==1 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == -1;
            tot_yellow = tot_yellow +1;
        elseif hazard_zones(yaxis_loop_zone,xaxis_loop_zone)==0 && population_temp(yaxis_loop_zone,xaxis_loop_zone,1) == -1;
         tot_white = tot_white + 1;
        end
    end
end


tic



% % %Record statistics on a km x km grid
% % 
% % cellsize = 1/size_required;
% % 
% % size_chip = round((inputs.stats_grid_size/cellsize))^2;

% % % 
% % % if strcmpi(inputs.record_stats_infected,'Yes')
% % % meta_stats_infected = num2cell(ones(inputs.Number_of_iterations,1));
% % % end
% % % if strcmpi(inputs.record_stats_critical,'Yes')
% % % meta_stats_critical = num2cell(ones(inputs.Number_of_iterations,1));
% % % end
% % % if strcmpi(inputs.record_stats_died,'Yes')
% % % meta_stats_died = num2cell(ones(inputs.Number_of_iterations,1));
% % % end
% % % if strcmpi(inputs.record_stats_recovered,'Yes')
% % % meta_stats_recovered = num2cell(ones(inputs.Number_of_iterations,1));
% % % end


if strcmpi(inputs.Parralelize,'Yes')            %PARRALEL loop here!
parfor iterations = 1:inputs.Number_of_iterations  %parfor
    
    

    
  %% Create initial condition (1 infected at random spot middle)
population = population_temp;
   

final_day = inputs.Maximum_time;    
    

data_record = zeros(inputs.Maximum_time,13);

new_location_y = 1; %define these here for parpool
new_location_x = 1;

lockdown_counter = 0; %start these anew each iteration
travel_ban_counter = 0;
eruption_counter = 0;
working = inputs;      %change matrix name in able to not break the parralel loop


%Add eruption modifiers
    red_zone_increase_numtrips_close = 1;
    yellow_zone_increase_numtrips_close = 1;
    white_zone_increase_numtrips_close = 1;
    red_zone_increase_disttrips_close = 1;
    yellow_zone_increase_disttrips_close = 1;
    white_zone_increase_disttrips_close = 1;
    
    red_zone_increase_numtrips_distant = 1;
    yellow_zone_increase_numtrips_distant = 1;
    white_zone_increase_numtrips_distant = 1;
    red_zone_increase_disttrips_distant = 1;
    yellow_zone_increase_disttrips_distant = 1;
    white_zone_increase_disttrips_distant = 1;
    
    
% % % %Record statistics on a km x km grid
% % % if strcmpi(working.maximum_density,'Yes')
% % % stats_infected = NaN(floor((size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     floor((size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     ceil(inputs.Maximum_time/inputs.stats_time_interval));
% % % end
% % % 
% % % if strcmpi(inputs.record_stats_critical,'Yes')
% % % stats_critical = NaN(floor((size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     floor((size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     ceil(inputs.Maximum_time/inputs.stats_time_interval));
% % % end
% % % 
% % % if strcmpi(inputs.record_stats_died,'Yes')
% % % stats_died = NaN(floor((size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     floor((size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     ceil(inputs.Maximum_time/inputs.stats_time_interval));
% % % end
% % % 
% % % if strcmpi(inputs.record_stats_recovered,'Yes')
% % % stats_recovered = NaN(floor((size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     floor((size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     ceil(inputs.Maximum_time/inputs.stats_time_interval));
% % % end
% % % 
% % %     
% % % grid_counter = 0;


% loop over matrix
for time_days = 1:inputs.Maximum_time
    
if strcmpi(inputs.Is_there_a_ND,'Yes') %IF there is an eruption
        
    if eruption_counter >0
        if eruption_counter <=inputs.duration_of_ND_disruption
            eruption_counter = eruption_counter+1;
        elseif eruption_counter >inputs.duration_of_ND_disruption
            %reset counter to zero
            eruption_counter  = 0;
            
            %Reset mobility multipliers to baseline
            red_zone_increase_numtrips_close = 1;
            yellow_zone_increase_numtrips_close = 1;
            white_zone_increase_numtrips_close = 1;
            red_zone_increase_disttrips_close = 1;
            yellow_zone_increase_disttrips_close = 1;
            white_zone_increase_disttrips_close = 1;
    
            red_zone_increase_numtrips_distant = 1;
            yellow_zone_increase_numtrips_distant = 1;
            white_zone_increase_numtrips_distant = 1;
            red_zone_increase_disttrips_distant = 1;
            yellow_zone_increase_disttrips_distant = 1;
            white_zone_increase_disttrips_distant = 1;
            
            %Remove 'evacuee' status 
            evacuees_matrix = population(:,:,9);
            evacuees_matrix(evacuees_matrix~=0)=0;
            population(:,:,9) = evacuees_matrix;
        end
    end
if time_days == inputs.ND_time
    
    eruption_counter = 1;
    %Case 1: Increase number of trips in red and yellow zones, people stay in place
    if inputs.ND_case == 1
    
        %https://www.pnas.org/content/109/29/11576

    red_zone_increase_numtrips_close = 3;
    yellow_zone_increase_numtrips_close = 3;
    white_zone_increase_numtrips_close = 1.5;
    red_zone_increase_disttrips_close = 3;
    yellow_zone_increase_disttrips_close = 3;
    white_zone_increase_disttrips_close = 1.5;
    
    red_zone_increase_numtrips_distant = 3;
    yellow_zone_increase_numtrips_distant = 3;
    white_zone_increase_numtrips_distant = 1.5;
    red_zone_increase_disttrips_distant = 3;
    yellow_zone_increase_disttrips_distant = 3;
    white_zone_increase_disttrips_distant = 1.5;
    
    

    
    %Case 2:Evacuate everyone in red, mobility remains the same. Note
    %requirement: there is enough empty space (low enough pop density) that
    %everyone can be relocated to empty space!
    elseif inputs.ND_case == 2
    
         %Evacuate red and 25% yellow zones    
    for yaxis_loop_evacuation = 1:size(population,1)
    for xaxis_loop_evacuation = 1:size(population,2)
    if hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 2 %RED zone
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 2; %Tracer for evacuees from RED zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
            
    elseif hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 1 %Yellow zone
            are_they_evacuated = rand;
            
            if are_they_evacuated < 0.25 %25% evacuees
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 1; %Tracer for evacuees from YELLOW zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
            end
    end
    end
    end
    
    
    
    

    
    %Case 3: Evacuate all in red and increase mobility in red and yellow
    elseif inputs.ND_case == 3
     
        
        
        
        %Evacuate red zone
    for yaxis_loop_evacuation = 1:size(population,1)
    for xaxis_loop_evacuation = 1:size(population,2)
        
        if hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 2; %Tracer for evacuees from RED zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
         end
    end
    end
        
        
        
    %Adjust mobilities
        
        %https://www.pnas.org/content/109/29/11576

    red_zone_increase_numtrips_close = 3;
    yellow_zone_increase_numtrips_close = 3;
    white_zone_increase_numtrips_close = 1.5;
    red_zone_increase_disttrips_close = 3;
    yellow_zone_increase_disttrips_close = 3;
    white_zone_increase_disttrips_close = 1.5;
    
    red_zone_increase_numtrips_distant = 3;
    yellow_zone_increase_numtrips_distant = 3;
    white_zone_increase_numtrips_distant = 1.5;
    red_zone_increase_disttrips_distant = 3;
    yellow_zone_increase_disttrips_distant = 3;
    white_zone_increase_disttrips_distant = 1.5; 
        
        
        
        
        
        
        
        
        
        
        
        
    %Case 4: Evacuate all in red, 25% yellow and increase mobility in red, and yellow
    %and entire region
    elseif inputs.ND_case == 4    
    
        
    %Evacuate red and 25% yellow zones    
    for yaxis_loop_evacuation = 1:size(population,1)
    for xaxis_loop_evacuation = 1:size(population,2)
    if hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 2 %RED zone
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 2; %Tracer for evacuees from RED zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
            
    elseif hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 1 %Yellow zone
            are_they_evacuated = rand;
            
            if are_they_evacuated < 0.25 %25% evacuees
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 1; %Tracer for evacuees from YELLOW zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
            end
    end
    end
    end
        
        
        
    %Adjust mobilities
        
        %https://www.pnas.org/content/109/29/11576

    red_zone_increase_numtrips_close = 3;
    yellow_zone_increase_numtrips_close = 3;
    white_zone_increase_numtrips_close = 1.5;
    red_zone_increase_disttrips_close = 3;
    yellow_zone_increase_disttrips_close = 3;
    white_zone_increase_disttrips_close = 1.5;
    
    red_zone_increase_numtrips_distant = 3;
    yellow_zone_increase_numtrips_distant = 3;
    white_zone_increase_numtrips_distant = 1.5;
    red_zone_increase_disttrips_distant = 3;
    yellow_zone_increase_disttrips_distant = 3;
    white_zone_increase_disttrips_distant = 1.5;    
    
    
   
        
        
        
        
        
        
        
        
        
        
        
    end     
end
end
    
    
    
    if eruption_counter > 0 && lockdown_counter ~= 0
    %Exit lockdown
    if lockdown_counter == 1 &&...
            (data_record(time_days-1,14) <= working.Confirmed_cases_lockdown_exit &&...
             data_record(time_days-1,15) <= working.Deaths_lockdown_exit)
                
         working.Proportion_non_symptomatic_self_isolation = working.backup.Proportion_non_symptomatic_self_isolation;
         working.Proportion_symptomatic_self_isolation = working.backup.Proportion_symptomatic_self_isolation;
         
         working.Distance_travelled_for_close_encounters = working.backup.Distance_travelled_for_close_encounters;
         working.Distance_travelled_for_distant_encounters = working.backup.Distance_travelled_for_distant_encounters;
    
         lockdown_counter = 0;
    end  
    elseif eruption_counter  == 0
     %Exit lockdown
    if lockdown_counter == 1 &&...
            (data_record(time_days-1,14) <= working.Confirmed_cases_lockdown_exit &&...
             data_record(time_days-1,15) <= working.Deaths_lockdown_exit)
                
         working.Proportion_non_symptomatic_self_isolation = working.backup.Proportion_non_symptomatic_self_isolation;
         working.Proportion_symptomatic_self_isolation = working.backup.Proportion_symptomatic_self_isolation;
         
         working.Distance_travelled_for_close_encounters = working.backup.Distance_travelled_for_close_encounters;
         working.Distance_travelled_for_distant_encounters = working.backup.Distance_travelled_for_distant_encounters;
    
         lockdown_counter = 0;
    end   
    
    %Enter into lockdown
    if time_days > 1 && strcmpi(working.Is_a_lockdown_implemented,'Yes') && lockdown_counter == 0 &&...
            (data_record(time_days-1,14) >= working.Confirmed_cases_lockdown_threshold ||...
             data_record(time_days-1,15) >= working.Deaths_lockdown_threshold)
         
         working.backup.Proportion_non_symptomatic_self_isolation = working.Proportion_non_symptomatic_self_isolation;
         working.backup.Proportion_symptomatic_self_isolation = working.Proportion_symptomatic_self_isolation;
         working.backup.Distance_travelled_for_close_encounters = working.Distance_travelled_for_close_encounters;
         working.backup.Distance_travelled_for_distant_encounters = working.Distance_travelled_for_distant_encounters;
         
         working.Proportion_non_symptomatic_self_isolation = working.Lockdown_proportion_non_symptomatic;
         
         working.Proportion_symptomatic_self_isolation = working.Lockdown_proportion_symptomatic;
         
         working.Distance_travelled_for_close_encounters.min = round(working.Distance_travelled_for_close_encounters.min/inputs.Distance_moved_reduction_factor);
         working.Distance_travelled_for_close_encounters.max = round(working.Distance_travelled_for_close_encounters.max/inputs.Distance_moved_reduction_factor);
         
         working.Distance_travelled_for_distant_encounters.min = round(working.Distance_travelled_for_distant_encounters.min/inputs.Distance_moved_reduction_factor);
         working.Distance_travelled_for_distant_encounters.max = round(working.Distance_travelled_for_distant_encounters.max/inputs.Distance_moved_reduction_factor);
         
         if working.Distance_travelled_for_close_encounters.min == 0
             working.Distance_travelled_for_close_encounters.min = 1;
         end
         
         if working.Distance_travelled_for_close_encounters.max == 0
             working.Distance_travelled_for_close_encounters.max = 1;
         end
         
         if working.Distance_travelled_for_distant_encounters.min == 0
             working.Distance_travelled_for_distant_encounters.min = 1;
         end
         
         if working.Distance_travelled_for_distant_encounters.max == 0
             working.Distance_travelled_for_distant_encounters.max = 1;
         end
         
         lockdown_counter = 1;
    end
    
    end     %end eruption counter condition
   
    %Exit travel_ban_condition
    if travel_ban_counter == 1 &&...
            (data_record(time_days-1,14) <= working.Confirmed_cases_travel_ban_exit &&...
             data_record(time_days-1,15) <= working.Deaths_travel_ban_exit)
    
         travel_ban_counter = 0;
    end
       
    %Enter into travel_ban_condition
    if time_days > 1 && strcmpi(working.Is_a_travel_ban_implemented,'Yes') && travel_ban_counter == 0 &&...
            (data_record(time_days-1,14) >= working.Confirmed_cases_travel_ban_threshold ||...
             data_record(time_days-1,15) >= working.Deaths_travel_ban_threshold)
    
         travel_ban_counter = 1;
    end
    
    
    
    
    
    
    if travel_ban_counter == 0 %Only if no travel ban
    
        
    %Travellers come in and leave
        
    number_incoming_travellers = round(working.Number_of_travellers_in.min...
        + rand*(working.Number_of_travellers_in.max-working.Number_of_travellers_in.min));
    
    number_outgoing_travellers = round(working.Number_of_travellers_out.min...
        + rand*(working.Number_of_travellers_out.max-working.Number_of_travellers_out.min));
    
    imported_cases = 0;
    
    
    if strcmpi(working.traveller_only_to_empty_cells, 'Yes')
    
%     incoming loop
    for incoming_loop = 1:number_incoming_travellers
        y_position_travel = ceil(rand*size(population,1));
        x_position_travel = ceil(rand*size(population,2));
        traveller_not_arrived = 0;
        while traveller_not_arrived ==0
        if population(y_position_travel,x_position_travel,1)==-1
            chance_infected = (working.Fraction_of_infected_travellers.min...
        + rand*(working.Fraction_of_infected_travellers.max-working.Fraction_of_infected_travellers.min));
             is_the_traveller_infected = rand;
           if is_the_traveller_infected < chance_infected
               population(y_position_travel,x_position_travel,1) = 1;
               population(y_position_travel,x_position_travel,2) = 0.5;
               imported_cases = imported_cases+1;
           else
               population(y_position_travel,x_position_travel,1) = 0;
           end
           traveller_not_arrived = 1;
        else
        y_position_travel = ceil(rand*size(population,1));
        x_position_travel = ceil(rand*size(population,2));  
        end
        end %end while

    end %end incoming loop
    
    %     outgoing loop
    for outgoing_loop = 1:number_outgoing_travellers
        y_position_exit = ceil(rand*size(population,1));
        x_position_exit = ceil(rand*size(population,2));
        traveller_not_left = 0;
        while traveller_not_left ==0
        if population(y_position_exit,x_position_exit,1)== -1
        y_position_exit = ceil(rand*size(population,1));
        x_position_exit = ceil(rand*size(population,2));   
        else
        if population(y_position_exit,x_position_exit,1)~=3  
           population(y_position_exit,x_position_exit,1) = -1;
           
           traveller_not_left = 1;
        end
        end
        end %end while

    end %end outgoing loop
    
    else
     %     incoming loop
    for incoming_loop = 1:number_incoming_travellers
        y_position_travel = ceil(rand*size(population,1));
        x_position_travel = ceil(rand*size(population,2));
        
        traveller_not_arrived = 0;
        while traveller_not_arrived ==0
        if population(y_position_travel,x_position_travel,1)~=3 && ~isnan(population(y_position_travel,x_position_travel,1))
                probability_cell_full = rand;
            
            if probability_cell_full < working.Population_density
            chance_infected = (working.Fraction_of_infected_travellers.min...
          + rand*(working.Fraction_of_infected_travellers.max-working.Fraction_of_infected_travellers.min));
             is_the_traveller_infected = rand;
           if is_the_traveller_infected < chance_infected
               population(y_position_travel,x_position_travel,1) = 1;
               population(y_position_travel,x_position_travel,2) = 0.5;
               imported_cases = imported_cases+1;
           else
               population(y_position_travel,x_position_travel,1) = 0;
           end
            else
           population(y_position_travel,x_position_travel,1) = -1;
            end
            traveller_not_arrived = 1;
        else 
        y_position_travel = ceil(rand*size(population,1));
        x_position_travel = ceil(rand*size(population,2));  
        end
        end    


    end %end incoming loop
    
    %     outgoing loop
    for outgoing_loop = 1:number_outgoing_travellers
        y_position_exit = ceil(rand*size(population,1));
        x_position_exit = ceil(rand*size(population,2));
        
        traveller_not_left = 0;
        while traveller_not_left ==0
        if population(y_position_exit,x_position_exit,1)~=3 && ~isnan(population(y_position_travel,x_position_travel,1))
        probability_cell_full = rand;
            
            if probability_cell_full < working.Population_density
            population(y_position_exit,x_position_exit,1) = 0;
            else
           population(y_position_exit,x_position_exit,1) = -1;
            end
        traveller_not_left=1;
        else 
        y_position_exit = ceil(rand*size(population,1));
        x_position_exit = ceil(rand*size(population,2));  
        end
        end


    end %end outgoing loop
    
    end
    
    end
        
    
    %Work out who is self isolating today. Starts at day 2. 
    %Conduct testing.
    
    if time_days > 1
    
    current_state_matrix = population(:,:,1);
    symptomatic_state_matrix = population(:,:,2)./population(:,:,3);
    
    %%%Non Symptomatic patients
    non_symptomatic_locations = current_state_matrix;
    
    non_symptomatic_locations(current_state_matrix==1) = -9; %all infected
    
    non_symptomatic_locations(symptomatic_state_matrix > 1) = 1; %remove those with symptoms
    
    non_symptomatic_locations(current_state_matrix==4) = -9; %add the asymptomatic cases
    
    %%%Symptomatic patients
    symptomatic_locations = current_state_matrix;
    
    symptomatic_locations(current_state_matrix==1) = -9; %all infected
    
    symptomatic_locations(symptomatic_state_matrix <= 1) = 1; %remove those in incubation period
    
    % -9 values mark those non symptomatic or symptomatic. Convert to
    % something more usable.
    
    non_symptomatic_locations(non_symptomatic_locations ~= -9) = 0;
    non_symptomatic_locations(non_symptomatic_locations == -9) = 1;
    
    symptomatic_locations(symptomatic_locations ~= -9) = 0;
    symptomatic_locations(symptomatic_locations == -9) = 1;
    
    non_symptomatic_self_isolating = non_symptomatic_locations.*rand(size(non_symptomatic_locations));
    non_symptomatic_self_isolating(non_symptomatic_self_isolating>working.Proportion_non_symptomatic_self_isolation.min...
        + rand*(working.Proportion_non_symptomatic_self_isolation.max-working.Proportion_non_symptomatic_self_isolation.min))...
        =0;
    non_symptomatic_self_isolating(non_symptomatic_self_isolating>0) = 1;
        
    symptomatic_self_isolating = symptomatic_locations.*rand(size(symptomatic_locations));
    symptomatic_self_isolating(symptomatic_self_isolating>working.Proportion_symptomatic_self_isolation.min...
        + rand*(working.Proportion_symptomatic_self_isolation.max-working.Proportion_symptomatic_self_isolation.min))...
        =0;
    symptomatic_self_isolating(symptomatic_self_isolating>0) = 2;
    
    self_isolation_grid = non_symptomatic_self_isolating+symptomatic_self_isolating; %load to layer. 2 is stricter symptomatic self isolation.
    
    
    number_of_tests_conducted_symptomatic = working.Number_of_tests_conducted_symptomatic.min...
        + rand*(working.Number_of_tests_conducted_symptomatic.max-working.Number_of_tests_conducted_symptomatic.min);
    
    number_of_tests_conducted_non_symptomatic = working.Number_of_tests_conducted_non_symptomatic.min...
        + rand*(working.Number_of_tests_conducted_non_symptomatic.max-working.Number_of_tests_conducted_non_symptomatic.min);
    
    false_positive_rate = working.Test_false_positive_rate.min...
        + rand*(working.Test_false_positive_rate.max-working.Test_false_positive_rate.min);
    
    false_negative_rate = working.Test_false_negative_rate.min...
        + rand*(working.Test_false_negative_rate.max-working.Test_false_negative_rate.min);
    
    probability_of_being_tested_symptomatic = number_of_tests_conducted_symptomatic/sum(symptomatic_locations,'all');
    
    %Make a new matrix of locations of 'susceptible' people 
    
    susceptible_state_locations = current_state_matrix;
    
    susceptible_state_locations(current_state_matrix==0) = -9; %add the susceptible
       
    susceptible_state_locations(susceptible_state_locations ~= -9) = 0;
    susceptible_state_locations(susceptible_state_locations == -9) = 1;    
    
    probability_of_being_tested_non_symptomatic = number_of_tests_conducted_non_symptomatic...
        /(sum(susceptible_state_locations,'all')+sum(non_symptomatic_locations,'all'));
    
    if probability_of_being_tested_symptomatic > 1  %cannot be larger than one
        probability_of_being_tested_symptomatic = 1;
    end
    if probability_of_being_tested_non_symptomatic > 1
        probability_of_being_tested_non_symptomatic = 1;
    end
    
    %Results of the tests
    
    
    
    test_results_symptomatic = symptomatic_locations.*rand(size(symptomatic_locations));
    test_results_symptomatic(test_results_symptomatic == 0) = 9;
    test_results_symptomatic(test_results_symptomatic < probability_of_being_tested_symptomatic*false_negative_rate) =-9; %False Negatives
    test_results_symptomatic(test_results_symptomatic == 9) = 0;
    test_results_symptomatic(test_results_symptomatic > probability_of_being_tested_symptomatic) = 0 ; 
    test_results_symptomatic(test_results_symptomatic>0) = 2;  %2 = test is positive
    test_results_symptomatic(test_results_symptomatic==-9) = 3; %3 = false negative
    
    test_results_non_symptomatic = non_symptomatic_locations.*rand(size(symptomatic_locations));
    test_results_non_symptomatic(test_results_non_symptomatic == 0) = 9;
    test_results_non_symptomatic(test_results_non_symptomatic < probability_of_being_tested_non_symptomatic*false_negative_rate) =-9; %False Negatives
    test_results_non_symptomatic(test_results_non_symptomatic == 9) = 0;
    test_results_non_symptomatic(test_results_non_symptomatic > probability_of_being_tested_non_symptomatic) = 0 ; 
    test_results_non_symptomatic(test_results_non_symptomatic>0) = 2;  %2 = test is positive
    test_results_non_symptomatic(test_results_non_symptomatic==-9) = 3; %3 = false negative
    
    test_results_susceptible = susceptible_state_locations.*rand(size(symptomatic_locations));
    test_results_susceptible(test_results_susceptible == 0) = 9;
    test_results_susceptible(test_results_susceptible < probability_of_being_tested_non_symptomatic*false_positive_rate) =-9; %False Positives
    test_results_susceptible(test_results_susceptible == 9) = 0;
    test_results_susceptible(test_results_susceptible > probability_of_being_tested_non_symptomatic) = 0 ; 
    test_results_susceptible(test_results_susceptible>0) = 1;  %1 = test is negative
    test_results_susceptible(test_results_susceptible==-9) = 4; %4 = false positive
    
    population(:,:,7) = test_results_symptomatic+test_results_non_symptomatic+test_results_susceptible; %test results loaded
    
    %Adjust self isolation behaviour dependant on test results
    self_isolation_grid(population(:,:,7)==1) = 0;
    self_isolation_grid(population(:,:,7)==3) = 0;
    self_isolation_grid(population(:,:,7)==2) = 2;
    self_isolation_grid(population(:,:,7)==4) = 2;
    
    apparent_positives = population(:,:,7);
    apparent_positives(apparent_positives==1) = 0; 
    apparent_positives(apparent_positives==3) = 0;
    apparent_positives(population(:,:,7)==5)=1;
    
    population(:,:,8) = population(:,:,8) + apparent_positives;
        
    population(:,:,6) = self_isolation_grid; %load to layer. 2 is stricter symptomatic self isolation.

    
    
    end
    
   mild_recovered = 0;
   serious_recovered = 0;
    
    
   
    
for yaxis_loop = 1:size(population,1)
    for xaxis_loop = 1:size(population,2)
        
        %IF 0, they are succeptible
        
        %IF they are infectious
        if floor(population(yaxis_loop,xaxis_loop,1))== 1 || floor(population(yaxis_loop,xaxis_loop,1))== 4 || floor(population(yaxis_loop,xaxis_loop,1))== 5
            
            %create two layers for incubation time and time infected (if
            %they do not already exist).
            if population(yaxis_loop,xaxis_loop,3) == 0 || population(yaxis_loop,xaxis_loop,4) == 0
               
                population(yaxis_loop,xaxis_loop,3) = ceil(abs(normrnd(working.Incubation_time.mean,working.Incubation_time.sd)));
                
                population(yaxis_loop,xaxis_loop,4) = ceil(abs(normrnd(working.Length_of_illness.mean,working.Length_of_illness.sd)));
                
            end
            
            %they may encounter other people and infect them
            
           %%%%%%%%%%%Determine multipliers for all the different stats
           if strcmpi(inputs.Is_there_a_ND,'Yes') && eruption_counter > 0
             if hazard_zones(  yaxis_loop,xaxis_loop) == 2 || population(yaxis_loop,xaxis_loop,9) == 2
        
               n_enouncounters_close_multiplier = red_zone_increase_numtrips_close;
               d_enouncounters_close_multiplier = red_zone_increase_disttrips_close;
               n_enouncounters_distant_multiplier = red_zone_increase_numtrips_distant;
               d_enouncounters_distant_multiplier = red_zone_increase_disttrips_distant;
                 
             elseif hazard_zones(  yaxis_loop,xaxis_loop) == 1 || population(yaxis_loop,xaxis_loop,9) == 1    
                
               n_enouncounters_close_multiplier = yellow_zone_increase_numtrips_close;
               d_enouncounters_close_multiplier = yellow_zone_increase_disttrips_close;
               n_enouncounters_distant_multiplier = yellow_zone_increase_numtrips_distant;
               d_enouncounters_distant_multiplier = yellow_zone_increase_disttrips_distant;
                 
            elseif hazard_zones(  yaxis_loop,xaxis_loop) == 0 && population(yaxis_loop,xaxis_loop,9) == 0   
               
               n_enouncounters_close_multiplier = white_zone_increase_numtrips_close;
               d_enouncounters_close_multiplier = white_zone_increase_disttrips_close;
               n_enouncounters_distant_multiplier = white_zone_increase_numtrips_distant;
               d_enouncounters_distant_multiplier = white_zone_increase_disttrips_distant;   
                
             end
           else
               n_enouncounters_close_multiplier = 1;
               d_enouncounters_close_multiplier = 1;
               n_enouncounters_distant_multiplier = 1;
               d_enouncounters_distant_multiplier = 1;
           end
            
           %%%%%%%%%%%%%%CLOSE ENCOUNTERS
           
           %determine number of close encounters
           if population(yaxis_loop,xaxis_loop,6) == 0
           number_of_encounters_close = round(n_enouncounters_close_multiplier*(working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min)));
           elseif population(yaxis_loop,xaxis_loop,6) == 1
           number_of_encounters_close = round(n_enouncounters_close_multiplier*((working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min))*...
               (1-(working.Efficiency_of_non_symptomatic_self_isolation.min +rand*(...
               working.Efficiency_of_non_symptomatic_self_isolation.max-working.Efficiency_of_non_symptomatic_self_isolation.min)))));           
           elseif population(yaxis_loop,xaxis_loop,6) == 2
           number_of_encounters_close = round(n_enouncounters_close_multiplier*((working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min))*...
               (1-(working.Efficiency_of_symptomatic_self_isolation.min +rand*(...
               working.Efficiency_of_symptomatic_self_isolation.max-working.Efficiency_of_symptomatic_self_isolation.min)))));     
           end
           if number_of_encounters_close > 0
            for encounter_loop = 1:number_of_encounters_close
                
                %Person encountered. Various conditions to deal with
                %distance from edge of box.
                
                traveled_this_day = round(d_enouncounters_close_multiplier*(working.Distance_travelled_for_close_encounters.min + ...
                    rand*(working.Distance_travelled_for_close_encounters.max-working.Distance_travelled_for_close_encounters.min)));
                
                if (yaxis_loop+round((2*(traveled_this_day)*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1)) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %all OK
                new_location_y = yaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                new_location_x = xaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                elseif (yaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1)) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0
                    %all sides out of range, infects random spot within
                    %total population
                new_location_y = ceil(size(population,1)*rand);
                new_location_x = ceil(size(population,1)*rand);
                elseif (yaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1)) &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0
                    %y too high, x too low
                new_location_y = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                new_location_x = ceil(traveled_this_day*rand);
                elseif(yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1)) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0 
                    %x too high, y too low
                new_location_y = ceil(traveled_this_day*rand);
                new_location_x = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0
                    %y too low, x too low 
                new_location_y = ceil(traveled_this_day*rand);
                new_location_x = ceil(traveled_this_day*rand);
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %y too high, x too high 
                new_location_y = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                new_location_x = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %y too high, x OK 
                new_location_y = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                new_location_x = xaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %y too low, x OK 
                new_location_y = ceil(traveled_this_day*rand);
                new_location_x = xaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %y OK, x too high 
                new_location_y = yaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                new_location_x = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0
                    %y OK, x too low 
                new_location_y = yaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                new_location_x = ceil(traveled_this_day*rand);
                end
                
                %If person exists (not out of range) and is suceptible
                
                if ((new_location_y >= 1) && (new_location_y <= size(population,1))) &&...
                        ((new_location_x >= 1) && (new_location_x <= size(population,2)))

                    if population(new_location_y,new_location_x,1) == 0
                    
                aretheyinfected = rand;
                
               if aretheyinfected < normrnd(working.Probability_of_infection_for_close_encounters.mean,working.Probability_of_infection_for_close_encounters.std)
                   aretheyasymptomatic = rand;
                   if aretheyasymptomatic < normrnd(working.Proportion_asymptomatic.mean,working.Proportion_asymptomatic.std)
                   population(new_location_y,new_location_x,1) = 4;
                   population(new_location_y,new_location_x,2) = 0.5; %this value to start the counter at the next day for all recently infected cases
                   else
                   population(new_location_y,new_location_x,1) = 1;
                   population(new_location_y,new_location_x,2) = 0.5; %this value to start the counter at the next day for all recently infected cases
                   end
               end
                    end
                end

            end
           end
            
            %%%%%%%%%%%%%%DISTANT ENCOUNTERS

            
            %determine number of distant encounters
           if population(yaxis_loop,xaxis_loop,6) == 0
           number_of_encounters_distant = round(n_enouncounters_distant_multiplier*(working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min)));
           elseif population(yaxis_loop,xaxis_loop,6) == 1
           number_of_encounters_distant = round(n_enouncounters_distant_multiplier*((working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min))*...
               (1-(working.Efficiency_of_non_symptomatic_self_isolation.min +rand*(...
               working.Efficiency_of_non_symptomatic_self_isolation.max-working.Efficiency_of_non_symptomatic_self_isolation.min)))));           
           elseif population(yaxis_loop,xaxis_loop,6) == 2
           number_of_encounters_distant = round(n_enouncounters_distant_multiplier*((working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min))*...
               (1-(working.Efficiency_of_symptomatic_self_isolation.min +rand*(...
               working.Efficiency_of_symptomatic_self_isolation.max-working.Efficiency_of_symptomatic_self_isolation.min)))));     
           end
           if number_of_encounters_distant > 0
            
            
            for encounter_loop = 1:number_of_encounters_distant
                
                 long_distance_today = round(d_enouncounters_distant_multiplier*(working.Distance_travelled_for_distant_encounters.min +...
                     rand*(working.Distance_travelled_for_distant_encounters.max-working.Distance_travelled_for_distant_encounters.min)));           
                            
                %Person encountered. Various conditions to deal with
                %distance from edge of box.
                if (yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1)) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %all OK
                new_location_y = yaxis_loop+round((2*long_distance_today*(0.5-rand)));
                new_location_x = xaxis_loop+round((2*long_distance_today*(0.5-rand)));
                elseif (yaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1)) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) <= 0
                    %all sides out of range, infects random spot within
                    %total population
                new_location_y = ceil(size(population,1)*rand);
                new_location_x = ceil(size(population,1)*rand);
                elseif (yaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1)) &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) <= 0
                    %y too high, x too low
                new_location_y = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                new_location_x = ceil(long_distance_today*rand);
                elseif(yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1)) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) <= 0 
                    %x too high, y too low
                new_location_y = ceil(long_distance_today*rand);
                new_location_x = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) <= 0
                    %y too low, x too low 
                new_location_y = ceil(long_distance_today*rand);
                new_location_x = ceil(long_distance_today*rand);
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %y too high, x too high 
                new_location_y = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                new_location_x = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %y too high, x OK 
                new_location_y = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                new_location_x = xaxis_loop+round((2*long_distance_today*(0.5-rand)));
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %y too low, x OK 
                new_location_y = ceil(long_distance_today*rand);
                new_location_x = xaxis_loop+round((2*long_distance_today*(0.5-rand)));
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %y OK, x too high 
                new_location_y = yaxis_loop+round((2*long_distance_today*(0.5-rand)));
                new_location_x = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) <= 0
                    %y OK, x too low 
                new_location_y = yaxis_loop+round((2*long_distance_today*(0.5-rand)));
                new_location_x = ceil(long_distance_today*rand);
                end
                
                %If person exists (not out of range) and is suceptible
                if ((new_location_y >= 1) && (new_location_y <= size(population,1))) &&...
                        ((new_location_x >= 1) && (new_location_x <= size(population,2)))
                    if population(new_location_y,new_location_x) == 0
                    
                aretheyinfected = rand;
                
               if aretheyinfected < normrnd(working.Probability_of_infection_for_distant_encounters.mean,working.Probability_of_infection_for_distant_encounters.std)
                   aretheyasymptomatic = rand;
                   if aretheyasymptomatic < normrnd(working.Proportion_asymptomatic.mean,working.Proportion_asymptomatic.std)
                   population(new_location_y,new_location_x,1) = 4;
                   population(new_location_y,new_location_x,2) = 0.5; %this value to start the counter at the next day for all recently infected cases
                   else
                   population(new_location_y,new_location_x,1) = 1;
                   population(new_location_y,new_location_x,2) = 0.5; %this value to start the counter at the next day for all recently infected cases
                   end           
               end
                    end
               end
            end
           end
            
            
            %Regular infected people may transition to Seriously infected 
            if  population(yaxis_loop,xaxis_loop,1) == 1 && population(yaxis_loop,xaxis_loop,2)...
                    > population(yaxis_loop,xaxis_loop,3)
                
            aretheyserious = rand;
            
            risk_serious_illness = (normrnd(working.Risk_of_serious_illness.mean,working.Risk_of_serious_illness.std))...
                /(population(yaxis_loop,xaxis_loop,4));
                        
            if aretheyserious < risk_serious_illness
                population(yaxis_loop,xaxis_loop,1) = 5;
                population(yaxis_loop,xaxis_loop,5) = (population(yaxis_loop,xaxis_loop,4)...
                    +population(yaxis_loop,xaxis_loop,3))-population(yaxis_loop,xaxis_loop,2); %Time remaining as critically ill
            end
            end
            
            %Seriously infected people may die
            if  population(yaxis_loop,xaxis_loop,1) ==5 
                
                number_serious_ill_matrix = population(:,:,1);
                number_serious_ill = size(number_serious_ill_matrix(number_serious_ill_matrix==5),1);
                
                %https://jamanetwork.com/journals/jama/article-abstract/2762130?fbclid=IwAR3VO06Zl4FQxcHZKISBSzyfhmYP12BsHRK64VcI1JPCnoNF6vH59wYneUY
                if number_serious_ill*0.25 > working.Hospital_capacity %Quarter total seriously ill in hospital
                    death_rate_multiplier = working.Sensitivity_to_overcrowding*(number_serious_ill*0.25/working.Hospital_capacity);
                else
                    death_rate_multiplier = 1;
                end
                

            didtheysurvive = rand;
            
            risk_death = death_rate_multiplier*((normrnd(working.Death_rate_seriously_ill.mean,working.Death_rate_seriously_ill.std))...
                /population(yaxis_loop,xaxis_loop,5));
            
            data_record(time_days,7) = risk_death*working.Risk_of_serious_illness.mean; %instantaneous death rate

            
            if risk_death >working.Maximum_death_rate
                risk_death = working.Maximum_death_rate;
            end
                        
            if didtheysurvive < risk_death
                population(yaxis_loop,xaxis_loop,1) = 3; %fatality.
            end
            end
            
            
            %basically they spontaneously recover here after pop3+pop4 if
            %not dead or otherwise. for all.
            
            if population(yaxis_loop,xaxis_loop,2) >= population(yaxis_loop,xaxis_loop,3) + population(yaxis_loop,xaxis_loop,4)
                if population(yaxis_loop,xaxis_loop,1) == 1
                    mild_recovered = mild_recovered+1;
                elseif population(yaxis_loop,xaxis_loop,1) == 5
                    serious_recovered = serious_recovered+1;
                end
                
                population(yaxis_loop,xaxis_loop,1) = 2;
            end

            
           
            
            %time counter to work out how long the person has been infected
            if population(yaxis_loop,xaxis_loop,2) ~= 0.5
            population(yaxis_loop,xaxis_loop,2) = population(yaxis_loop,xaxis_loop,2)+1; %add 1 every day infected
            end
            
        end %end if infectious loop
    end %ends x and y axes
end

% %             if population(yaxis_loop,xaxis_loop,2) ~= 0.5
% %             population(yaxis_loop,xaxis_loop,2) = population(yaxis_loop,xaxis_loop,2)+1; %add 1 every day infected
% %             end

update_time = population(:,:,2);
update_time(update_time==0.5)=1;
population(:,:,2) = update_time;

% if max(population>=2)
%     recovered

save_matrix = population(:,:,1);
save_matrix_quarantine = population(:,:,6);
save_matrix_test_results = population(:,:,7);
save_matrix_total_tests = population(:,:,8);



data_record(time_days,1) = size(save_matrix(save_matrix==0),1); %Number susceptible
data_record(time_days,2) = size(save_matrix(save_matrix==1),1)+size(save_matrix(save_matrix==4),1)+size(save_matrix(save_matrix==5),1); %Number infected
data_record(time_days,3) = size(save_matrix(save_matrix==2),1); %Number recovered
data_record(time_days,4) = size(save_matrix(save_matrix==3),1); %Number died
data_record(time_days,5) = size(save_matrix(save_matrix==4),1); %Number asymptomatic
data_record(time_days,6) = size(save_matrix(save_matrix==5),1); %Number seriously ill
try 
data_record(time_days,7) = death_rate_multiplier*working.Death_rate_seriously_ill.mean; %instantaneous death rate
catch
    data_record(time_days,7) = working.Death_rate_seriously_ill.mean; %instantaneous death rate
end    
if data_record(time_days,7) > inputs.Maximum_death_rate
   data_record(time_days,7) = inputs.Maximum_death_rate*working.Risk_of_serious_illness.mean;
else
   data_record(time_days,7) = data_record(time_days,7)*working.Risk_of_serious_illness.mean; 
end
data_record(time_days,8) = size(save_matrix_quarantine(save_matrix_quarantine==1),1)+size(save_matrix_quarantine(save_matrix_quarantine==1),2); %Number self isolating
data_record(time_days,11) = size(save_matrix_test_results(save_matrix_test_results==3),1);%'false negatives' this day 
data_record(time_days,12) = size(save_matrix_test_results(save_matrix_test_results==4),1); %'false positives' this day
data_record(time_days,13) = imported_cases; %imported cases
if time_days > 1
data_record(time_days,14) = abs(((data_record(time_days,2) - data_record(time_days-1,2)))+((data_record(time_days,5) - data_record(time_days-1,5)))...
    +((data_record(time_days,3) - data_record(time_days-1,3)))+((data_record(time_days,6) - data_record(time_days-1,6)))...
    +((data_record(time_days,4) - data_record(time_days-1,4)))); %daily number of cases
data_record(time_days,15) = data_record(time_days,4) - data_record(time_days-1,4); %daily number of deaths
else
data_record(time_days,14) = data_record(time_days,2); %daily number of cases
data_record(time_days,15) = data_record(time_days,3); %daily number of deaths   
end
data_record(time_days,16) = lockdown_counter; %Is a lockdown in place?
data_record(time_days,17) = travel_ban_counter; %Is a travel ban in place?
if time_days > 1
data_record(time_days,10) = size(save_matrix_test_results(save_matrix_test_results==2),1)+...
    size(save_matrix_test_results(save_matrix_test_results==4),1)+...
    abs((data_record(time_days,6) - data_record(time_days-1,6))-serious_recovered-...
    (data_record(time_days,4) - data_record(time_days-1,4))); %'confirmed cases' this day 
else
    data_record(time_days,10) = size(save_matrix_test_results(save_matrix_test_results==2),1)+...
    size(save_matrix_test_results(save_matrix_test_results==4),1)+...
    size(save_matrix(save_matrix==5),1);
end
if time_days > 1
data_record(time_days,9) = data_record(time_days-1,9) + data_record(time_days,10) ; %Total confirmed caases
else
    data_record(time_days,9) = data_record(time_days,10);
end
if time_days > 1
data_record(time_days,18) = abs((data_record(time_days,6) - data_record(time_days-1,6))-serious_recovered-...
    (data_record(time_days,4) - data_record(time_days-1,4))); %New serious cases this day
else
    data_record(time_days,18) = data_record(time_days,6);
end

if strcmpi( inputs.Is_there_a_ND,'Yes')
 [mean_Rnumber,standard_deviation_Rnumber] = geoSIR_determine_reproductive_number(inputs,working,'Fiveday',...
    lockdown_counter,time_days,data_record,n_red,n_yellow,n_white,tot_red,tot_yellow,tot_white,...
    red_zone_increase_numtrips_close,yellow_zone_increase_numtrips_close,white_zone_increase_numtrips_close,...
    red_zone_increase_numtrips_distant,yellow_zone_increase_numtrips_distant,white_zone_increase_numtrips_distant, eruption_counter); 
else
  [mean_Rnumber,standard_deviation_Rnumber] = geoSIR_determine_reproductive_number(inputs,working,'Fiveday',...
    lockdown_counter,time_days,data_record); 
end
data_record(time_days,19) = mean_Rnumber; %Infections in 5 days
data_record(time_days,20) = standard_deviation_Rnumber; %Infections in 5 days




if strcmpi( inputs.Is_there_a_ND,'Yes')
 [mean_Rnumber2,standard_deviation_Rnumber2] = geoSIR_determine_reproductive_number(inputs,working,'Rzero',...
    lockdown_counter,time_days,data_record,n_red,n_yellow,n_white,tot_red,tot_yellow,tot_white,...
    red_zone_increase_numtrips_close,yellow_zone_increase_numtrips_close,white_zone_increase_numtrips_close,...
    red_zone_increase_numtrips_distant,yellow_zone_increase_numtrips_distant,white_zone_increase_numtrips_distant, eruption_counter); 
else
  [mean_Rnumber2,standard_deviation_Rnumber2] = geoSIR_determine_reproductive_number(inputs,working,'Rzero',...
    lockdown_counter,time_days,data_record); 
end
data_record(time_days,21) = mean_Rnumber2;  %Reproductive value
data_record(time_days,22) = standard_deviation_Rnumber2;  %Reproductive value


% % % if strcmpi(working.maximum_density,'Yes') || strcmpi(inputs.record_stats_critical,'Yes') ||...
% % %         strcmpi(inputs.record_stats_died,'Yes') || strcmpi(inputs.record_stats_recovered,'Yes')
% % % 
% % % %Record stats GRID
% % % 
% % % if (time_days+inputs.stats_time_interval-1)/inputs.stats_time_interval == round((time_days+inputs.stats_time_interval-1)/inputs.stats_time_interval)
% % %     
% % % for ygrid = 1:round((inputs.stats_grid_size/cellsize)):size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize))
% % %     for xgrid = 1:round((inputs.stats_grid_size/cellsize)):size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize))
% % %         
% % %         current_chip = population(ygrid:ygrid+round((inputs.stats_grid_size/cellsize))-1,xgrid:xgrid + round((inputs.stats_grid_size/cellsize))-1,1); %Cut out x km grid
% % %         
% % %         if size(current_chip(~isnan(current_chip)),1) > size_chip*0.5 % At least half of cells need to be in the area, else discarded
% % %         
% % %         if strcmpi(working.maximum_density,'Yes')    
% % %         stats_infected((ygrid-1)/round((inputs.stats_grid_size/cellsize)),(xgrid-1)/round((inputs.stats_grid_size/cellsize)),time_days+grid_counter)...
% % %             = size(current_chip(current_chip==1),1) + size(current_chip(current_chip==4),1) + size(current_chip(current_chip==5),1);
% % %         end
% % %         if strcmpi(inputs.record_stats_critical,'Yes')
% % %         stats_critical((ygrid-1)/round((inputs.stats_grid_size/cellsize)),(xgrid-1)/round((inputs.stats_grid_size/cellsize)),time_days+grid_counter)...
% % %             = size(current_chip(current_chip==5),1);
% % %         end
% % %         if strcmpi(inputs.record_stats_died,'Yes')
% % % 
% % %         stats_died((ygrid-1)/round((inputs.stats_grid_size/cellsize)),(xgrid-1)/round((inputs.stats_grid_size/cellsize)),time_days+grid_counter)...
% % %             = size(current_chip(current_chip==3),1);
% % %         end
% % %         if strcmpi(inputs.record_stats_recovered,'Yes')
% % %         stats_recovered((ygrid-1)/round((inputs.stats_grid_size/cellsize)),(xgrid-1)/round((inputs.stats_grid_size/cellsize)),time_days+grid_counter)...
% % %             = size(current_chip(current_chip==2),1);     
% % %         end
% % %                   
% % %         end
% % %         
% % %     end
% % % end
% % % grid_counter = grid_counter-inputs.stats_time_interval+1;
% % % end
% % % end




if time_days > 25 && time_days < working.Maximum_time - 30
if data_record(time_days,2) == data_record(time_days-1,2) && data_record(time_days,2) == data_record(time_days-2,2) && data_record(time_days,2) == data_record(time_days-3,2)||...
        data_record(time_days,3) == data_record(time_days-1,3) && data_record(time_days,3) == data_record(time_days-2,3) && data_record(time_days,3) == data_record(time_days-3,3)
    
    
    if final_day == working.Maximum_time
    final_day = time_days;
    end

    break;
    
end
end

end % end time loop


number_susceptible(:,iterations) = data_record(:,1);
number_infected(:,iterations) = data_record(:,2);
number_recovered(:,iterations) = data_record(:,3);
number_died(:,iterations) = data_record(:,4);
number_asymptomatic(:,iterations) = data_record(:,5);
number_seriously_ill(:,iterations) = data_record(:,6);
instantaneous_death_rate(:,iterations) = data_record(:,7);
number_self_isolating(:,iterations) = data_record(:,8);
cumulative_confirmed_cases(:,iterations) = data_record(:,9);
confirmed_daily_cases(:,iterations) = data_record(:,10);
number_false_negatives(:,iterations) = data_record(:,11);
number_false_positives(:,iterations) = data_record(:,12);
number_imported_cases(:,iterations) = data_record(:,13);
daily_cases_real(:,iterations) = data_record(:,14);
daily_deaths(:,iterations) = data_record(:,15);
lockdown_state(:,iterations) = data_record(:,16);
travel_ban_state(:,iterations) = data_record(:,17);
daily_seriously_ill(:,iterations) = data_record(:,18);
five_day_infection_rate_mean(:,iterations) = data_record(:,19);
five_day_infection_rate_std(:,iterations) = data_record(:,20);
reproductive_number_mean(:,iterations) = data_record(:,21);
reproductive_number_std(:,iterations) = data_record(:,22);


% % % if strcmpi(working.maximum_density,'Yes')    
% % % 
% % % for end_loop = 1:size(stats_infected,3)                                    %Find last real value, crop to it
% % %     temporary_isit_empty = stats_infected(:,:,end_loop);
% % %     if size(temporary_isit_empty(~isnan(temporary_isit_empty)),1) == 0
% % %         break;
% % %     end
% % % end
% % % 
% % % stats_infected(:,:,end_loop:end) = [];
% % % end
% % %  
% % % if strcmpi(inputs.record_stats_critical,'Yes')    
% % % 
% % % for end_loop = 1:size(stats_critical,3)                                    %Find last real value, crop to it
% % %     temporary_isit_empty = stats_critical(:,:,end_loop);
% % %     if size(temporary_isit_empty(~isnan(temporary_isit_empty)),1) == 0
% % %         break;
% % %     end
% % % end
% % % 
% % % stats_critical(:,:,end_loop:end) = [];
% % % end
% % %  
% % % if strcmpi(inputs.record_stats_died,'Yes')    
% % % 
% % % for end_loop = 1:size(stats_died,3)                                    %Find last real value, crop to it
% % %     temporary_isit_empty = stats_died(:,:,end_loop);
% % %     if size(temporary_isit_empty(~isnan(temporary_isit_empty)),1) == 0
% % %         break;
% % %     end
% % % end
% % % 
% % % stats_died(:,:,end_loop:end) = [];
% % % end
% % %  
% % % if strcmpi(inputs.record_stats_recovered,'Yes')    
% % % 
% % % for end_loop = 1:size(stats_recovered,3)                                    %Find last real value, crop to it
% % %     temporary_isit_empty = stats_recovered(:,:,end_loop);
% % %     if size(temporary_isit_empty(~isnan(temporary_isit_empty)),1) == 0
% % %         break;
% % %     end
% % % end
% % % 
% % % stats_recovered(:,:,end_loop:end) = [];
% % %  end


% % % if strcmpi(working.maximum_density,'Yes')    
% % % meta_stats_infected{iterations,1} = stats_infected;
% % % end
% % % if strcmpi(inputs.record_stats_critical,'Yes')
% % % meta_stats_critical{iterations,1} = stats_critical;
% % % end
% % % if strcmpi(inputs.record_stats_died,'Yes')    
% % % meta_stats_died{iterations,1} = stats_died;
% % % end
% % % if strcmpi(inputs.record_stats_recovered,'Yes')    
% % % meta_stats_recovered{iterations,1} = stats_recovered;
% % % end





end %end iterations loop

elseif strcmpi(inputs.Parralelize,'No')
    
for iterations = 1:inputs.Number_of_iterations  
    
    
    
  %% Create initial condition (1 infected at random spot middle)
population = population_temp;
   

final_day = inputs.Maximum_time;    
    

data_record = zeros(inputs.Maximum_time,13);

new_location_y = 1; %define these here for parpool
new_location_x = 1;

lockdown_counter = 0; %start these anew each iteration
travel_ban_counter = 0;
eruption_counter = 0;
working = inputs;      %change matrix name in able to not break the parralel loop


%Add eruption modifiers
    red_zone_increase_numtrips_close = 1;
    yellow_zone_increase_numtrips_close = 1;
    white_zone_increase_numtrips_close = 1;
    red_zone_increase_disttrips_close = 1;
    yellow_zone_increase_disttrips_close = 1;
    white_zone_increase_disttrips_close = 1;
    
    red_zone_increase_numtrips_distant = 1;
    yellow_zone_increase_numtrips_distant = 1;
    white_zone_increase_numtrips_distant = 1;
    red_zone_increase_disttrips_distant = 1;
    yellow_zone_increase_disttrips_distant = 1;
    white_zone_increase_disttrips_distant = 1;
    
    
% % % %Record statistics on a km x km grid
% % % if strcmpi(inputs.record_stats_infected,'Yes')
% % % stats_infected = NaN(floor((size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     floor((size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     ceil(inputs.Maximum_time/inputs.stats_time_interval));
% % % end
% % % 
% % % if strcmpi(inputs.record_stats_critical,'Yes')
% % % stats_critical = NaN(floor((size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     floor((size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     ceil(inputs.Maximum_time/inputs.stats_time_interval));
% % % end
% % % 
% % % if strcmpi(inputs.record_stats_died,'Yes')
% % % stats_died = NaN(floor((size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     floor((size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     ceil(inputs.Maximum_time/inputs.stats_time_interval));
% % % end
% % % 
% % % if strcmpi(inputs.record_stats_recovered,'Yes')
% % % stats_recovered = NaN(floor((size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     floor((size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize)))/round((inputs.stats_grid_size/cellsize))),...
% % %     ceil(inputs.Maximum_time/inputs.stats_time_interval));
% % % end

    
grid_counter = 0;


% loop over matrix
for time_days = 1:inputs.Maximum_time
    
if strcmpi(inputs.Is_there_a_ND,'Yes') %IF there is an eruption
        
    if eruption_counter >0
        if eruption_counter <=inputs.duration_of_ND_disruption
            eruption_counter = eruption_counter+1;
        elseif eruption_counter >inputs.duration_of_ND_disruption
            %reset counter to zero
            eruption_counter  = 0;
            
            %Reset mobility multipliers to baseline
            red_zone_increase_numtrips_close = 1;
            yellow_zone_increase_numtrips_close = 1;
            white_zone_increase_numtrips_close = 1;
            red_zone_increase_disttrips_close = 1;
            yellow_zone_increase_disttrips_close = 1;
            white_zone_increase_disttrips_close = 1;
    
            red_zone_increase_numtrips_distant = 1;
            yellow_zone_increase_numtrips_distant = 1;
            white_zone_increase_numtrips_distant = 1;
            red_zone_increase_disttrips_distant = 1;
            yellow_zone_increase_disttrips_distant = 1;
            white_zone_increase_disttrips_distant = 1;
            
            %Remove 'evacuee' status 
            evacuees_matrix = population(:,:,9);
            evacuees_matrix(evacuees_matrix~=0)=0;
            population(:,:,9) = evacuees_matrix;
        end
    end
if time_days == inputs.ND_time
    
    eruption_counter = 1;
    %Case 1: Increase number of trips in red and yellow zones, people stay in place
    if inputs.ND_case == 1
    
        %https://www.pnas.org/content/109/29/11576

    red_zone_increase_numtrips_close = 3;
    yellow_zone_increase_numtrips_close = 3;
    white_zone_increase_numtrips_close = 1.5;
    red_zone_increase_disttrips_close = 3;
    yellow_zone_increase_disttrips_close = 3;
    white_zone_increase_disttrips_close = 1.5;
    
    red_zone_increase_numtrips_distant = 3;
    yellow_zone_increase_numtrips_distant = 3;
    white_zone_increase_numtrips_distant = 1.5;
    red_zone_increase_disttrips_distant = 3;
    yellow_zone_increase_disttrips_distant = 3;
    white_zone_increase_disttrips_distant = 1.5;
    
    

    
    %Case 2:Evacuate everyone in red, mobility remains the same. Note
    %requirement: there is enough empty space (low enough pop density) that
    %everyone can be relocated to empty space!
    elseif inputs.ND_case == 2
    
        
             %Evacuate red and 25% yellow zones    
    for yaxis_loop_evacuation = 1:size(population,1)
    for xaxis_loop_evacuation = 1:size(population,2)
    if hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 2 %RED zone
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 2; %Tracer for evacuees from RED zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
            
    elseif hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 1 %Yellow zone
            are_they_evacuated = rand;
            
            if are_they_evacuated < 0.25 %25% evacuees
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 1; %Tracer for evacuees from YELLOW zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
            end
    end
    end
    end
    
    
    
    

    
    %Case 3: Evacuate all in red and increase mobility in red and yellow
    elseif inputs.ND_case == 3
     
        
        
        
        %Evacuate red zone
    for yaxis_loop_evacuation = 1:size(population,1)
    for xaxis_loop_evacuation = 1:size(population,2)
        
        if hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 2 && population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)~= -1 ...
            && ~isnan(population(yaxis_loop_evacuation,xaxis_loop_evacuation,1))
            
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 2; %Tracer for evacuees from RED zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
         end
    end
    end
        
        
        
    %Adjust mobilities
        
        %https://www.pnas.org/content/109/29/11576

    red_zone_increase_numtrips_close = 3;
    yellow_zone_increase_numtrips_close = 3;
    white_zone_increase_numtrips_close = 1.5;
    red_zone_increase_disttrips_close = 3;
    yellow_zone_increase_disttrips_close = 3;
    white_zone_increase_disttrips_close = 1.5;
    
    red_zone_increase_numtrips_distant = 3;
    yellow_zone_increase_numtrips_distant = 3;
    white_zone_increase_numtrips_distant = 1.5;
    red_zone_increase_disttrips_distant = 3;
    yellow_zone_increase_disttrips_distant = 3;
    white_zone_increase_disttrips_distant = 1.5;
        
        
        
        
        
        
        
        
        
        
        
        
    %Case 4: Evacuate all in red, 25% yellow and increase mobility in red, and yellow
    %and entire region
    elseif inputs.ND_case == 4    
    
        
    %Evacuate red and 25% yellow zones    
    for yaxis_loop_evacuation = 1:size(population,1)
    for xaxis_loop_evacuation = 1:size(population,2)
    if hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 2 && population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)~= -1 ...
            && ~isnan(population(yaxis_loop_evacuation,xaxis_loop_evacuation,1))
            %RED zone
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 2; %Tracer for evacuees from RED zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
            
    elseif hazard_zones(yaxis_loop_evacuation,xaxis_loop_evacuation) == 1 && population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)~= -1 ...
            && ~isnan(population(yaxis_loop_evacuation,xaxis_loop_evacuation,1))
            %Yellow zone
            are_they_evacuated = rand;
            
            if are_they_evacuated < 0.25 %25% evacuees
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            while population(y_evacuated_to,x_evacuated_to,1)~=-1 || hazard_zones(y_evacuated_to,x_evacuated_to) == 2
            y_evacuated_to = ceil(rand*size(hazard_zones,1));
            x_evacuated_to = ceil(rand*size(hazard_zones,1));
            end
            population(y_evacuated_to,x_evacuated_to,1) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,1); %Evacuate the person and all associated information
            population(y_evacuated_to,x_evacuated_to,2) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,2);
            population(y_evacuated_to,x_evacuated_to,3) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,3);
            population(y_evacuated_to,x_evacuated_to,4) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,4);
            population(y_evacuated_to,x_evacuated_to,5) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,5);
            population(y_evacuated_to,x_evacuated_to,6) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,6);
            population(y_evacuated_to,x_evacuated_to,7) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,7);
            population(y_evacuated_to,x_evacuated_to,8) = population(yaxis_loop_evacuation,xaxis_loop_evacuation,8);
            population(y_evacuated_to,x_evacuated_to,9) = 1; %Tracer for evacuees from YELLOW zone
            
            %Make prior cell empty space
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,1)=-1; 
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,2)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,3)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,4)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,5)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,6)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,7)=0;
            population(yaxis_loop_evacuation,xaxis_loop_evacuation,8)=0;
            end
    end
    end
    end
        
        
        
    %Adjust mobilities
        
        %https://www.pnas.org/content/109/29/11576

    red_zone_increase_numtrips_close = 3;
    yellow_zone_increase_numtrips_close = 3;
    white_zone_increase_numtrips_close = 1.5;
    red_zone_increase_disttrips_close = 3;
    yellow_zone_increase_disttrips_close = 3;
    white_zone_increase_disttrips_close = 1.5;
    
    red_zone_increase_numtrips_distant = 3;
    yellow_zone_increase_numtrips_distant = 3;
    white_zone_increase_numtrips_distant = 1.5;
    red_zone_increase_disttrips_distant = 3;
    yellow_zone_increase_disttrips_distant = 3;
    white_zone_increase_disttrips_distant = 1.5; 
    
    
   
        
        
        
        
        
        
        
        
        
        
        
    end     
end
end
    
    
    
    if eruption_counter > 0 && lockdown_counter ~= 0
    %Exit lockdown
    if lockdown_counter == 1 &&...
            (data_record(time_days-1,14) <= working.Confirmed_cases_lockdown_exit &&...
             data_record(time_days-1,15) <= working.Deaths_lockdown_exit)
                
         working.Proportion_non_symptomatic_self_isolation = working.backup.Proportion_non_symptomatic_self_isolation;
         working.Proportion_symptomatic_self_isolation = working.backup.Proportion_symptomatic_self_isolation;
         
         working.Distance_travelled_for_close_encounters = working.backup.Distance_travelled_for_close_encounters;
         working.Distance_travelled_for_distant_encounters = working.backup.Distance_travelled_for_distant_encounters;
    
         lockdown_counter = 0;
    end  
    elseif eruption_counter  == 0
     %Exit lockdown
    if lockdown_counter == 1 &&...
            (data_record(time_days-1,14) <= working.Confirmed_cases_lockdown_exit &&...
             data_record(time_days-1,15) <= working.Deaths_lockdown_exit)
                
         working.Proportion_non_symptomatic_self_isolation = working.backup.Proportion_non_symptomatic_self_isolation;
         working.Proportion_symptomatic_self_isolation = working.backup.Proportion_symptomatic_self_isolation;
         
         working.Distance_travelled_for_close_encounters = working.backup.Distance_travelled_for_close_encounters;
         working.Distance_travelled_for_distant_encounters = working.backup.Distance_travelled_for_distant_encounters;
    
         lockdown_counter = 0;
    end   
    
    %Enter into lockdown
    if time_days > 1 && strcmpi(working.Is_a_lockdown_implemented,'Yes') && lockdown_counter == 0 &&...
            (data_record(time_days-1,14) >= working.Confirmed_cases_lockdown_threshold ||...
             data_record(time_days-1,15) >= working.Deaths_lockdown_threshold)
         
         working.backup.Proportion_non_symptomatic_self_isolation = working.Proportion_non_symptomatic_self_isolation;
         working.backup.Proportion_symptomatic_self_isolation = working.Proportion_symptomatic_self_isolation;
         working.backup.Distance_travelled_for_close_encounters = working.Distance_travelled_for_close_encounters;
         working.backup.Distance_travelled_for_distant_encounters = working.Distance_travelled_for_distant_encounters;
         
         working.Proportion_non_symptomatic_self_isolation = working.Lockdown_proportion_non_symptomatic;
         
         working.Proportion_symptomatic_self_isolation = working.Lockdown_proportion_symptomatic;
         
         working.Distance_travelled_for_close_encounters.min = round(working.Distance_travelled_for_close_encounters.min/inputs.Distance_moved_reduction_factor);
         working.Distance_travelled_for_close_encounters.max = round(working.Distance_travelled_for_close_encounters.max/inputs.Distance_moved_reduction_factor);
         
         working.Distance_travelled_for_distant_encounters.min = round(working.Distance_travelled_for_distant_encounters.min/inputs.Distance_moved_reduction_factor);
         working.Distance_travelled_for_distant_encounters.max = round(working.Distance_travelled_for_distant_encounters.max/inputs.Distance_moved_reduction_factor);
         
         if working.Distance_travelled_for_close_encounters.min == 0
             working.Distance_travelled_for_close_encounters.min = 1;
         end
         
         if working.Distance_travelled_for_close_encounters.max == 0
             working.Distance_travelled_for_close_encounters.max = 1;
         end
         
         if working.Distance_travelled_for_distant_encounters.min == 0
             working.Distance_travelled_for_distant_encounters.min = 1;
         end
         
         if working.Distance_travelled_for_distant_encounters.max == 0
             working.Distance_travelled_for_distant_encounters.max = 1;
         end
         
         lockdown_counter = 1;
    end
    
    end     %end eruption counter condition
   
    %Exit travel_ban_condition
    if travel_ban_counter == 1 &&...
            (data_record(time_days-1,14) <= working.Confirmed_cases_travel_ban_exit &&...
             data_record(time_days-1,15) <= working.Deaths_travel_ban_exit)
    
         travel_ban_counter = 0;
    end
       
    %Enter into travel_ban_condition
    if time_days > 1 && strcmpi(working.Is_a_travel_ban_implemented,'Yes') && travel_ban_counter == 0 &&...
            (data_record(time_days-1,14) >= working.Confirmed_cases_travel_ban_threshold ||...
             data_record(time_days-1,15) >= working.Deaths_travel_ban_threshold)
    
         travel_ban_counter = 1;
    end
    
    
    
    
    
    
    if travel_ban_counter == 0 %Only if no travel ban
    
        
    %Travellers come in and leave
        
    number_incoming_travellers = round(working.Number_of_travellers_in.min...
        + rand*(working.Number_of_travellers_in.max-working.Number_of_travellers_in.min));
    
    number_outgoing_travellers = round(working.Number_of_travellers_out.min...
        + rand*(working.Number_of_travellers_out.max-working.Number_of_travellers_out.min));
    
    imported_cases = 0;
    
    
    if strcmpi(working.traveller_only_to_empty_cells, 'Yes')
    
%     incoming loop
    for incoming_loop = 1:number_incoming_travellers
        y_position_travel = ceil(rand*size(population,1));
        x_position_travel = ceil(rand*size(population,2));
        traveller_not_arrived = 0;
        while traveller_not_arrived ==0
        if population(y_position_travel,x_position_travel,1)==-1
            chance_infected = (working.Fraction_of_infected_travellers.min...
        + rand*(working.Fraction_of_infected_travellers.max-working.Fraction_of_infected_travellers.min));
             is_the_traveller_infected = rand;
           if is_the_traveller_infected < chance_infected
               population(y_position_travel,x_position_travel,1) = 1;
               population(y_position_travel,x_position_travel,2) = 0.5;
               imported_cases = imported_cases+1;
           else
               population(y_position_travel,x_position_travel,1) = 0;
           end
           traveller_not_arrived = 1;
        else
        y_position_travel = ceil(rand*size(population,1));
        x_position_travel = ceil(rand*size(population,2));  
        end
        end %end while

    end %end incoming loop
    
    %     outgoing loop
    for outgoing_loop = 1:number_outgoing_travellers
        y_position_exit = ceil(rand*size(population,1));
        x_position_exit = ceil(rand*size(population,2));
        traveller_not_left = 0;
        while traveller_not_left ==0
        if population(y_position_exit,x_position_exit,1)== -1
        y_position_exit = ceil(rand*size(population,1));
        x_position_exit = ceil(rand*size(population,2));   
        else
        if population(y_position_exit,x_position_exit,1)~=3  
           population(y_position_exit,x_position_exit,1) = -1;
           
           traveller_not_left = 1;
        end
        end
        end %end while

    end %end outgoing loop
    
    else
     %     incoming loop
    for incoming_loop = 1:number_incoming_travellers
        y_position_travel = ceil(rand*size(population,1));
        x_position_travel = ceil(rand*size(population,2));
        
        traveller_not_arrived = 0;
        while traveller_not_arrived ==0
        if population(y_position_travel,x_position_travel,1)~=3 && ~isnan(population(y_position_travel,x_position_travel,1))
                probability_cell_full = rand;
            
            if probability_cell_full < working.Population_density
            chance_infected = (working.Fraction_of_infected_travellers.min...
          + rand*(working.Fraction_of_infected_travellers.max-working.Fraction_of_infected_travellers.min));
             is_the_traveller_infected = rand;
           if is_the_traveller_infected < chance_infected
               population(y_position_travel,x_position_travel,1) = 1;
               population(y_position_travel,x_position_travel,2) = 0.5;
               imported_cases = imported_cases+1;
           else
               population(y_position_travel,x_position_travel,1) = 0;
           end
            else
           population(y_position_travel,x_position_travel,1) = -1;
            end
            traveller_not_arrived = 1;
        else 
        y_position_travel = ceil(rand*size(population,1));
        x_position_travel = ceil(rand*size(population,2));  
        end
        end    


    end %end incoming loop
    
    %     outgoing loop
    for outgoing_loop = 1:number_outgoing_travellers
        y_position_exit = ceil(rand*size(population,1));
        x_position_exit = ceil(rand*size(population,2));
        
        traveller_not_left = 0;
        while traveller_not_left ==0
        if population(y_position_exit,x_position_exit,1)~=3 && ~isnan(population(y_position_travel,x_position_travel,1))
        probability_cell_full = rand;
            
            if probability_cell_full < working.Population_density
            population(y_position_exit,x_position_exit,1) = 0;
            else
           population(y_position_exit,x_position_exit,1) = -1;
            end
        traveller_not_left=1;
        else 
        y_position_exit = ceil(rand*size(population,1));
        x_position_exit = ceil(rand*size(population,2));  
        end
        end


    end %end outgoing loop
    
    end
    
    end
        
    
    %Work out who is self isolating today. Starts at day 2. 
    %Conduct testing.
    
    if time_days > 1
    
    current_state_matrix = population(:,:,1);
    symptomatic_state_matrix = population(:,:,2)./population(:,:,3);
    
    %%%Non Symptomatic patients
    non_symptomatic_locations = current_state_matrix;
    
    non_symptomatic_locations(current_state_matrix==1) = -9; %all infected
    
    non_symptomatic_locations(symptomatic_state_matrix > 1) = 1; %remove those with symptoms
    
    non_symptomatic_locations(current_state_matrix==4) = -9; %add the asymptomatic cases
    
    %%%Symptomatic patients
    symptomatic_locations = current_state_matrix;
    
    symptomatic_locations(current_state_matrix==1) = -9; %all infected
    
    symptomatic_locations(symptomatic_state_matrix <= 1) = 1; %remove those in incubation period
    
    % -9 values mark those non symptomatic or symptomatic. Convert to
    % something more usable.
    
    non_symptomatic_locations(non_symptomatic_locations ~= -9) = 0;
    non_symptomatic_locations(non_symptomatic_locations == -9) = 1;
    
    symptomatic_locations(symptomatic_locations ~= -9) = 0;
    symptomatic_locations(symptomatic_locations == -9) = 1;
    
    non_symptomatic_self_isolating = non_symptomatic_locations.*rand(size(non_symptomatic_locations));
    non_symptomatic_self_isolating(non_symptomatic_self_isolating>working.Proportion_non_symptomatic_self_isolation.min...
        + rand*(working.Proportion_non_symptomatic_self_isolation.max-working.Proportion_non_symptomatic_self_isolation.min))...
        =0;
    non_symptomatic_self_isolating(non_symptomatic_self_isolating>0) = 1;
        
    symptomatic_self_isolating = symptomatic_locations.*rand(size(symptomatic_locations));
    symptomatic_self_isolating(symptomatic_self_isolating>working.Proportion_symptomatic_self_isolation.min...
        + rand*(working.Proportion_symptomatic_self_isolation.max-working.Proportion_symptomatic_self_isolation.min))...
        =0;
    symptomatic_self_isolating(symptomatic_self_isolating>0) = 2;
    
    self_isolation_grid = non_symptomatic_self_isolating+symptomatic_self_isolating; %load to layer. 2 is stricter symptomatic self isolation.
    
    
    number_of_tests_conducted_symptomatic = working.Number_of_tests_conducted_symptomatic.min...
        + rand*(working.Number_of_tests_conducted_symptomatic.max-working.Number_of_tests_conducted_symptomatic.min);
    
    number_of_tests_conducted_non_symptomatic = working.Number_of_tests_conducted_non_symptomatic.min...
        + rand*(working.Number_of_tests_conducted_non_symptomatic.max-working.Number_of_tests_conducted_non_symptomatic.min);
    
    false_positive_rate = working.Test_false_positive_rate.min...
        + rand*(working.Test_false_positive_rate.max-working.Test_false_positive_rate.min);
    
    false_negative_rate = working.Test_false_negative_rate.min...
        + rand*(working.Test_false_negative_rate.max-working.Test_false_negative_rate.min);
    
    probability_of_being_tested_symptomatic = number_of_tests_conducted_symptomatic/sum(symptomatic_locations,'all');
    
    %Make a new matrix of locations of 'susceptible' people 
    
    susceptible_state_locations = current_state_matrix;
    
    susceptible_state_locations(current_state_matrix==0) = -9; %add the susceptible
       
    susceptible_state_locations(susceptible_state_locations ~= -9) = 0;
    susceptible_state_locations(susceptible_state_locations == -9) = 1;    
    
    probability_of_being_tested_non_symptomatic = number_of_tests_conducted_non_symptomatic...
        /(sum(susceptible_state_locations,'all')+sum(non_symptomatic_locations,'all'));
    
    if probability_of_being_tested_symptomatic > 1  %cannot be larger than one
        probability_of_being_tested_symptomatic = 1;
    end
    if probability_of_being_tested_non_symptomatic > 1
        probability_of_being_tested_non_symptomatic = 1;
    end
    
    %Results of the tests
    
    
    
    test_results_symptomatic = symptomatic_locations.*rand(size(symptomatic_locations));
    test_results_symptomatic(test_results_symptomatic == 0) = 9;
    test_results_symptomatic(test_results_symptomatic < probability_of_being_tested_symptomatic*false_negative_rate) =-9; %False Negatives
    test_results_symptomatic(test_results_symptomatic == 9) = 0;
    test_results_symptomatic(test_results_symptomatic > probability_of_being_tested_symptomatic) = 0 ; 
    test_results_symptomatic(test_results_symptomatic>0) = 2;  %2 = test is positive
    test_results_symptomatic(test_results_symptomatic==-9) = 3; %3 = false negative
    
    test_results_non_symptomatic = non_symptomatic_locations.*rand(size(symptomatic_locations));
    test_results_non_symptomatic(test_results_non_symptomatic == 0) = 9;
    test_results_non_symptomatic(test_results_non_symptomatic < probability_of_being_tested_non_symptomatic*false_negative_rate) =-9; %False Negatives
    test_results_non_symptomatic(test_results_non_symptomatic == 9) = 0;
    test_results_non_symptomatic(test_results_non_symptomatic > probability_of_being_tested_non_symptomatic) = 0 ; 
    test_results_non_symptomatic(test_results_non_symptomatic>0) = 2;  %2 = test is positive
    test_results_non_symptomatic(test_results_non_symptomatic==-9) = 3; %3 = false negative
    
    test_results_susceptible = susceptible_state_locations.*rand(size(symptomatic_locations));
    test_results_susceptible(test_results_susceptible == 0) = 9;
    test_results_susceptible(test_results_susceptible < probability_of_being_tested_non_symptomatic*false_positive_rate) =-9; %False Positives
    test_results_susceptible(test_results_susceptible == 9) = 0;
    test_results_susceptible(test_results_susceptible > probability_of_being_tested_non_symptomatic) = 0 ; 
    test_results_susceptible(test_results_susceptible>0) = 1;  %1 = test is negative
    test_results_susceptible(test_results_susceptible==-9) = 4; %4 = false positive
    
    population(:,:,7) = test_results_symptomatic+test_results_non_symptomatic+test_results_susceptible; %test results loaded
    
    %Adjust self isolation behaviour dependant on test results
    self_isolation_grid(population(:,:,7)==1) = 0;
    self_isolation_grid(population(:,:,7)==3) = 0;
    self_isolation_grid(population(:,:,7)==2) = 2;
    self_isolation_grid(population(:,:,7)==4) = 2;
    
    apparent_positives = population(:,:,7);
    apparent_positives(apparent_positives==1) = 0; 
    apparent_positives(apparent_positives==3) = 0;
    apparent_positives(population(:,:,7)==5)=1;
    
    population(:,:,8) = population(:,:,8) + apparent_positives;
        
    population(:,:,6) = self_isolation_grid; %load to layer. 2 is stricter symptomatic self isolation.

    
    
    end
    
   mild_recovered = 0;
   serious_recovered = 0;
    
    
   
    
for yaxis_loop = 1:size(population,1)
    for xaxis_loop = 1:size(population,2)
        
        %IF 0, they are succeptible
        
        %IF they are infectious
        if floor(population(yaxis_loop,xaxis_loop,1))== 1 || floor(population(yaxis_loop,xaxis_loop,1))== 4 || floor(population(yaxis_loop,xaxis_loop,1))== 5
            
            %create two layers for incubation time and time infected (if
            %they do not already exist).
            if population(yaxis_loop,xaxis_loop,3) == 0 || population(yaxis_loop,xaxis_loop,4) == 0
               
                population(yaxis_loop,xaxis_loop,3) = ceil(abs(normrnd(working.Incubation_time.mean,working.Incubation_time.sd)));
                
                population(yaxis_loop,xaxis_loop,4) = ceil(abs(normrnd(working.Length_of_illness.mean,working.Length_of_illness.sd)));
                
            end
            
            %they may encounter other people and infect them
            
           %%%%%%%%%%%Determine multipliers for all the different stats
           if strcmpi(inputs.Is_there_a_ND,'Yes') && eruption_counter > 0
             if hazard_zones(  yaxis_loop,xaxis_loop) == 2 || population(yaxis_loop,xaxis_loop,9) == 2
        
               n_enouncounters_close_multiplier = red_zone_increase_numtrips_close;
               d_enouncounters_close_multiplier = red_zone_increase_disttrips_close;
               n_enouncounters_distant_multiplier = red_zone_increase_numtrips_distant;
               d_enouncounters_distant_multiplier = red_zone_increase_disttrips_distant;
                 
             elseif hazard_zones(  yaxis_loop,xaxis_loop) == 1 || population(yaxis_loop,xaxis_loop,9) == 1    
                
               n_enouncounters_close_multiplier = yellow_zone_increase_numtrips_close;
               d_enouncounters_close_multiplier = yellow_zone_increase_disttrips_close;
               n_enouncounters_distant_multiplier = yellow_zone_increase_numtrips_distant;
               d_enouncounters_distant_multiplier = yellow_zone_increase_disttrips_distant;
                 
            elseif hazard_zones(  yaxis_loop,xaxis_loop) == 0 && population(yaxis_loop,xaxis_loop,9) == 0   
               
               n_enouncounters_close_multiplier = white_zone_increase_numtrips_close;
               d_enouncounters_close_multiplier = white_zone_increase_disttrips_close;
               n_enouncounters_distant_multiplier = white_zone_increase_numtrips_distant;
               d_enouncounters_distant_multiplier = white_zone_increase_disttrips_distant;   
                
             end
           else
               n_enouncounters_close_multiplier = 1;
               d_enouncounters_close_multiplier = 1;
               n_enouncounters_distant_multiplier = 1;
               d_enouncounters_distant_multiplier = 1;
           end
            
           %%%%%%%%%%%%%%CLOSE ENCOUNTERS
           
           %determine number of close encounters
           if population(yaxis_loop,xaxis_loop,6) == 0
           number_of_encounters_close = round(n_enouncounters_close_multiplier*(working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min)));
           elseif population(yaxis_loop,xaxis_loop,6) == 1
           number_of_encounters_close = round(n_enouncounters_close_multiplier*((working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min))*...
               (1-(working.Efficiency_of_non_symptomatic_self_isolation.min +rand*(...
               working.Efficiency_of_non_symptomatic_self_isolation.max-working.Efficiency_of_non_symptomatic_self_isolation.min)))));           
           elseif population(yaxis_loop,xaxis_loop,6) == 2
           number_of_encounters_close = round(n_enouncounters_close_multiplier*((working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min))*...
               (1-(working.Efficiency_of_symptomatic_self_isolation.min +rand*(...
               working.Efficiency_of_symptomatic_self_isolation.max-working.Efficiency_of_symptomatic_self_isolation.min)))));     
           end
           if number_of_encounters_close > 0
            for encounter_loop = 1:number_of_encounters_close
                
                %Person encountered. Various conditions to deal with
                %distance from edge of box.
                
                traveled_this_day = round(d_enouncounters_close_multiplier*(working.Distance_travelled_for_close_encounters.min + ...
                    rand*(working.Distance_travelled_for_close_encounters.max-working.Distance_travelled_for_close_encounters.min)));
                
                if (yaxis_loop+round((2*(traveled_this_day)*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1)) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %all OK
                new_location_y = yaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                new_location_x = xaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                elseif (yaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1)) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0
                    %all sides out of range, infects random spot within
                    %total population
                new_location_y = ceil(size(population,1)*rand);
                new_location_x = ceil(size(population,1)*rand);
                elseif (yaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1)) &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0
                    %y too high, x too low
                new_location_y = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                new_location_x = ceil(traveled_this_day*rand);
                elseif(yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1)) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0 
                    %x too high, y too low
                new_location_y = ceil(traveled_this_day*rand);
                new_location_x = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0
                    %y too low, x too low 
                new_location_y = ceil(traveled_this_day*rand);
                new_location_x = ceil(traveled_this_day*rand);
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %y too high, x too high 
                new_location_y = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                new_location_x = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %y too high, x OK 
                new_location_y = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                new_location_x = xaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %y too low, x OK 
                new_location_y = ceil(traveled_this_day*rand);
                new_location_x = xaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) > size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) > 0
                    %y OK, x too high 
                new_location_y = yaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                new_location_x = (size(population,1)-traveled_this_day) + ceil(traveled_this_day*rand);
                elseif yaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*traveled_this_day*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*traveled_this_day*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*traveled_this_day*(-0.5))) <= 0
                    %y OK, x too low 
                new_location_y = yaxis_loop+round((2*traveled_this_day*(0.5-rand)));
                new_location_x = ceil(traveled_this_day*rand);
                end
                
                %If person exists (not out of range) and is suceptible
                
                if ((new_location_y >= 1) && (new_location_y <= size(population,1))) &&...
                        ((new_location_x >= 1) && (new_location_x <= size(population,2)))

                    if population(new_location_y,new_location_x,1) == 0
                    
                aretheyinfected = rand;
                
               if aretheyinfected < normrnd(working.Probability_of_infection_for_close_encounters.mean,working.Probability_of_infection_for_close_encounters.std)
                   aretheyasymptomatic = rand;
                   if aretheyasymptomatic < normrnd(working.Proportion_asymptomatic.mean,working.Proportion_asymptomatic.std)
                   population(new_location_y,new_location_x,1) = 4;
                   population(new_location_y,new_location_x,2) = 0.5; %this value to start the counter at the next day for all recently infected cases
                   else
                   population(new_location_y,new_location_x,1) = 1;
                   population(new_location_y,new_location_x,2) = 0.5; %this value to start the counter at the next day for all recently infected cases
                   end
               end
                    end
                end

            end
           end
            
            %%%%%%%%%%%%%%DISTANT ENCOUNTERS

            
            %determine number of distant encounters
           if population(yaxis_loop,xaxis_loop,6) == 0
           number_of_encounters_distant = round(n_enouncounters_distant_multiplier*(working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min)));
           elseif population(yaxis_loop,xaxis_loop,6) == 1
           number_of_encounters_distant = round(n_enouncounters_distant_multiplier*((working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min))*...
               (1-(working.Efficiency_of_non_symptomatic_self_isolation.min +rand*(...
               working.Efficiency_of_non_symptomatic_self_isolation.max-working.Efficiency_of_non_symptomatic_self_isolation.min)))));           
           elseif population(yaxis_loop,xaxis_loop,6) == 2
           number_of_encounters_distant = round(n_enouncounters_distant_multiplier*((working.Number_of_close_encounters.min + ...
               rand*(working.Number_of_close_encounters.max-working.Number_of_close_encounters.min))*...
               (1-(working.Efficiency_of_symptomatic_self_isolation.min +rand*(...
               working.Efficiency_of_symptomatic_self_isolation.max-working.Efficiency_of_symptomatic_self_isolation.min)))));     
           end
           if number_of_encounters_distant > 0
            
            
            for encounter_loop = 1:number_of_encounters_distant
                
                 long_distance_today = round(d_enouncounters_distant_multiplier*(working.Distance_travelled_for_distant_encounters.min +...
                     rand*(working.Distance_travelled_for_distant_encounters.max-working.Distance_travelled_for_distant_encounters.min)));           
                            
                %Person encountered. Various conditions to deal with
                %distance from edge of box.
                if (yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1)) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %all OK
                new_location_y = yaxis_loop+round((2*long_distance_today*(0.5-rand)));
                new_location_x = xaxis_loop+round((2*long_distance_today*(0.5-rand)));
                elseif (yaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1)) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) <= 0
                    %all sides out of range, infects random spot within
                    %total population
                new_location_y = ceil(size(population,1)*rand);
                new_location_x = ceil(size(population,1)*rand);
                elseif (yaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1)) &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) <= 0
                    %y too high, x too low
                new_location_y = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                new_location_x = ceil(long_distance_today*rand);
                elseif(yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1)) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) <= 0 
                    %x too high, y too low
                new_location_y = ceil(long_distance_today*rand);
                new_location_x = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) <= 0
                    %y too low, x too low 
                new_location_y = ceil(long_distance_today*rand);
                new_location_x = ceil(long_distance_today*rand);
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %y too high, x too high 
                new_location_y = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                new_location_x = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %y too high, x OK 
                new_location_y = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                new_location_x = xaxis_loop+round((2*long_distance_today*(0.5-rand)));
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) <= 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %y too low, x OK 
                new_location_y = ceil(long_distance_today*rand);
                new_location_x = xaxis_loop+round((2*long_distance_today*(0.5-rand)));
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) > size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) > 0
                    %y OK, x too high 
                new_location_y = yaxis_loop+round((2*long_distance_today*(0.5-rand)));
                new_location_x = (size(population,1)-long_distance_today) + ceil(long_distance_today*rand);
                elseif yaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        xaxis_loop+round((2*long_distance_today*(0.5))) <= size(population,1) &&...
                        yaxis_loop+round((2*long_distance_today*(-0.5))) > 0 &&...
                        xaxis_loop+round((2*long_distance_today*(-0.5))) <= 0
                    %y OK, x too low 
                new_location_y = yaxis_loop+round((2*long_distance_today*(0.5-rand)));
                new_location_x = ceil(long_distance_today*rand);
                end
                
                %If person exists (not out of range) and is suceptible
                if ((new_location_y >= 1) && (new_location_y <= size(population,1))) &&...
                        ((new_location_x >= 1) && (new_location_x <= size(population,2)))
                    if population(new_location_y,new_location_x) == 0
                    
                aretheyinfected = rand;
                
               if aretheyinfected < normrnd(working.Probability_of_infection_for_distant_encounters.mean,working.Probability_of_infection_for_distant_encounters.std)
                   aretheyasymptomatic = rand;
                   if aretheyasymptomatic < normrnd(working.Proportion_asymptomatic.mean,working.Proportion_asymptomatic.std)
                   population(new_location_y,new_location_x,1) = 4;
                   population(new_location_y,new_location_x,2) = 0.5; %this value to start the counter at the next day for all recently infected cases
                   else
                   population(new_location_y,new_location_x,1) = 1;
                   population(new_location_y,new_location_x,2) = 0.5; %this value to start the counter at the next day for all recently infected cases
                   end           
               end
                    end
               end
            end
           end
            
            
            %Regular infected people may transition to Seriously infected 
            if  population(yaxis_loop,xaxis_loop,1) == 1 && population(yaxis_loop,xaxis_loop,2)...
                    > population(yaxis_loop,xaxis_loop,3)
                
            aretheyserious = rand;
            
            risk_serious_illness = (normrnd(working.Risk_of_serious_illness.mean,working.Risk_of_serious_illness.std))...
                /(population(yaxis_loop,xaxis_loop,4));
                        
            if aretheyserious < risk_serious_illness
                population(yaxis_loop,xaxis_loop,1) = 5;
                population(yaxis_loop,xaxis_loop,5) = (population(yaxis_loop,xaxis_loop,4)...
                    +population(yaxis_loop,xaxis_loop,3))-population(yaxis_loop,xaxis_loop,2); %Time remaining as critically ill
            end
            end
            
            %Seriously infected people may die
            if  population(yaxis_loop,xaxis_loop,1) ==5 
                
                number_serious_ill_matrix = population(:,:,1);
                number_serious_ill = size(number_serious_ill_matrix(number_serious_ill_matrix==5),1);
                
                %https://jamanetwork.com/journals/jama/article-abstract/2762130?fbclid=IwAR3VO06Zl4FQxcHZKISBSzyfhmYP12BsHRK64VcI1JPCnoNF6vH59wYneUY
                if number_serious_ill*0.25 > working.Hospital_capacity  %Quarter total seriously ill in hospital
                    death_rate_multiplier = working.Sensitivity_to_overcrowding*(number_serious_ill*0.25/working.Hospital_capacity);
                else
                    death_rate_multiplier = 1;
                end
                

            didtheysurvive = rand;
            
            risk_death = death_rate_multiplier*(normrnd(working.Death_rate_seriously_ill.mean,working.Death_rate_seriously_ill.std))...
                /population(yaxis_loop,xaxis_loop,5);
            
            data_record(time_days,7) = risk_death*working.Risk_of_serious_illness.mean; %instantaneous death rate

            
            if risk_death >working.Maximum_death_rate
                risk_death = working.Maximum_death_rate;
            end
                        
            if didtheysurvive < risk_death
                population(yaxis_loop,xaxis_loop,1) = 3; %fatality.
            end
            end
            
            
            %basically they spontaneously recover here after pop3+pop4 if
            %not dead or otherwise. for all.
            
            if population(yaxis_loop,xaxis_loop,2) >= population(yaxis_loop,xaxis_loop,3) + population(yaxis_loop,xaxis_loop,4)
                if population(yaxis_loop,xaxis_loop,1) == 1
                    mild_recovered = mild_recovered+1;
                elseif population(yaxis_loop,xaxis_loop,1) == 5
                    serious_recovered = serious_recovered+1;
                end
                
                population(yaxis_loop,xaxis_loop,1) = 2;
            end

            
           
            
            %time counter to work out how long the person has been infected
            if population(yaxis_loop,xaxis_loop,2) ~= 0.5
            population(yaxis_loop,xaxis_loop,2) = population(yaxis_loop,xaxis_loop,2)+1; %add 1 every day infected
            end
            
        end %end if infectious loop
    end %ends x and y axes
end

% %             if population(yaxis_loop,xaxis_loop,2) ~= 0.5
% %             population(yaxis_loop,xaxis_loop,2) = population(yaxis_loop,xaxis_loop,2)+1; %add 1 every day infected
% %             end

update_time = population(:,:,2);
update_time(update_time==0.5)=1;
population(:,:,2) = update_time;

% if max(population>=2)
%     recovered

save_matrix = population(:,:,1);
save_matrix_quarantine = population(:,:,6);
save_matrix_test_results = population(:,:,7);
save_matrix_total_tests = population(:,:,8);



data_record(time_days,1) = size(save_matrix(save_matrix==0),1); %Number susceptible
data_record(time_days,2) = size(save_matrix(save_matrix==1),1)+size(save_matrix(save_matrix==4),1)+size(save_matrix(save_matrix==5),1); %Number infected
data_record(time_days,3) = size(save_matrix(save_matrix==2),1); %Number recovered
data_record(time_days,4) = size(save_matrix(save_matrix==3),1); %Number died
data_record(time_days,5) = size(save_matrix(save_matrix==4),1); %Number asymptomatic
data_record(time_days,6) = size(save_matrix(save_matrix==5),1); %Number seriously ill
try 
data_record(time_days,7) = death_rate_multiplier*working.Death_rate_seriously_ill.mean; %instantaneous death rate
catch
    data_record(time_days,7) = working.Death_rate_seriously_ill.mean; %instantaneous death rate
end    
if data_record(time_days,7) > inputs.Maximum_death_rate
   data_record(time_days,7) = inputs.Maximum_death_rate*working.Risk_of_serious_illness.mean;
else
   data_record(time_days,7) = data_record(time_days,7)*working.Risk_of_serious_illness.mean; 
end
data_record(time_days,8) = size(save_matrix_quarantine(save_matrix_quarantine==1),1)+size(save_matrix_quarantine(save_matrix_quarantine==1),2); %Number self isolating
data_record(time_days,11) = size(save_matrix_test_results(save_matrix_test_results==3),1);%'false negatives' this day 
data_record(time_days,12) = size(save_matrix_test_results(save_matrix_test_results==4),1); %'false positives' this day
data_record(time_days,13) = imported_cases; %imported cases
if time_days > 1
data_record(time_days,14) = abs(((data_record(time_days,2) - data_record(time_days-1,2)))+((data_record(time_days,5) - data_record(time_days-1,5)))...
    +((data_record(time_days,3) - data_record(time_days-1,3)))+((data_record(time_days,6) - data_record(time_days-1,6)))...
    +((data_record(time_days,4) - data_record(time_days-1,4)))); %daily number of cases
data_record(time_days,15) = data_record(time_days,4) - data_record(time_days-1,4); %daily number of deaths
else
data_record(time_days,14) = data_record(time_days,2); %daily number of cases
data_record(time_days,15) = data_record(time_days,3); %daily number of deaths   
end
data_record(time_days,16) = lockdown_counter; %Is a lockdown in place?
data_record(time_days,17) = travel_ban_counter; %Is a travel ban in place?
if time_days > 1
data_record(time_days,10) = size(save_matrix_test_results(save_matrix_test_results==2),1)+...
    size(save_matrix_test_results(save_matrix_test_results==4),1)+...
    abs((data_record(time_days,6) - data_record(time_days-1,6))-serious_recovered-...
    (data_record(time_days,4) - data_record(time_days-1,4))); %'confirmed cases' this day 
else
    data_record(time_days,10) = size(save_matrix_test_results(save_matrix_test_results==2),1)+...
    size(save_matrix_test_results(save_matrix_test_results==4),1)+...
    size(save_matrix(save_matrix==5),1);
end
if time_days > 1
data_record(time_days,9) = data_record(time_days-1,9) + data_record(time_days,10) ; %Total confirmed caases
else
    data_record(time_days,9) = data_record(time_days,10);
end
if time_days > 1
data_record(time_days,18) = abs((data_record(time_days,6) - data_record(time_days-1,6))-serious_recovered-...
    (data_record(time_days,4) - data_record(time_days-1,4))); %New serious cases this day
else
    data_record(time_days,18) = data_record(time_days,6);
end

if strcmpi( inputs.Is_there_a_ND,'Yes')
 [mean_Rnumber,standard_deviation_Rnumber] = geoSIR_determine_reproductive_number(inputs,working,'Fiveday',...
    lockdown_counter,time_days,data_record,n_red,n_yellow,n_white,tot_red,tot_yellow,tot_white,...
    red_zone_increase_numtrips_close,yellow_zone_increase_numtrips_close,white_zone_increase_numtrips_close,...
    red_zone_increase_numtrips_distant,yellow_zone_increase_numtrips_distant,white_zone_increase_numtrips_distant, eruption_counter); 
else
  [mean_Rnumber,standard_deviation_Rnumber] = geoSIR_determine_reproductive_number(inputs,working,'Fiveday',...
    lockdown_counter,time_days,data_record); 
end
data_record(time_days,19) = mean_Rnumber; %Infections in 5 days
data_record(time_days,20) = standard_deviation_Rnumber; %Infections in 5 days




if strcmpi( inputs.Is_there_a_ND,'Yes')
 [mean_Rnumber2,standard_deviation_Rnumber2] = geoSIR_determine_reproductive_number(inputs,working,'Rzero',...
    lockdown_counter,time_days,data_record,n_red,n_yellow,n_white,tot_red,tot_yellow,tot_white,...
    red_zone_increase_numtrips_close,yellow_zone_increase_numtrips_close,white_zone_increase_numtrips_close,...
    red_zone_increase_numtrips_distant,yellow_zone_increase_numtrips_distant,white_zone_increase_numtrips_distant, eruption_counter); 
else
  [mean_Rnumber2,standard_deviation_Rnumber2] = geoSIR_determine_reproductive_number(inputs,working,'Rzero',...
    lockdown_counter,time_days,data_record); 
end
data_record(time_days,21) = mean_Rnumber2;  %Reproductive value
data_record(time_days,22) = standard_deviation_Rnumber2;  %Reproductive value


% % % if strcmpi(inputs.record_stats_infected,'Yes') || strcmpi(inputs.record_stats_critical,'Yes') ||...
% % %         strcmpi(inputs.record_stats_died,'Yes') || strcmpi(inputs.record_stats_recovered,'Yes')
% % % 
% % % %Record stats GRID
% % % 
% % % if (time_days+inputs.stats_time_interval-1)/inputs.stats_time_interval == round((time_days+inputs.stats_time_interval-1)/inputs.stats_time_interval)
% % %     
% % % for ygrid = 1:round((inputs.stats_grid_size/cellsize)):size(population_density_matrix,1) - round((inputs.stats_grid_size/cellsize))
% % %     for xgrid = 1:round((inputs.stats_grid_size/cellsize)):size(population_density_matrix,2) - round((inputs.stats_grid_size/cellsize))
% % %         
% % %         current_chip = population(ygrid:ygrid+round((inputs.stats_grid_size/cellsize))-1,xgrid:xgrid + round((inputs.stats_grid_size/cellsize))-1,1); %Cut out x km grid
% % %         
% % %         if size(current_chip(~isnan(current_chip)),1) > size_chip*0.5 % At least half of cells need to be in the area, else discarded
% % %         
% % %         if strcmpi(inputs.record_stats_infected,'Yes')    
% % %         stats_infected((ygrid-1)/round((inputs.stats_grid_size/cellsize)),(xgrid-1)/round((inputs.stats_grid_size/cellsize)),time_days+grid_counter)...
% % %             = size(current_chip(current_chip==1),1) + size(current_chip(current_chip==4),1) + size(current_chip(current_chip==5),1);
% % %         end
% % %         if strcmpi(inputs.record_stats_critical,'Yes')
% % %         stats_critical((ygrid-1)/round((inputs.stats_grid_size/cellsize)),(xgrid-1)/round((inputs.stats_grid_size/cellsize)),time_days+grid_counter)...
% % %             = size(current_chip(current_chip==5),1);
% % %         end
% % %         if strcmpi(inputs.record_stats_died,'Yes')
% % % 
% % %         stats_died((ygrid-1)/round((inputs.stats_grid_size/cellsize)),(xgrid-1)/round((inputs.stats_grid_size/cellsize)),time_days+grid_counter)...
% % %             = size(current_chip(current_chip==3),1);
% % %         end
% % %         if strcmpi(inputs.record_stats_recovered,'Yes')
% % %         stats_recovered((ygrid-1)/round((inputs.stats_grid_size/cellsize)),(xgrid-1)/round((inputs.stats_grid_size/cellsize)),time_days+grid_counter)...
% % %             = size(current_chip(current_chip==2),1);     
% % %         end
% % %                   
% % %         end
% % %         
% % %     end
% % % end
% % % grid_counter = grid_counter-inputs.stats_time_interval+1;
% % % end
% % % end




if time_days > 25 && time_days < working.Maximum_time - 30
if data_record(time_days,2) == data_record(time_days-1,2) && data_record(time_days,2) == data_record(time_days-2,2) && data_record(time_days,2) == data_record(time_days-3,2)||...
        data_record(time_days,3) == data_record(time_days-1,3) && data_record(time_days,3) == data_record(time_days-2,3) && data_record(time_days,3) == data_record(time_days-3,3)
    
    
    if final_day == working.Maximum_time
    final_day = time_days;
    end

    break;
    
end
end

end % end time loop


number_susceptible(:,iterations) = data_record(:,1);
number_infected(:,iterations) = data_record(:,2);
number_recovered(:,iterations) = data_record(:,3);
number_died(:,iterations) = data_record(:,4);
number_asymptomatic(:,iterations) = data_record(:,5);
number_seriously_ill(:,iterations) = data_record(:,6);
instantaneous_death_rate(:,iterations) = data_record(:,7);
number_self_isolating(:,iterations) = data_record(:,8);
cumulative_confirmed_cases(:,iterations) = data_record(:,9);
confirmed_daily_cases(:,iterations) = data_record(:,10);
number_false_negatives(:,iterations) = data_record(:,11);
number_false_positives(:,iterations) = data_record(:,12);
number_imported_cases(:,iterations) = data_record(:,13);
daily_cases_real(:,iterations) = data_record(:,14);
daily_deaths(:,iterations) = data_record(:,15);
lockdown_state(:,iterations) = data_record(:,16);
travel_ban_state(:,iterations) = data_record(:,17);
daily_seriously_ill(:,iterations) = data_record(:,18);
five_day_infection_rate_mean(:,iterations) = data_record(:,19);
five_day_infection_rate_std(:,iterations) = data_record(:,20);
reproductive_number_mean(:,iterations) = data_record(:,21);
reproductive_number_std(:,iterations) = data_record(:,22);


% % % if strcmpi(inputs.record_stats_infected,'Yes')    
% % % 
% % % for end_loop = 1:size(stats_infected,3)                                    %Find last real value, crop to it
% % %     temporary_isit_empty = stats_infected(:,:,end_loop);
% % %     if size(temporary_isit_empty(~isnan(temporary_isit_empty)),1) == 0
% % %         break;
% % %     end
% % % end
% % % 
% % % stats_infected(:,:,end_loop:end) = [];
% % % end
% % %  
% % % if strcmpi(inputs.record_stats_critical,'Yes')    
% % % 
% % % for end_loop = 1:size(stats_critical,3)                                    %Find last real value, crop to it
% % %     temporary_isit_empty = stats_critical(:,:,end_loop);
% % %     if size(temporary_isit_empty(~isnan(temporary_isit_empty)),1) == 0
% % %         break;
% % %     end
% % % end
% % % 
% % % stats_critical(:,:,end_loop:end) = [];
% % % end
% % %  
% % % if strcmpi(inputs.record_stats_died,'Yes')    
% % % 
% % % for end_loop = 1:size(stats_died,3)                                    %Find last real value, crop to it
% % %     temporary_isit_empty = stats_died(:,:,end_loop);
% % %     if size(temporary_isit_empty(~isnan(temporary_isit_empty)),1) == 0
% % %         break;
% % %     end
% % % end
% % % 
% % % stats_died(:,:,end_loop:end) = [];
% % % end
% % %  
% % % if strcmpi(inputs.record_stats_recovered,'Yes')    
% % % 
% % % for end_loop = 1:size(stats_recovered,3)                                    %Find last real value, crop to it
% % %     temporary_isit_empty = stats_recovered(:,:,end_loop);
% % %     if size(temporary_isit_empty(~isnan(temporary_isit_empty)),1) == 0
% % %         break;
% % %     end
% % % end
% % % 
% % % stats_recovered(:,:,end_loop:end) = [];
% % %  end
% % % 
% % % 
% % % if strcmpi(inputs.record_stats_infected,'Yes')    
% % % meta_stats_infected{iterations,1} = stats_infected;
% % % end
% % % if strcmpi(inputs.record_stats_critical,'Yes')
% % % meta_stats_critical{iterations,1} = stats_critical;
% % % end
% % % if strcmpi(inputs.record_stats_died,'Yes')    
% % % meta_stats_died{iterations,1} = stats_died;
% % % end
% % % if strcmpi(inputs.record_stats_recovered,'Yes')    
% % % meta_stats_recovered{iterations,1} = stats_recovered;
% % % end



    
    
end %end FOR loop
    
else
    disp('You must choose Yes or No for parralelization')
    
end
Model_runtime = toc


%%
%make outputs array
outputs.number_susceptible.raw = number_susceptible;
outputs.number_infected.raw = number_infected;
outputs.number_recovered.raw = number_recovered;
outputs.number_died.raw = number_died;
outputs.number_asymptomatic.raw = number_asymptomatic;
outputs.number_seriously_ill.raw = number_seriously_ill;
outputs.instantaneous_death_rate.raw = instantaneous_death_rate;
outputs.number_self_isolating.raw = number_self_isolating;
outputs.cumulative_confirmed_cases.raw = cumulative_confirmed_cases;
outputs.confirmed_daily_cases.raw = confirmed_daily_cases;
for  daily_cases_loop = 2:size(outputs.cumulative_confirmed_cases.raw,1)
    for iterations_loop = 1:size(outputs.cumulative_confirmed_cases.raw,2)
        if outputs.cumulative_confirmed_cases.raw(daily_cases_loop,iterations_loop) ~=0
        outputs.confirmed_daily_cases.raw(daily_cases_loop,iterations_loop) =...
        outputs.cumulative_confirmed_cases.raw(daily_cases_loop,iterations_loop) -... 
        outputs.cumulative_confirmed_cases.raw(daily_cases_loop-1,iterations_loop); 
        elseif outputs.cumulative_confirmed_cases.raw(daily_cases_loop,iterations_loop) ==0
         outputs.confirmed_daily_cases.raw(daily_cases_loop,iterations_loop) = 0;
        end
    end
end
outputs.number_false_negatives.raw = number_false_negatives;
outputs.number_false_positives.raw = number_false_positives;
outputs.number_imported_cases.raw = number_imported_cases;
outputs.daily_cases_real.raw = daily_cases_real;
outputs.daily_deaths.raw = daily_deaths;
outputs.lockdown_state.raw = lockdown_state;
outputs.travel_ban_state.raw = travel_ban_state;
outputs.daily_seriously_ill.raw = daily_seriously_ill;
outputs.five_day_infection_rate_mean.raw = five_day_infection_rate_mean;
outputs.five_day_infection_rate_std.raw = five_day_infection_rate_std;
outputs.reproductive_number_mean.raw = reproductive_number_mean;
outputs.reproductive_number_std.raw = reproductive_number_std;
% % % if strcmpi(inputs.record_stats_infected,'Yes')    
% % % outputs.meta_stats_infected = meta_stats_infected;
% % % end
% % % if strcmpi(inputs.record_stats_critical,'Yes')    
% % % outputs.meta_stats_critical = meta_stats_critical;
% % % end
% % % if strcmpi(inputs.record_stats_died,'Yes')    
% % % outputs.meta_stats_died = meta_stats_died;
% % % end
% % % if strcmpi(inputs.record_stats_recovered,'Yes')    
% % % outputs.meta_stats_recovered = meta_stats_recovered;
% % % end
if strcmpi(inputs.Is_there_a_ND,'Yes')
outputs.Number_in_high_risk_area = n_red;
outputs.Number_in_medium_risk_area = n_yellow;
outputs.Number_in_low_risk_area = n_white;
end

% for  daily_cases_loop = 2:size(outputs.cumulative_confirmed_cases.raw,1)
%     for iterations_loop = 1:size(outputs.cumulative_confirmed_cases.raw,2)
outputs.apparent_death_rate.raw = zeros(size(outputs.cumulative_confirmed_cases.raw,1),size(outputs.cumulative_confirmed_cases.raw,2));

    outputs.apparent_death_rate.raw(:,:) =...
        (outputs.number_died.raw(:,:)./...
        (outputs.cumulative_confirmed_cases.raw(:,:))); 
    outputs.apparent_death_rate.raw(isnan(outputs.apparent_death_rate.raw)) = 0;
%     end
% end

% Calculate means
mean_susceptible = mean(outputs.number_susceptible.raw,2);

%crop matrices

find_infection_stopped = filter(ones(1,30),30,gradient(mean_susceptible)); %finds where no more infections, +30

crop_full = zeros(inputs.Maximum_time,inputs.Number_of_iterations);

for iteration_count = 1:inputs.Number_of_iterations
    crop_full(:,iteration_count) = find_infection_stopped;
end


[outputs.number_susceptible.raw,outputs.number_susceptible.mean] = geoSIR_cropNmean(outputs.number_susceptible.raw,'Constant',crop_full,inputs,'Yes');
[outputs.number_infected.raw,outputs.number_infected.mean] = geoSIR_cropNmean(outputs.number_infected.raw,'Zero',crop_full,inputs,'Yes');
[outputs.number_recovered.raw,outputs.number_recovered.mean] = geoSIR_cropNmean(outputs.number_recovered.raw,'Constant',crop_full,inputs,'Yes');
[outputs.number_died.raw,outputs.number_died.mean] = geoSIR_cropNmean(outputs.number_died.raw,'Constant',crop_full,inputs,'Yes');
[outputs.number_asymptomatic.raw,outputs.number_asymptomatic.mean] = geoSIR_cropNmean(outputs.number_asymptomatic.raw,'Zero',crop_full,inputs,'Yes');
[outputs.number_seriously_ill.raw,outputs.number_seriously_ill.mean] = geoSIR_cropNmean(outputs.number_seriously_ill.raw,'Zero',crop_full,inputs,'Yes');
[outputs.instantaneous_death_rate.raw,outputs.instantaneous_death_rate.mean] = geoSIR_cropNmean(outputs.instantaneous_death_rate.raw,'Constant',crop_full,inputs,'Yes');
[outputs.number_self_isolating.raw,outputs.number_self_isolating.mean] = geoSIR_cropNmean(outputs.number_self_isolating.raw,'Constant',crop_full,inputs,'Yes');
[outputs.cumulative_confirmed_cases.raw,outputs.cumulative_confirmed_cases.mean] = geoSIR_cropNmean(outputs.cumulative_confirmed_cases.raw,'Constant',crop_full,inputs,'Yes');
[outputs.confirmed_daily_cases.raw,outputs.confirmed_daily_cases.mean] = geoSIR_cropNmean(outputs.confirmed_daily_cases.raw,'Zero',crop_full,inputs,'Yes');
[outputs.number_false_negatives.raw,outputs.number_false_negatives.mean] = geoSIR_cropNmean(outputs.number_false_negatives.raw,'Zero',crop_full,inputs,'Yes');
[outputs.number_false_positives.raw,outputs.number_false_positives.mean] = geoSIR_cropNmean(outputs.number_false_positives.raw,'Zero',crop_full,inputs,'Yes');
[outputs.number_imported_cases.raw,outputs.number_imported_cases.mean] = geoSIR_cropNmean(outputs.number_imported_cases.raw,'Zero',crop_full,inputs,'Yes');
[outputs.daily_cases_real.raw,outputs.daily_cases_real.mean] = geoSIR_cropNmean(outputs.daily_cases_real.raw,'Zero',crop_full,inputs,'Yes');
[outputs.daily_deaths.raw,outputs.daily_deaths.mean] = geoSIR_cropNmean(outputs.daily_deaths.raw,'Zero',crop_full,inputs,'Yes');
[outputs.lockdown_state.raw,outputs.lockdown_state.mean] = geoSIR_cropNmean(outputs.lockdown_state.raw,'Zero',crop_full,inputs,'No');
[outputs.travel_ban_state.raw,outputs.travel_ban_state.mean] = geoSIR_cropNmean(outputs.travel_ban_state.raw,'Zero',crop_full,inputs,'No');
[outputs.apparent_death_rate.raw,outputs.apparent_death_rate.mean] = geoSIR_cropNmean(outputs.apparent_death_rate.raw,'Zero',crop_full,inputs,'No');
[outputs.daily_seriously_ill.raw,outputs.daily_seriously_ill.mean] = geoSIR_cropNmean(outputs.daily_seriously_ill.raw,'Zero',crop_full,inputs,'Yes');
[outputs.five_day_infection_rate_mean.raw,outputs.five_day_infection_rate_mean.mean] = geoSIR_cropNmean(outputs.five_day_infection_rate_mean.raw,'Constant',crop_full,inputs,'Yes');
[outputs.five_day_infection_rate_std.raw,outputs.five_day_infection_rate_std.mean] = geoSIR_cropNmean(outputs.five_day_infection_rate_std.raw,'Constant',crop_full,inputs,'Yes');
[outputs.reproductive_number_mean.raw,outputs.reproductive_number_mean.mean] = geoSIR_cropNmean(outputs.reproductive_number_mean.raw,'Constant',crop_full,inputs,'Yes');
[outputs.reproductive_number_std.raw,outputs.reproductive_number_std.mean] = geoSIR_cropNmean(outputs.reproductive_number_std.raw,'Constant',crop_full,inputs,'Yes');