%======================================================================%
%Note:                                                                 %
%This is a subfunction from the Baybayin OCR System (Baybayin_only.m)  % 
%for classifying Baybayin characters with diacritics                   % 
% ---------------------------------------------------------------------%

%Mdl= SVM Model for Baybayin characters (56x56) MAT Filname: Baybayin_Character_Classifier_00379
%input= 56x56 Baybayin binarized image

function P=seg_Baybayin_only_vowel_distinctor(Mdl,input)

%List of Binary classifiers which will be use for
%reclassification of confusive Baybayin characters
Confuselist={'AVSMa_00225.mat','KaVSEI_00100.mat','smile.mat',...
             'HaVSSA_00050.mat','LaVSTa_00100.mat','PaVSYa_00550.mat'};

%Loading Baybayin diacritic classifiers         
load Subscript_Classifier_00006.mat Subscript_Classifier_00006;
load Superscript_Classifier_00000.mat Superscript_Classifier_00000;

Mdl_accent1=Superscript_Classifier_00000;
Mdl_accent2=Subscript_Classifier_00006;
         
s=regionprops(input,'basic');
ss=struct2cell(s);
S=cell2mat(ss(1,:));

%Location segmentation
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

%Separation of main body from the accent
Letter2=imcrop(input, A);
Letter2=imresize(Letter2, [56 56]);
Letter2=bwareaopen(Letter2, 100);
Letter1=feature_vector_extractor(Letter2);

Accent1=imcrop(input, AA);



Accent1( ~any(Accent1,2), : ) = [];  %rows
Accent1( :, ~any(Accent1,1) ) = [];  %columns
[row, col]=size(Accent1);

[r, c]=size(Accent1);
rr=c/r;

%If an accent is a bar, a padding will be produced for it to become a
%square image
if rr>=5
    if col>row
    add=abs(col-row);
    pad=round(add/2);
    pad1=zeros(pad,col);
    Accent1=cat(1,pad1,Accent1,pad1);
elseif row>col
    add=abs(row-col);
    pad=round(add/2);
    pad1=zeros(row,pad);
    Accent1=cat(2,pad1,Accent1,pad1);
    end
end

%Classification of Baybayin characters
[~,~,~,Posterior]=predict(Mdl,Letter1);
[P, Label1]=max(Posterior);

%If the accent symbol is placed above the main character
if b>bb
    
    Accent1=imresize(Accent1, [56 56]);
    Accent1(:,1:2)=0;
    Accent1(:,55:56)=0;
    Accent1(1:2,:)=0;
    Accent1(55:56,:)=0;
    Accent1=bwareaopen(Accent1, 13);
    Accent2=feature_vector_extractor(Accent1);
    [label,~]=predict(Mdl_accent1,Accent2);
    
    if label==-1
    
    if Label1==1
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='me';
    elseif lab==-1 
    P='me';
    end
    
elseif Label1==2
    P='be';
    
elseif Label1==3
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ke';
    elseif lab==-1 
    P='ke';
    end
    
elseif Label1==4
    P='de';
    
elseif Label1==5
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ke';
    elseif lab==-1 
    P='ke';
    end
    
elseif Label1==6
    P='ge';

elseif Label1==7
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='he';
    elseif lab==-1 
    P='se';
    end
    
elseif Label1==8
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='le';
    elseif lab==-1 
    P='te';
    end
    
elseif Label1==9
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='me';
    elseif lab==-1 
    P='me';
    end
    
elseif Label1==10
    P='ne';

elseif Label1==11
    P='nge';
    
elseif Label1==12
    P='u';

elseif Label1==13
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='pe';
    elseif lab==-1 
    P='ye';
    end
    
elseif Label1==14
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='he';
    elseif lab==-1 
    P='se';
    end
    
elseif Label1==15
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='le';
    elseif lab==-1 
    P='te';
    end
    
elseif Label1==16
    P='we';

elseif Label1==17
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='pe';
    elseif lab==-1 
    P='ye';
    
    end
    
    end
    
    else
        
    if Label1==1
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='mi';
    elseif lab==-1 
    P='mi';
    end
    
elseif Label1==2
    P='bi';
    
elseif Label1==3
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ki';
    elseif lab==-1 
    P='ki';
    end
    
elseif Label1==4
    P='di';
    
elseif Label1==5
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ki';
    elseif lab==-1 
    P='ki';
    end
    
elseif Label1==6
    P='gi';
    
elseif Label1==7
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='hi';
    elseif lab==-1 
    P='si';
    end
    
elseif Label1==8
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='li';
    elseif lab==-1 
    P='ti';
    end
    
elseif Label1==9
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='mi';
    elseif lab==-1 
    P='mi';
    end
    
elseif Label1==10
    P='ni';

elseif Label1==11
    P='ngi';
    
elseif Label1==12
    P='u';

elseif Label1==13
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='pi';
    elseif lab==-1 
    P='yi';
    end
    
elseif Label1==14
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='hi';
    elseif lab==-1 
    P='si';
    end
    
