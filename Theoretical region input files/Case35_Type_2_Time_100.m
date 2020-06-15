function [inputs] = Case31_Type_2_Time_100()
%
% geoSIR, written by Max van wyk de vries and Lekaashree rambabu, 04/2020.
%
%
%This function defines the input parameters and creats the inputs array.


%write to array


inputs.Name = 'Case31_Type_2_Time_100';      %Name to save this run parameters under

inputs.Number_of_people = 100000;                                           %Population of area

inputs.Population_density = 0.4;                                            %Density of population

inputs.Number_of_close_encounters.min = 0;                                  %Minimum and maximum number of 'close' encounters
inputs.Number_of_close_encounters.max = 4; %https://www.thelancet.com/journals/laninf/article/PIIS1473-3099(20)30314-5/fulltext

inputs.Distance_travelled_for_close_encounters.min  = 1;                    %Minimum and maximum distance travelled for these encounters
inputs.Distance_travelled_for_close_encounters.max  = 5;

inputs.Probability_of_infection_for_close_encounters.mean = 0.4;             %Minimum and maximum infection chance for these encounters
inputs.Probability_of_infection_for_close_encounters.std = 0.1; %https://wwwnc.cdc.gov/eid/article/26/6/20-0412_article

% % inputs.Probability_of_infection_for_close_encounters.min = 0.3;             %Minimum and maximum infection chance for these encounters
% % inputs.Probability_of_infection_for_close_encounters.max = 0.5;

inputs.Number_of_distant_encounters.min = 5;                                %Minimum and maximum number of 'distant' encounters
inputs.Number_of_distant_encounters.max = 15;

inputs.Distance_travelled_for_distant_encounters.min = 5;                   %Minimum and maximum distance travelled for these encounters
inputs.Distance_travelled_for_distant_encounters.max = 30;

inputs.Probability_of_infection_for_distant_encounters.mean = 0.025;          %Minimum and maximum infection chance for these encounters
inputs.Probability_of_infection_for_distant_encounters.std = 0.005; %https://wwwnc.cdc.gov/eid/article/26/6/20-0412_article

inputs.Number_of_travellers_in.min = 10;                                     %Number of incoming travellers to the study region
inputs.Number_of_travellers_in.max = 10; %Arbitrary to inititate infection

inputs.Number_of_travellers_out.min = 10;                                    %Number of outgoing travellers from the study region
inputs.Number_of_travellers_out.max = 10;

inputs.Fraction_of_infected_travellers.min = 1;                           %Proportion of travellers that are infected
inputs.Fraction_of_infected_travellers.max = 1;

inputs.traveller_only_to_empty_cells = 'No';                                %Travellers will only fill empty cells (pop density must be <1)

inputs.Risk_of_serious_illness.mean = 0.19;                                  %Proportion of infected that become seriously ill (chance of mortality)
inputs.Risk_of_serious_illness.std = 0.02; %https://jamanetwork.com/journals/jama/article-abstract/2762130?fbclid=IwAR3VO06Zl4FQxcHZKISBSzyfhmYP12BsHRK64VcI1JPCnoNF6vH59wYneUY
                                           %https://link.springer.com/article/10.1007/s00101-020-00760-3
                                           % https://www.nejm.org/doi/10.1056/NEJMoa2002032

inputs.Proportion_asymptomatic.mean = 0.20;                                  %Proportion of infected that are entirely asymptomatic (no risk, but still spread)
inputs.Proportion_asymptomatic.std = 0.05; %https://www.cebm.net/covid-19/covid-19-what-proportion-are-asymptomatic/

