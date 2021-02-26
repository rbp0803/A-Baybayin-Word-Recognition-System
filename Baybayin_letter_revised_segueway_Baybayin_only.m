%======================================================================%
%Note:                                                                 %
%This is a subfunction from the Baybayin OCR System (Baybayin_only.m)  % 
%for classifying one component Baybayin characters                     % 
% ---------------------------------------------------------------------%

%Mdl= SVM Model for recognizing baybayin script (56x56)
%input= 56x56 binarized Baybayin character 

function P=Baybayin_letter_revised_segueway_Baybayin_only(Mdl,input)

%List of Binary classifiers which will be use for
%reclassification of confusive Baybayin characters
Confuselist={'AVSMa_00225.mat','KaVSEI_00100.mat','smile.mat',...
             'HaVSSA_00050.mat','LaVSTa_00100.mat','PaVSYa_00550.mat'};

Letter1=feature_vector_extractor(input);  %feature vector extraction

%Default Baybayin character classification
[~,~,~,Posterior]=predict(Mdl,Letter1);
[P, Label1]=max(Posterior);

if Label1==1
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='a';
    elseif lab==-1 
    P='ma';
    end
    
elseif Label1==2
    P='ba';
    
elseif Label1==3
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ka';
    elseif lab==-1 
    P='i';
    end
    
elseif Label1==4
    P='da';
    
elseif Label1==5
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ka';
    elseif lab==-1 
    P='i';
    end
    
elseif Label1==6
    P='ga';
    
elseif Label1==7
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ha';
    elseif lab==-1 
    P='sa';
    end
    
elseif Label1==8
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='la';
    elseif lab==-1 
    P='ta';
    end
    
elseif Label1==9
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='a';
    elseif lab==-1 
    P='ma';
    end
    
elseif Label1==10
    P='na';

elseif Label1==11
    P='nga';
    
elseif Label1==12
    P='u';

elseif Label1==13
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='pa';
    elseif lab==-1 
    P='ya';
    end
    
elseif Label1==14
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ha';
    elseif lab==-1 
    P='sa';
    end
    
elseif Label1==15
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='la';
    elseif lab==-1 
    P='ta';
    end
    
elseif Label1==16
    P='wa';

elseif Label1==17    
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='pa';
    elseif lab==-1 
    P='ya';
    end
end

end
     