elseif Label1==15
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='li';
    elseif lab==-1 
    P='ti';
    end
    
elseif Label1==16
    P='wi';

elseif Label1==17
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='pi';
    elseif lab==-1 
    P='yi';
    end
    
    end
    
    end
    
%If the accent symbol is placed below the main character
else
    Accent1=imresize(Accent1, [56 56]);
    Accent1(:,1:2)=0;
    Accent1(:,55:56)=0;
    Accent1(1:2,:)=0;
    Accent1(55:56,:)=0;
    Accent1(23:35,15:44)=1;
    Accent2=feature_vector_extractor(Accent1);
    [~,~,~,Posterior]=predict(Mdl_accent2,Accent2);
    [P, label]=max(Posterior);
    
   %If the identified accent is a bar or a dot symbol 
    if label==1
    
          if Label1==1
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='mo';
    elseif lab==-1 
    P='mo';
    end
    
elseif Label1==2
    P='bo';
    
elseif Label1==3
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ko';
    elseif lab==-1 
    P='ko';
    end
    
elseif Label1==4
    P='do';
    
elseif Label1==5
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ko';
    elseif lab==-1 
    P='ko';
    end
    
elseif Label1==6
    P='go';
    

elseif Label1==7
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ho';
    elseif lab==-1 
    P='so';
    end
    
elseif Label1==8
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='lo';
    elseif lab==-1 
    P='to';
    end
    
elseif Label1==9
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='mo';
    elseif lab==-1 
    P='mo';
    end
    
elseif Label1==10
    P='no';

elseif Label1==11
    P='ngo';
    
elseif Label1==12
    P='o';

elseif Label1==13
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='po';
    elseif lab==-1 
    P='yo';
    end
    
elseif Label1==14
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ho';
    elseif lab==-1 
    P='so';
    end
    
elseif Label1==15
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='lo';
    elseif lab==-1 
    P='to';
    end
    
elseif Label1==16
    P='wo';

elseif Label1==17
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='po';
    elseif lab==-1 
    P='yo';
    end
    
         end
 
        
    
    elseif label==2
           
        if Label1==1
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='mu';
    elseif lab==-1 
    P='mu';
    end
    
elseif Label1==2
    P='bu';
    
elseif Label1==3
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ku';
    elseif lab==-1 
    P='ku';
    end
    
elseif Label1==4
    P='du';
    
elseif Label1==5
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='ku';
    elseif lab==-1 
    P='ku';
    end
    
elseif Label1==6
    P='gu';
    

elseif Label1==7
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='hu';
    elseif lab==-1 
    P='su';
    end
    
elseif Label1==8
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='lu';
    elseif lab==-1 
    P='tu';
    end
    
elseif Label1==9
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='mu';
    elseif lab==-1 
    P='mu';
    end
    
elseif Label1==10
    P='nu';

elseif Label1==11
    P='ngu';
    
elseif Label1==12
    P='u';

elseif Label1==13
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='pu';
    elseif lab==-1 
    P='yu';
    end
    
elseif Label1==14
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='hu';
    elseif lab==-1 
    P='su';
    end
    
elseif Label1==15
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='lu';
    elseif lab==-1 
    P='tu';
    end
    
elseif Label1==16
    P='wu';

elseif Label1==17
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='pu';
    elseif lab==-1 
    P='yu';
    end
    
        end
    
        
%If the identified accent is a cross or an X symbol               
    elseif label==3
        
           if Label1==1
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='m';
    elseif lab==-1 
    P='m';
    end
    
elseif Label1==2
    P='b';
    
elseif Label1==3
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='k';
    elseif lab==-1 
    P='k';
    end
    
elseif Label1==4
    P='d';
    
elseif Label1==5
    Check01=load(Confuselist{2});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='k';
    elseif lab==-1 
    P='k';
    end
    
elseif Label1==6
    P='g';
    
elseif Label1==7
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='h';
    elseif lab==-1 
    P='s';
    end
    
elseif Label1==8
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='l';
    elseif lab==-1 
    P='t';
    end
    
elseif Label1==9
    Check01=load(Confuselist{1});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='m';
    elseif lab==-1 
    P='m';
    end
    
elseif Label1==10
    P='n';

elseif Label1==11
    P='ng';
    
elseif Label1==12
    P='u';

elseif Label1==13
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='p';
    elseif lab==-1 
    P='y';
    end
    
elseif Label1==14
    Check01=load(Confuselist{4});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='h';
    elseif lab==-1 
    P='s';
    end
    
elseif Label1==15
    Check01=load(Confuselist{5});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='l';
    elseif lab==-1 
    P='t';
    end
    
elseif Label1==16
    P='w';

elseif Label1==17
    Check01=load(Confuselist{6});
    Check02=struct2cell(Check01);
    Check03=Check02{1};
    [lab,~]=predict(Check03,Letter1);
    if lab==1
    P='p';
    elseif lab==-1 
    P='y';
    end
    
           end
           
    end
    
end
    
end

