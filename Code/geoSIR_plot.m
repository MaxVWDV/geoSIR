function geoSIR_plot(inputs,outputs)
%
% geoSIR, written by Max van wyk de vries and Lekaashree rambabu, 04/2020.
%
%
%This function creates plots and saves the input and output files for future reference.

if ~exist('./Results')
    mkdir './Results';
end

filename = [inputs.Name ' ' 'n=' num2str(inputs.Number_of_people) ' ' 'rho=' num2str(inputs.Population_density) ' ' ...
    'Iterations=' num2str(inputs.Number_of_iterations)];


if ~exist(strcat('./Results/',filename))
    mkdir(strcat('./Results/',filename));
end   

outputs.day_axis = (1:1:size(outputs.number_susceptible.raw,1))';

%%%%%%%%%%%%%%%%%%%%%%Plot all lines
all_lines = figure('visible','off');
title('Epidemic Progression')

%% Save data files

            
save(strcat('./Results/',filename,'/Run Inputs'),'inputs');
save(strcat('./Results/',filename,'/Run Outputs'),'outputs');

%% Make Plots


for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.number_susceptible.raw(:,plot_iterations),'k','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end

for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.number_infected.raw(:,plot_iterations),'Color',	'#7E2F8E','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end

for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.number_recovered.raw(:,plot_iterations),	'Color','#77AC30','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end

for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.number_died.raw(:,plot_iterations),	'Color','#A2142F','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end

hold on
plot(outputs.day_axis,outputs.number_susceptible.mean,'k','LineWidth',2);
hold on 
plot(outputs.day_axis,outputs.number_infected.mean,'Color',	'#7E2F8E','LineWidth',2);
hold on
plot(outputs.day_axis,outputs.number_recovered.mean,'Color','#77AC30','LineWidth',2);
hold on 
plot(outputs.day_axis,outputs.number_died.mean,	'Color','#A2142F','LineWidth',2);
ylabel('Number of people')
xlabel('Days since beginning of epidemic')
legend('Unaffected','Infected','Recovered','Died')

set(gca,'fontname','times')

      print(all_lines,'-dpng','-r300',strcat('./Results/',filename,'/all lines.png'));


%%%%%%%%%%%%%%%%%%%%%%Plot cases only

cases_only = figure('visible','off');
title('Epidemic Progression')
plot(outputs.day_axis,outputs.number_infected.mean,'Color',	'#7E2F8E','LineWidth',2);
hold on
ylabel('Number of people')
xlabel('Days since beginning of epidemic')
legend('Infected')

for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.number_infected.raw(:,plot_iterations),'Color',	'#7E2F8E','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end

set(gca,'fontname','times')

   print(cases_only,'-dpng','-r300',strcat('./Results/',filename,'/cases.png'));


%%%%%%%%%%%%%%%%%%%%%%Plot deaths only
deaths_only = figure('visible','off');
title('Epidemic Progression')

plot(outputs.day_axis,outputs.number_died.mean,	'Color','#A2142F','LineWidth',2);
ylabel('Number of fatalities')
xlabel('Days since beginning of epidemic')
legend('Died')


for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.number_died.raw(:,plot_iterations),	'Color','#A2142F','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end
set(gca,'fontname','times')

print(deaths_only,'-dpng','-r300',strcat('./Results/',filename,'/deaths.png'));

%%%%%%%%%%%%%%%%%%%%%%Plot seriously ill only
seriously_ill_only = figure('visible','off');
title('Epidemic Progression')

plot(outputs.day_axis,outputs.number_seriously_ill.mean,	'Color','#B4A337','LineWidth',2);
ylabel('Number of people seriously ill')
xlabel('Days since beginning of epidemic')
legend('Seriously ill')


for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.number_seriously_ill.raw(:,plot_iterations),	'Color','#B4A337','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end
set(gca,'fontname','times')

print(seriously_ill_only,'-dpng','-r300',strcat('./Results/',filename,'/seriously ill.png'));

%%%%%%%%%%%%%%%%%%%%%%Plot confirmed cases
confirmed_cases = figure('visible','off');
title('Epidemic Progression')

bar(outputs.day_axis,outputs.confirmed_daily_cases.mean, 'FaceColor','k');
ylabel('Number of confirmed cases')
xlabel('Days since beginning of epidemic')
legend('Confirmed cases')

set(gca,'fontname','times')

print(confirmed_cases,'-dpng','-r300',strcat('./Results/',filename,'/Confirmed cases daily.png'));

%%%%%%%%%%%%%%%%%%%%%%Plot apparent death rate
death_rate = figure('visible','off');
title('Epidemic Progression')

plot(outputs.day_axis,outputs.apparent_death_rate.mean,	'Color','#32A042','LineWidth',2);
hold on
plot(outputs.day_axis,outputs.instantaneous_death_rate.mean,	'Color','#267F71','LineWidth',2);

ylabel('Apparent death rate')
xlabel('Days since beginning of epidemic')
legend('Apparent death rate','Estimated real death rate')


for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.apparent_death_rate.raw(:,plot_iterations),	'Color','#32A042','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end

for plot_iterations = 1:inputs.Number_of_iterations
    hold on
    transparent_plot = plot(outputs.day_axis,outputs.instantaneous_death_rate.raw(:,plot_iterations),	'Color','#267F71','LineWidth',0.3,'HandleVisibility','off');
    transparent_plot.Color(4) = 0.2;
