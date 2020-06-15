function [raw,mean] = geoSIR_cropNmean(raw,stable,crop_full,inputs,average_end)
%Filters and averages raw data.
%
%Stable = 'Constant' or 'Zero'


if strcmpi(stable,'Constant')

raw(crop_full==0)=NaN;

raw = rmmissing(raw);

raw(raw==0) = NaN;

if strcmpi(average_end,'Yes')
for iteration_loop = 1:inputs.Number_of_iterations
    for time_loop = 2:size(raw,1)
        if isnan(raw(time_loop,iteration_loop))
            if ~isnan(raw(time_loop-1,iteration_loop))
             raw(time_loop,iteration_loop) = raw(time_loop-1,iteration_loop);
            else
             raw(time_loop,iteration_loop) = 0;
            end
        end
    end
end
end
mean = nanmean(raw,2);

elseif strcmpi(stable,'Zero')
    
    raw(crop_full==0)=NaN;

raw = rmmissing(raw);

raw(raw==0) = NaN;

if strcmpi(average_end,'Yes')

for iteration_loop = 1:inputs.Number_of_iterations
    for time_loop = 2:size(raw,1)
        if isnan(raw(time_loop,iteration_loop))
            
             raw(time_loop,iteration_loop) = 0;
            
        end
    end
end
end

mean = nanmean(raw,2);

end







