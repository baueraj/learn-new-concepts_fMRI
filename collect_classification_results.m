%Andrew Bauer
%061713

close all
clear all

spm_defaults;

%% set up

addpath /usr/cluster/software/ccbi/neurosemantics/CCBI3.0/
addpath /usr/cluster/software/ccbi/neurosemantics/CCBI3.0/Utils/
addpath /usr/cluster/software/ccbi/neurosemantics/CCBI3.0/fmri_core_new/

subjPool = {'02858S','02865S','02872S','02919S','02935S','02965S','02974S','03102S','03119S'};
mask_pool = {'L_POS_MID_TEMP', 'R_POS_MID_TEMP', 'BILAT_POS_MID_TEMP', 'Fusiform_L', 'Fusiform_R', 'Fusiform_bilat'};

classifyType_pool = {'animals_concCat';
		     'animals_1_concCat';
		     'animals_2_concCat';
                     'mammals_1_concCat';
		     'mammals_2_concCat';
                     'birds_1_concCat';
		     'birds_2_concCat';};

%% begin

for classType_i = 1:length(classifyType_pool)     
    classType_dir = classifyType_pool(classType_i);
    
    if classType_i > 1
        continue
    end
    
    for mask_i = 1:length(mask_pool)    
        maskList = mask_pool(mask_i);

	if classType_i == 1
		eval(strcat(char(maskList),'_',char(classType_dir),'_words = zeros(length(subjPool),16);'));          
		eval(strcat(char(maskList),'_',char(classType_dir),'_cat = zeros(length(subjPool),2);'));   
        elseif classType_i == 2 || classType_i == 3
	end

	for sbj_i = 1:length(subjPool)
		sbj = subjPool(sbj_i);       
                
                maskList2 = strcat(char(mask_pool(mask_i)),'_',char(sbj));
                maskList2 = cellstr(maskList2);
                
                cd(strcat('/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/WithinSubject/WSA_All/',char(maskList),'/',char(classType_dir)));

		if classType_i == 1
			load(strcat(char(sbj),'_RankList.mat'));
			eval(strcat(char(maskList),'_',char(classType_dir),'_words(',num2str(sbj_i),',1:16) = transpose(rankAccWords(1:16,2));'));
		elseif classType_i == 2 || classType_i == 3
                        load(strcat(char(sbj),'_RankList.mat'));
                        eval(strcat(char(maskList),'_',char(classType_dir),'_words(',num2str(sbj_i),',1:8) = transpose(rankAccWords(1:8,2));'));
                elseif classType_i > 3 && classType_i < 6
			load(strcat(char(sbj),'_RankList.mat'));
			eval(strcat(char(maskList),'_',char(classType_dir),'_words(',num2str(sbj_i),',1:8) = transpose(rankAccWords(1:8,2));')); 
                        eval(strcat(char(maskList),'_',char(classType_dir),'_cat(',num2str(sbj_i),',1:8) = transpose(rankAccCat(1:8,2));'));
                else
                        load(strcat(char(sbj),'_RankList.mat'));
			eval(strcat(char(maskList),'_',char(classType_dir),'_words(',num2str(sbj_i),',1:4) = transpose(rankAccWords(1:4,2));')); 
                        eval(strcat(char(maskList),'_',char(classType_dir),'_cat(',num2str(sbj_i),',1:4) = transpose(rankAccCat(1:4,2));')); 
                end
        end
 
        if classType_i == 1
            eval(strcat(char(maskList),'_',char(classType_dir),'_words_mean = mean(',char(maskList),'_',char(classType_dir),'_words(:,9:end),2);'));
	elseif classType_i == 2 || classType_i == 3
            eval(strcat(char(maskList),'_',char(classType_dir),'_words_mean = mean(',char(maskList),'_',char(classType_dir),'_words,2);'));
        end

	cd('/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/');
    end
end

disp(strcat(mfilename,': done'))