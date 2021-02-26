%===================================================================================%
%Note:                                                                              %
%This is a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m)%
%named BAYBAYIN OCR SYSTEM (Baybayin_only.m) that outputs the equivalent Latin unit % 
%of each Baybayin character                                                         % 
% ----------------------------------------------------------------------------------%

%Mdl= SVM Model for Baybayin characters (56x56) MAT Filname: Baybayin_Character_Classifier_00379
%input= isolated binary Baybayin character image 

function P=Baybayin_only(Mdl, input)

%List of Binary classifiers which will be used for
%reclassification of confusive Baybayin characters
Confuselist={'AVSMa_00225.mat','KaVSEI_00100.mat','smile.mat',...
             'HaVSSA_00050.mat','LaVSTa_00100.mat','PaVSYa_00550.mat'};

%Start of process         
Letter2=input;
s=regionprops(Letter2,'basic');
ss=struct2cell(s);
S=cell2mat(ss(1,:));

%===================================================================================
%If more than one component, this part is intended for the Baybayin character 'E/I'
if length(S)>=2
    E3=max(S(S<max(S)));
    if isempty(E3)
        M=56;
        Letter=imresize(Letter2, [M M]);
        P=Baybayin_letter_revised_segueway_Baybayin_only(Mdl,Letter);
        return;
    end
EE=max(S)/E3-1;
if EE<=1
    L=find(S==max(S)); 
    SS=max(S(S<max(S)));
    LL=find(S==SS);
    
    B=ss(:,L);
    BB=ss(:,LL);
    
    A=cat(1,B{3},BB{3});
    AA(1)=min(A(:,1)); AA(2)=min(A(:,2)); AA(3)=max(A(:,3)); AA(4)=abs(A(1,2)-A(2,2));
    if A(1,2)>A(2,2)
       AA(4)=AA(4)+A(1,4);
    else
       AA(4)=AA(4)+A(2,4);
    end
    
    Letter=imcrop(Letter2,AA);
    Letter=imresize(Letter,[56 56]);
    
    P=seg2_Baybayin_only_vowel_distinctor(Mdl,Letter,Letter2);
    return;
end
end
%-----------------------------------------------------------------------------------

%Identifying the main body's significant features or bounding box
L=find(S==max(S));

SS=max(S(S<max(S)));
LL=find(S==SS);

B=ss(:,L);
BB=ss(:,LL);

b=B{2};
b=b(2);


L=find(S==max(S));
B=ss(:,L);
A=B{3};
A(1)=A(1)-1; A(2)=A(2)-1; A(3)=A(3)+1; A(4)=A(4)+1;

%Cropping the main body with only its essential features
Letter=imcrop(Letter2,A);
M=56;
%Rescaling the cropped image
Letter=imresize(Letter, [M M]);
R1=regionprops(Letter,'Area');
R2=struct2cell(R1);
R3=cell2mat(R2(1,:));
%Denoising of the 56x56 size image
if length(R3)>=2
    R4=max(R3(R3<max(R3)));
    Letter=bwareaopen(Letter, R4+1);
else
    Letter=bwareaopen(Letter, 10);
end

Letter1=feature_vector_extractor(Letter);   %feature vector extraction

%------------------- Classification of Baybayin Character -------------------% 
s=regionprops(Letter2,'basic');
ss=struct2cell(s);
S=cell2mat(ss(1,:));

if length(S)==1
     P=Baybayin_letter_revised_segueway_Baybayin_only(Mdl,Letter);
     return;
end

L=find(S==max(S));

SS=max(S(S<max(S)));
LL=find(S==SS);

B=ss(:,L);
BB=ss(:,LL);

b=B{2};
b=b(2);

bb=BB{2};
bb=bb(2);

A=B{3};
A(1)=A(1)-1; A(2)=A(2)-1; A(3)=A(3)+1; A(4)=A(4)+1;

AA=BB{3};
AA(1)=AA(1)-1; AA(2)=AA(2)-1; AA(3)=AA(3)+1; AA(4)=AA(4)+1;

if b>bb
    A(4)=abs(A(2)-AA(2))+A(4);
    A(2)=AA(2);
else
A(4)=abs(AA(2)-A(2))+AA(4);
end

Letter=imcrop(Letter2,A);
Letter=imresize(Letter, [M M]);
Q=regionprops(Letter,'Area');
Q=struct2cell(Q);
Q=cell2mat(Q);
Q1=max(Q);
Q2=max(Q(Q<max(Q)));
if length(Q)>=2 && Q2<280
    
    if Q2>13
%For two or more component case (Baybayin character with a diacritic) 
        P=seg_Baybayin_only_vowel_distinctor(Mdl,Letter);
        return;
    else
        P=Baybayin_letter_revised_segueway_Baybayin_only(Mdl,Letter);
        return;
    end

else

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

end
       