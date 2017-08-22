%Andrew Bauer
%072413

close all
clear all

spm_defaults;

%% set up

addpath /usr/cluster/software/ccbi/neurosemantics/CCBI3.0/
addpath /usr/cluster/software/ccbi/neurosemantics/CCBI3.0/Utils/
addpath /usr/cluster/software/ccbi/neurosemantics/CCBI3.0/fmri_core_new/
addpath /usr/cluster/software/ccbi/neurosemantics/CCBI3.0/fmri_core_new/Utils/

subjPool = {'02858S','02865S','02872S','02919S','02935S','02965S','02974S','03102S','03119S'};
mask_pool = {'L_POS_MID_TEMP', 'R_POS_MID_TEMP', 'BILAT_POS_MID_TEMP', 'Fusiform_L', 'Fusiform_R', 'Fusiform_bilat'};
maskPath = '/usr/cluster/projects3/animals_learn/analysis/ROIs/'; %most ROIs here

newCmat_animals_concCat = '/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/CmatFiles/SPM_para_animals_featCat_versPic_newCmat.txt' ;
newCmat_animals_1_concCat = '/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/CmatFiles/SPM_para_ani_1_versPic_aniCat_newCmat.txt' ;
newCmat_animals_2_concCat = '/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/CmatFiles/SPM_para_ani_2_versPic_aniCat_newCmat.txt' ;
newCmat_mammals_1_concCat = '/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/CmatFiles/SPM_paradigm_mammals_1_concCat_newCmat.txt' ;
newCmat_mammals_2_concCat = '/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/CmatFiles/SPM_paradigm_mammals_2_concCat_newCmat.txt' ;
newCmat_birds_1_concCat = '/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/CmatFiles/SPM_paradigm_birds_1_concCat_newCmat.txt' ;
newCmat_birds_2_concCat = '/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/CmatFiles/SPM_paradigm_birds_2_concCat_newCmat.txt' ;

classifyType_pool = {'animals_concCat',newCmat_animals_concCat;		
		     'animals_1_concCat',newCmat_animals_1_concCat;
		     'animals_2_concCat',newCmat_animals_2_concCat;
                     'mammals_1_concCat',newCmat_mammals_1_concCat;
		     'mammals_2_concCat',newCmat_mammals_2_concCat;
                     'birds_1_concCat',newCmat_birds_1_concCat;
		     'birds_2_concCat',newCmat_birds_2_concCat;};
 
classifyTaskList = {'Words','Categories'};
%classifyTaskList = {'Categories'};
classifyTaskList2 = {'Words'};

%% analysis

for classType_i = 1:size(classifyType_pool,1)
    classes = classifyType_pool(classType_i,1);     
    
    if classType_i > 1
        continue
    else
        classifyTaskList_input = classifyTaskList2;
    end

    for mask_i = 1:length(mask_pool)
        maskList = mask_pool(mask_i);

        for sbj_i = 1:length(subjPool)
            sbj = subjPool(sbj_i);
 
            newCmat = classifyType_pool(classType_i,2);
            
            if mask_i < 5  
                WSA_useThisForAll('WSA_param_useThisForAll', sbj, maskList, classifyTaskList_input, char(newCmat), maskPath);
            else
                WSA_useThisForAll('WSA_param_useThisForAll', sbj, maskList, classifyTaskList_input, char(newCmat));
            end
            
	    movefile(strcat('/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/WithinSubject/WSA_All/',char(maskList),'/*.*'),strcat('/usr/cluster/projects3/animals_learn/analysis/fromScratch/animals_learn/WithinSubject/WSA_All/',char(maskList),'/',char(classes)));
        end
    end
end

disp(strcat(mfilename,': done'))