inputs.Death_rate_seriously_ill.mean = 0.12;                                 %Death rate of the seriously ill
inputs.Death_rate_seriously_ill.std = 0.02; %https://www.medrxiv.org/content/10.1101/2020.04.09.20059683v2
                                            %USEFUL: https://jamanetwork.com/journals/jama/article-abstract/2762130?fbclid=IwAR3VO06Zl4FQxcHZKISBSzyfhmYP12BsHRK64VcI1JPCnoNF6vH59wYneUY
                                            %USEFUL: https://www.nejm.org/doi/10.1056/NEJMoa2002032
                                            %https://jamanetwork.com/journals/jama/article-abstract/2761044
                                            %https://www.sciencedirect.com/science/article/pii/S0140673620302117?casa_token=wUwwdtXlrXMAAAAA:dP9ahx9mbEvsDWxFTD6T2cP5pEb64NLYdT1R3_9hVlBohvYvF3jYozlA8gpWKI_sZTpPzYCbwdM
                                            %https://jamanetwork.com/journals/jama/article-abstract/2763485?fbclid=IwAR2IUal5aQQoNfe9zOV07Zj2fFRbNzrVwsK1olmNjCbnJZI9JVh4JolhB3E
                                            %https://www.nejm.org/doi/full/10.1056/NEJMoa2004500?fbclid=IwAR0s3wutbOz9A7r9VFO5OnVjmi4xrXwGDRb_lEEERJ-lH6QxJBaC5pDxiBk

inputs.Hospital_capacity = 20;                                              %Hospotial capacity for seriously ill patients (if exceeded, death rate rises)
                                %https://www.medrxiv.org/content/10.1101/2020.04.06.20055848v1.full.pdf
                               
inputs.Sensitivity_to_overcrowding = 1;                                     %For 1, once capacity is overwhelmed, DR will rise as 100% per critical cases equal to capacity.
                                % https://covid19.healthdata.org/united-states-of-america/louisiana
                                %Lousiana: death rate rose from 1.09 to
                                %1.42 as hospital capacity (477 was exceded
                                %up to 630) 1.32 over hospital capacity and
                                %1.30 increase in death rate supports this
                                %linear relationship.
inputs.Maximum_death_rate = 0.8;                                            %Highest possible death rate of seriously ill, assuming total overwhelming of medical system (note the way it is calculated, it cannot reach 1)

inputs.Length_of_illness.mean = 11;                                         %Mean and standard deviation of symptomatic illness duration (whether serious or not)
inputs.Length_of_illness.sd = 2;            %https://www.thelancet.com/action/showPdf?pii=S0140-6736%2820%2930566-3
                                            %https://www.nejm.org/doi/10.1056/NEJMoa2002032

inputs.Incubation_time.mean = 5.1;                                            %Mean and standard deviation of incubation time (when infected may spread the disease, but do not present symptoms)
inputs.Incubation_time.sd = 2.5;              % https://www.acpjournals.org/doi/full/10.7326/M20-0504
                       

inputs.Proportion_non_symptomatic_self_isolation.min = 0.2;                 %Proportion of non symptomatic people who self isolate. Note: may be turned up to simulate 'social distancing'.
inputs.Proportion_non_symptomatic_self_isolation.max = 0.2;

inputs.Efficiency_of_non_symptomatic_self_isolation.min = 1;              %Efficiency of self isolation. For 0.5, 50% of trips are cut down. For 1, no contact is made.
inputs.Efficiency_of_non_symptomatic_self_isolation.max = 1;

inputs.Proportion_symptomatic_self_isolation.min = 0.6;                     %Proportion of symptomatic people who self isolate. Note: may be turned up to simulate quarantining of the sick.
inputs.Proportion_symptomatic_self_isolation.max = 0.6;

inputs.Efficiency_of_symptomatic_self_isolation.min = 1;                  %Efficiency of self isolation. For 0.5, 50% of trips are cut down. For 1, no contact is made.
inputs.Efficiency_of_symptomatic_self_isolation.max = 1;                    

inputs.Number_of_tests_conducted_symptomatic.min = 1;                      %Number of tests conducted on symptomatic individuals per day
inputs.Number_of_tests_conducted_symptomatic.max = 1;

inputs.Number_of_tests_conducted_non_symptomatic.min = 1;                  %Number of tests conducted on non symptomatic individuals per day
inputs.Number_of_tests_conducted_non_symptomatic.max = 1;

inputs.Test_false_positive_rate.min = 0;                                   %Test false positive rate (non-infected person tests as positive)
inputs.Test_false_positive_rate.max = 0;