end
set(gca,'fontname','times')

print(death_rate,'-dpng','-r300',strcat('./Results/',filename,'/death rate.png'));

%%%%%%%%%%%%%%%%%%%%%%Plot R0
rzero = figure('visible','off');
title('Epidemic Progression')

plot(outputs.day_axis,outputs.five_day_infection_rate_mean.mean,	'Color','#32A042','LineWidth',2);
hold on
plot(outputs.day_axis,outputs.reproductive_number_mean.mean,	'Color','#267F71','LineWidth',2);

ylabel('Disease spread parameters')
xlabel('Days since beginning of epidemic')
legend('5 day spread','Reproductive number')


% for plot_iterations = 1:inputs.Number_of_iterations
%     hold on
%     transparent_plot = plot(outputs.day_axis,outputs.five_day_infection_rate_mean.raw(:,plot_iterations),	'Color','#32A042','LineWidth',0.3,'HandleVisibility','off');
%     transparent_plot.Color(4) = 0.2;
% end
% 
% for plot_iterations = 1:inputs.Number_of_iterations
%     hold on
%     transparent_plot = plot(outputs.day_axis,outputs.reproductive_number_mean.raw(:,plot_iterations),	'Color','#267F71','LineWidth',0.3,'HandleVisibility','off');
%     transparent_plot.Color(4) = 0.2;
% end
set(gca,'fontname','times')

print(rzero,'-dpng','-r300',strcat('./Results/',filename,'/reproductive number.png'));

%%%%%%%%%%%%%%%%%%%%%%Plot number of new cases
new_cases = figure('visible','off');
title('Epidemic Progression')

bar(outputs.day_axis,outputs.daily_cases_real.mean, 'FaceColor','k');
ylabel('Number of cases per day')
xlabel('Days since beginning of epidemic')
legend('Cases per day')
set(gca,'fontname','times')

print(new_cases,'-dpng','-r300',strcat('./Results/',filename,'/New cases daily.png'));


%%%%%%%%%%%%%%%%%%%%%%Plot number of new deaths
deaths_per_day = figure('visible','off');
title('Epidemic Progression')

bar(outputs.day_axis,outputs.daily_deaths.mean, 'FaceColor','k');
ylabel('Number of deaths per day')
xlabel('Days since beginning of epidemic')
legend('Deaths per day')
set(gca,'fontname','times')

print(deaths_per_day,'-dpng','-r300',strcat('./Results/',filename,'/New deaths daily.png'));



%%%%%%%%%%%%%%%%%%%%%%Histogram of maximum number of infections
maximum_infections = figure('visible','off');
title('Histogram of maximum number of simultaneously infected cases')

histogram(nanmax(outputs.number_infected.raw,[],1),100,'FaceColor','k')
ylabel('Bin count')
xlabel('Number of people infected')
set(gca,'fontname','times')

 print(maximum_infections,'-dpng','-r300',strcat('./Results/',filename,'/maximum infections histogram.png'));



%%%%%%%%%%%%%%%%%%%%%%Histogram of number of deaths
number_of_deaths = figure('visible','off');
title('Histogram of death count')

histogram(nanmax(outputs.number_died.raw,[],1),100,'FaceColor','k')
ylabel('Bin count')
xlabel('Number of fatalities')
set(gca,'fontname','times')

      print(number_of_deaths,'-dpng','-r300',strcat('./Results/',filename,'/number of deaths histogram.png'));



% % % %%%%%%%%%%%%%%%%%%%%%%Histogram of infection peak timing
% % % time_peak = zeros(1,inputs.Number_of_iterations);
% % % for find_peak_time_loop = 1:inputs.Number_of_iterations
% % % time_peak(1,find_peak_time_loop) = min(find(outputs.number_infected.mean(:,find_peak_time_loop)...
% % %     ==max(outputs.number_infected.mean(:,find_peak_time_loop),[],1)));
% % % end
% % % 
% % % 
% % % timing_of_peak = figure;
% % % title('Histogram of timing of infection peak')
% % % 
% % % histogram(time_peak,100,'FaceColor','k')
% % % ylabel('Bin count')
% % % xlabel('Days after first infection')
% % % set(gca,'fontname','times')
% % % 
% % %       print(timing_of_peak,'-dpng','-r300',strcat('./Results/',filename,'/timing of infection peak histogram.png'));
% % % 
% % % %%%%%%%%%%%%%%%%%%%%%%Plot time taken for number of deaths to double
% % % doubling_death_count = figure('visible','off');
% % % title('Epidemic Progression')
% % % plot(outputs.day_axis,outputs.number_died.mean ./ gradient(outputs.number_died.mean),	'Color','#A2142F','LineWidth',2);
% % % ylabel('Number of people')
% % % xlabel('Days since beginning of epidemic')
% % % legend('Died')
% % % for plot_iterations = 1:inputs.Number_of_iterations
% % % hold on
% % % transparent_plot = plot(outputs.day_axis,outputs.number_died.raw(:,plot_iterations)./gradient(outputs.number_died.raw(:,plot_iterations)),	'Color','#A2142F','LineWidth',0.3,'HandleVisibility','off');
% % % transparent_plot.Color(4) = 0.2;
% % % set(gca, 'YScale', 'log');
% % % 
% % % end
% % % set(gca,'fontname','times')
% % % 
% % %          print(doubling_death_count,'-dpng','-r300',strcat('./Results/',filename,'/time to double deaths.png'));         
            


