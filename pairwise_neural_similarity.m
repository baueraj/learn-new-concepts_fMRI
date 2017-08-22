%Andrew Bauer
%021815

close all
clear all

%% set up

load neural_similarity_data

noSimulations = 100000;

%% analysis

%compute real data indices
tempHabHigh = mean(data_hab((end-noStimInHighGrp+1):end,:),1);
tempHabLow = mean(data_hab(1:(end-noStimInHighGrp),:),1);
realIndex_hab = (tempHabHigh(1) - tempHabHigh(2)) - (tempHabLow(1) - tempHabLow(2));

tempDietHigh = mean(data_diet((end-noStimInHighGrp+1):end,:),1);
tempDietLow = mean(data_diet(1:(end-noStimInHighGrp),:),1);
realIndex_diet = (tempDietHigh(1) - tempDietHigh(2)) - (tempDietLow(1) - tempDietLow(2));

realIndex_avgBoth = mean([(tempHabHigh(1) - tempHabHigh(2)); (tempDietHigh(1) - tempDietHigh(2))]) - ...
        mean([(tempHabLow(1) - tempHabLow(2)); (tempDietLow(1) - tempDietLow(2))]);

%get simulation indices, to compare real indices against
storeSimIndex_hab = nan(noSimulations,1);
storeSimIndex_diet = nan(noSimulations,1);
storeSimIndex_avgBoth = nan(noSimulations,1);

for s = 1:noSimulations
    shuffled_data_hab = data_hab(randperm(size(data_hab,1)),:);
    tempHabHigh = mean(shuffled_data_hab((end-noStimInHighGrp+1):end,:),1); %could randomize indexing too
    tempHabLow = mean(shuffled_data_hab(1:(end-noStimInHighGrp),:),1);
    storeSimIndex_hab(s,1) = (tempHabHigh(1) - tempHabHigh(2)) - (tempHabLow(1) - tempHabLow(2));
    
    shuffled_data_diet = data_diet(randperm(size(data_diet,1)),:);
    tempDietHigh = mean(shuffled_data_diet((end-noStimInHighGrp+1):end,:),1);
    tempDietLow = mean(shuffled_data_diet(1:(end-noStimInHighGrp),:),1);
    storeSimIndex_diet(s,1) = (tempDietHigh(1) - tempDietHigh(2)) - (tempDietLow(1) - tempDietLow(2));
    
    storeSimIndex_avgBoth(s,1) = mean([(tempHabHigh(1) - tempHabHigh(2)); (tempDietHigh(1) - tempDietHigh(2))]) - ...
        mean([(tempHabLow(1) - tempHabLow(2)); (tempDietLow(1) - tempDietLow(2))]);
end

%compute p-values
pval_realIndex_hab = 1 - normcdf(realIndex_hab, mean(storeSimIndex_hab,1), std(storeSimIndex_hab));
pval_realIndex_diet = 1 - normcdf(realIndex_diet, mean(storeSimIndex_diet,1), std(storeSimIndex_diet));
pval_realIndex_avgBoth = 1 - normcdf(realIndex_avgBoth, mean(storeSimIndex_avgBoth,1), std(storeSimIndex_avgBoth));

disp(strcat(mfilename,': done'));