inputs.Test_false_negative_rate.min = 0.30;                                 %Test false negative rate (infected person tests as negative)
inputs.Test_false_negative_rate.max = 0.40;
 %Adjust and get references if using

inputs.Is_a_lockdown_implemented = 'Yes';                                   %Is a lockdown implemented if certain conditions are met?

inputs.Confirmed_cases_lockdown_threshold = 150;                            %Number of confirmed cases needed before a lockdown is implemented
    %Set to match max num of cases
inputs.Deaths_lockdown_threshold = 50;                                      %Number of deaths needed before a lockdown is implemented.

inputs.Confirmed_cases_lockdown_exit = -1;                                 %Maximum number of daily cases needed before a lockdown lifted

inputs.Deaths_lockdown_exit = -1;                                           %Maximum number of daily deaths needed before a lockdown lifted
    %Lockdown not lifted
inputs.Lockdown_proportion_non_symptomatic.min = 0.70;                       %Efficiency of lockdown for non-symptomatic people
inputs.Lockdown_proportion_non_symptomatic.max = 0.70;

inputs.Lockdown_proportion_symptomatic.min = 0.95;                           %Efficiency of lockdown for symptomatic people
inputs.Lockdown_proportion_symptomatic.max = 0.95;

inputs.Distance_moved_reduction_factor = 2;                                 %Reduces distance travelled during lockdown by a given factor
                                    %50% reduction in movement during
                                    %lockdown, see google/apple phone
                                    %movement data for per-location
                                    %examples

inputs.Is_a_travel_ban_implemented = 'Yes';                                 %Is a travel ban implemented if certain conditions are met?

inputs.Confirmed_cases_travel_ban_threshold = 10;                          %Number of confirmed cases needed before a lockdown is implemented

inputs.Deaths_travel_ban_threshold = 3;                                    %Number of deaths needed before a lockdown is implemented.

inputs.Confirmed_cases_travel_ban_exit = -1;                                %Maximum number of daily cases needed before a lockdown lifted

inputs.Deaths_travel_ban_exit = -1;                                         %Maximum number of daily deaths needed before a lockdown lifted
       
inputs.Maximum_time = 300;                                                 %Maximum number of days that the model runs for

inputs.Number_of_iterations = 100;                                           %Number of individual iterations run

inputs.Parralelize = 'Yes';                                                 %Run in parralel? Will default to maximum number of cores of user.

inputs.Number_of_iterations_for_R = 10;                                     %Number of iterations for calculating the reproductive number and 5 day progression

inputs.Is_there_a_ND = 'Yes';                                        %Does an ND happen?

inputs.ND_case = 2;                                                   %ND case. See run file for details.

inputs.ND_time = 100;                                                  %Timing of ND after run start.

inputs.duration_of_ND_disruption = 14;                                %Duration of ND related disruption (days)

inputs.record_stats_infected = 'No';

inputs.record_stats_critical = 'No';

inputs.record_stats_died = 'No';

inputs.record_stats_recovered = 'No';

inputs.stats_grid_size = 5;                                                 %Size of averaging area for stats matrix

inputs.stats_time_interval = 2;                                             %Stats recorded every x days

% % % inputs.min_lat = 39.922;                                                           %Coordinates
% % % inputs.max_lat = 41.569;
% % % inputs.min_long =  13.677;
% % % inputs.max_long = 15.876;
% % % 
% % % inputs.minimum_density = 0.2;                                                      %'Modelled' population density thresholds
% % % inputs.maximum_density = 1;
% % % 
% % % 
% % % path_to_population = 'C:\Users\gmaxv\Documents\=PhD\misc\SIR_model\Italy population\population_amount.tif';
% % % 
% % % path_to_red = 'C:\Users\gmaxv\Documents\=PhD\misc\SIR_model\Italy population\Red_zone.jpg';
% % % 
% % % path_to_yellow = 'C:\Users\gmaxv\Documents\=PhD\misc\SIR_model\Italy population\Yellow_zone.jpg';
% % % 
% % % %%% Import population density matrix
% % % 
% % % [inputs] = population_density_generate(inputs);
