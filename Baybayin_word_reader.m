% ---------------------------------------------------------------------------------------%
% A Baybayin Word Recognition System                                                     %                           
% by Rodney Pino, Renier Mendoza and Rachelle Sambayan                                   %
% Programmed by Rodney Pino at University of the Philippines - Diliman                   %
% Programming dates: September 2020 to February 2021                                     %     % 
% ---------------------------------------------------------------------------------------%

% =============================================================== %
% Note:                                                           %
% One has to load first the needed classifier in the workspace    %
% to complete the function inputs.                                %
% --------------------------------------------------------------- %

%Mdl= SVM Model for Baybayin characters (56x56) MAT Filename: Baybayin_Character_Classifier_00379
%a=input Baybayin word image
%orig code

function [output]=Baybayin_word_reader(Mdl, a)
%tic;

%Start of preprocessing
A=imread(a);
[~,v2]=c2bw(A);         % rgb to binary image conversion
size(v2);               % image size information
v2=bwareaopen(v2,10);   % removing small or noise components

%=======Acquisition of Text Properties using the built-in ocr function=======%

% ================================================================= %
% Note:                                                             %
% The template is set this way for the reason that the ocr function %
% may still produce the text properties even if the languages used  %
% cannot be applied to the input characters. This is due to the     %
% novelty of Baybayin OCR and there are no available Baybayin word  %
% OCR at the time of making this project                            %
% ------------------------------------------------------------------%

text=ocr(v2, 'Language','Tagalog','Language','Japanese','TextLayout','Word');
RW  = text.Words;

if isempty(RW)
text=ocr(v2, 'Language','Tagalog','Language','Japanese','TextLayout','Block');
RW  = text.Words;
if isempty(RW)
    error('Was not able to read the text. Sorry');
end
end    

%----------------------------------------------------------------------------%

%======================== Word Segmentation Process ========================%
output=cell(1,1); %presetting the whole text as one word
WBB = text.WordBoundingBoxes;
[row, ~]=size(WBB);
CBBvolt_in=cell(row,1);
PPPs=cell(row,1);
num_char=zeros(row,1);
for i=1:row
    P=WBB(i,:);
    PP=[P(1)-1 P(2)-1 P(3)+1 P(4)+1];
    PPP=imcrop(v2, PP);
    PPP=bwareaopen(PPP,13);
    S=regionprops(PPP,'basic');
s=struct2cell(S);
[~,cs]=size(s);
CC=zeros(1, cs);
BBs=s(3,:);
for j=1:cs
    C=s{2,j};
    CC(j)=C(1);
end
C3=sort(CC);
CCC=sort(CC);

[~, colPPP]=size(PPP);
threshold_val=colPPP/(length(CCC)+1);

%----------------- computing each character bounding boxes -----------------%
for jj=1:cs-1
    for k=jj+1:cs
    if abs(CCC(jj)-CCC(k))<threshold_val
        CCC(k)=0;
    end
    end
end

K=part_of_the_character_finder(CCC);  %determines the component(s) of a Baybayin character 
                                      %from (each) word bounding boxes obtained from 
                                      %OCR function 
                                      
CBB=cell(1,length(K));
kcol1=0;
for q=1:length(K)
    
    [~, kcol]=size(K{q});
    C5=C3(1,1+kcol1:kcol1+kcol);
    
    kcol1=kcol1+kcol;
    
    Q=zeros(1,length(C5));
    BB=[];
    for qq=1:length(C5)
        [~, idx]=find(CC==C5(qq));
        Q(qq)=idx(1);
        BB=cat(1,BB,BBs{Q(qq)});
    end

    BB1=BB(:,1);
    BB2=BB(:,2);
    BB3=BB(:,3);
    BB4=BB(:,4);
    
    AA1=min(BB2); AA2=max(BB2);
    AA3=abs(AA1-AA2);
    [~, idx]=max(BB2);
    AA4=AA3+BB4(idx);
   
    CBB{q}=[min(BB1) min(BB2) max(BB3) AA4];
    
    
end
%---------------------------------------------------------------------------%

[~, m]=size(CBB);
for cb=1:m
CBBvolt_in{i}=CBB;
end
num_char(i)=m;
PPPs{i}=PPP;

end

%---------------------------------------------------------------------------%

[~,Tagalog_words , ~]=xlsread('Tagalog_words_74419+.xlsx'); % Installing the Tagalog Word 
                                                            % Database (Dictionary)
                                                            
%======================== Baybayin to Latin Conversion - Word Level ========================%
                                                            
      K1=cell(sum(num_char),1);
      for ppp=1:length(PPPs)
      PPPP=PPPs{ppp};    
      [~,m]=size(CBBvolt_in{ppp});
      CBB_new1=CBBvolt_in{ppp};
      CBB_new=[];
        for cbb=1:m
            CBB_new=cat(1,CBB_new, CBB_new1{cbb});
        end
        K=cell(1,m);

      for ii=1:m
      crop=CBB_new(ii,:);
      crop=[crop(1)-1 crop(2)-1 crop(3)+1 crop(4)+1];
      character=imcrop(PPPP,crop);                      %Isolating the character

      P=Baybayin_only(Mdl, character);                  %Baybayin OCR System whose output is the equivalent 
                                                        %Latin unit of the Baybayin character
        K{ii}=P;
      end
      K1(sum(num_char(1:ppp))-(num_char(ppp))+1:sum(num_char(1:ppp)))=K;
      end
        KK=strjoin(K1,'');                              %KK is the original Latin word output
        m=sum(num_char);                                %Represents the possible number of characters found
        
      KK1=word_search_sample(Tagalog_words, KK);        %Search KK in the Tagalog Database; Checking its legitimacy 
 
%------------------------------ Extra Word Generator ------------------------------%
 D=isempty(KK1);
 
 if D==1  %If KK is nowhere to be found in the dictionary, this process searches other distinct  
          %Tagalog word that is also a Latin equivalent from the Baybayin input    

QWE=cell(2,m);

     for ii=1:m
      character=K1{ii};   
      P=Baybayin_only_accentor(character);  %Syllable Extraction

      [QWE_size,~]=size(QWE);
      
      QWE(:,ii)=P;
     end  

Q2=cell(QWE_size.^m,1);

        if m==1     %Syllable Alteration if the input Baybayin word has only one character
           Q2_new=QWE;
           KK2=cell(length(Q2_new),1);
           for s=1:length(Q2_new)
              KK2{s,1}=word_search_sample(Tagalog_words,Q2_new{s,1});  %Checking the legitimacy of each generated word              
           end
           
           Check1=find(~cellfun(@isempty,KK2),1);
              
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end    
            
        elseif m==2 %Syllable Alteration if the input Baybayin word has two characters
            word1{1,1}=QWE{1,1}; word1{1,2}=QWE{1,2};
            word1{2,1}=QWE{1,1}; word1{2,2}=QWE{2,2};
            word1{3,1}=QWE{2,1}; word1{3,2}=QWE{1,2};
            word1{4,1}=QWE{2,1}; word1{4,2}=QWE{2,2};
            
            for ww=1:4
              B2=word1(ww,1:2);
              Check2=find(~cellfun(@isempty,B2));
              nume=numel(Check2);
                if nume~=length(B2)
                   Q2{ww,1}=[];
                else
                   Q2{ww,1}=strjoin(word1(ww,:),'');
                end
            end
            
            Q2_new1=[];
            Q2_new=Q2(~cellfun(@isempty,Q2));
            
            KK2=cell(length(Q2_new),1);
            for w=1:length(Q2_new)
              KK2{w,1}=word_search_sample(Tagalog_words,Q2_new{w,1});  %Checking the legitimacy of each generated word  
            end  
              
            Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
              
      %-----------------------Syllable alteration from 'd' to 'r'-----------------------% 
               [q,qq,w,ww]=change_QWE(QWE);  %determines the number of syllables with letter 'd' and their respective
                                             %location in the word
             if q~=0 || w~=0          
                
        [KK2, Q2_new3]=change_QWE_process2_m2(QWE,q,qq,w,ww,m, Tagalog_words);    %generator function for 'd' or 'r' syllables      
        Q2_new2=[];
              for new3=1:length(Q2_new3)
                  Q2_new2=cat(1, Q2_new2, Q2_new3{new3}); 
              end
                for q2_new=1:length(Q2_new2)
                   Q2_new1=cat(1,Q2_new1,Q2_new2{q2_new});
                end                
              
              Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
              
            end
      %---------------------------------------------------------------------------------%      
  
                                     
        elseif m==3 %Syllable Alteration if the input Baybayin word has three characters
            word2{1,1}=QWE{1,1}; word2{1,2}=QWE{1,2}; word2{1,3}=QWE{1,3}; 
            word2{2,1}=QWE{1,1}; word2{2,2}=QWE{1,2}; word2{2,3}=QWE{2,3};
            word2{3,1}=QWE{1,1}; word2{3,2}=QWE{2,2}; word2{3,3}=QWE{1,3};
            word2{4,1}=QWE{1,1}; word2{4,2}=QWE{2,2}; word2{4,3}=QWE{2,3};
            word2{5,1}=QWE{2,1}; word2{5,2}=QWE{1,2}; word2{5,3}=QWE{1,3}; 
            word2{6,1}=QWE{2,1}; word2{6,2}=QWE{1,2}; word2{6,3}=QWE{2,3};
            word2{7,1}=QWE{2,1}; word2{7,2}=QWE{2,2}; word2{7,3}=QWE{1,3};
            word2{8,1}=QWE{2,1}; word2{8,2}=QWE{2,2}; word2{8,3}=QWE{2,3};
            
            
            for ww=1:8
              B2=word2(ww,1:3);
              Check2=find(~cellfun(@isempty,B2));
              nume=numel(Check2);
                if nume~=length(B2)
                   Q2{ww,1}=[];
                else
                   Q2{ww,1}=strjoin(word2(ww,:),'');
                end
            end
            
            Q2_new1=[];
            Q2_new=Q2(~cellfun(@isempty,Q2));
            
            KK2=cell(length(Q2_new),1);
            for w=1:length(Q2_new)
              KK2{w,1}=word_search_sample(Tagalog_words,Q2_new{w,1});   %Checking the legitimacy of each generated word  
            end  
            
            Check1=find(~cellfun(@isempty,KK2),1);
          
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end

      %-----------------------Syllable alteration from 'd' to 'r'-----------------------%              
        [q,qq,w,ww]=change_QWE(QWE);    %determines the number of syllables with letter 'd' and their respective
                                        %location in the word
            if q~=0 || w~=0
                   
       [KK2, Q2_new3]=change_QWE_process2_m3(QWE,q,qq,w,ww,m, Tagalog_words);    %generator function for 'd' or 'r' syllables          
        Q2_new2=[];
              for new3=1:length(Q2_new3)
                  Q2_new2=cat(1, Q2_new2, Q2_new3{new3}); 
              end
                for q2_new=1:length(Q2_new2)
                   Q2_new1=cat(1,Q2_new1,Q2_new2{q2_new});
                end
                
              Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
              
            end      
      %---------------------------------------------------------------------------------%            
            
            
        else
          
     %Syllable alteration if the input Baybayin word has four or more characters       
        word3=[];
        [~, col4]=size(QWE);    
            for z=1:2
                syllab0=QWE(z,1);
                syllab11=cat(1,syllab0,syllab0);
                for z2=1:2
                    syllab1{1,1}=QWE{z2,2}; syllab1{2,1}=QWE{z2,2};
                                     
                        for zz=1:1                   
                            syllab2=QWE(zz,3:col4);
                            syllab3=QWE(zz,3:col4-1);
                            syllab4=QWE(2,col4);
                            syllab5=cat(2,syllab3,syllab4);
                            syllab6=cat(1,syllab2,syllab5);
                        end
                    pseudo_word1=cat(2,syllab1,syllab6);
                    pseudo_word2=first_loop_new(syllab11,QWE,pseudo_word1);     %new word generator function
                    word3=cat(1,word3,pseudo_word2);
                end
                
            end
            [rowQ,~]=size(word3);
            
                for ww=1:rowQ
              B2=word3(ww,1:m);
              Check2=find(~cellfun(@isempty,B2));
              nume=numel(Check2);
                if nume~=length(B2)
                   Q2{ww,1}=[];
                else
                   Q2{ww,1}=strjoin(word3(ww,:),'');
                end
                
                end
                
            Q2_new1=[];
            Q2_new=Q2(~cellfun(@isempty,Q2));
            
            KK2=cell(length(Q2_new),1);
            for w=1:length(Q2_new)
              KK2{w,1}=word_search_sample(Tagalog_words,Q2_new{w,1});   %Checking the legitimacy of each generated word  
            end  
              
            Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
 
      %-----------------------Syllable alteration from 'd' to 'r'-----------------------%              
            [q,qq,w,ww]=change_QWE(QWE);    %determines the number of syllables with letter 'd' and their respective
                                            %location in the word
            if q~=0 || w~=0                
                
        [KK2, Q2_new3]=change_QWE_process2_m4(QWE,q,qq,w,ww,m, Tagalog_words);  %generator function for 'd' or 'r' syllables          
        Q2_new2=[];
              for new3=1:length(Q2_new3)
                  Q2_new2=cat(1, Q2_new2, Q2_new3{new3}); 
              end
                for q2_new=1:length(Q2_new2)
                   Q2_new1=cat(1,Q2_new1,Q2_new2{q2_new});
                end
                
              Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
              
            end
      %---------------------------------------------------------------------------------%                  
         end

 else   %If KK is a legit Tagalog word, this process searches other distinct  
        %Tagalog word that is also a Latin equivalent from the Baybayin input 
     
        output=cell(1,1);
        output{1,1}=KK;
        
 QWE=cell(2,m);

     for ii=1:m
      character=K1{ii};   
      P=Baybayin_only_accentor(character);      %Syllable Extraction

      [QWE_size,~]=size(QWE);
      
      QWE(:,ii)=P;
     end  

Q2=cell(QWE_size.^m,1);

        if m==1     %Syllable Alteration if the input Baybayin word has only one character
           Q2_new=QWE;
           
           if strcmp(Q2_new{i},'de') || strcmp(Q2_new{i},'di')
               Q2_new{3}='re'; Q2_new{4}='ri';
           end
           if strcmp(Q2_new{i},'do') || strcmp(Q2_new{i},'du')
               Q2_new{3}='ro'; Q2_new{4}='ru';
           end
               
           KK2=cell(length(Q2_new),1);
           for s=1:length(Q2_new)
              KK2{s,1}=word_search_sample(Tagalog_words,Q2_new{s,1});   %Checking the legitimacy of each generated word             
           end
           
           Check1=find(~cellfun(@isempty,KK2),1);
              
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end    
            
        elseif m==2     %Syllable Alteration if the input Baybayin word has two characters
            word1{1,1}=QWE{1,1}; word1{1,2}=QWE{1,2};
            word1{2,1}=QWE{1,1}; word1{2,2}=QWE{2,2};
            word1{3,1}=QWE{2,1}; word1{3,2}=QWE{1,2};
            word1{4,1}=QWE{2,1}; word1{4,2}=QWE{2,2};
            
            for ww=1:4
              B2=word1(ww,1:2);
              Check2=find(~cellfun(@isempty,B2));
              nume=numel(Check2);
                if nume~=length(B2)
                   Q2{ww,1}=[];
                else
                   Q2{ww,1}=strjoin(word1(ww,:),'');
                end
            end
            
            Q2_new=Q2(~cellfun(@isempty,Q2));
            
            KK2=cell(length(Q2_new),1);
            for w=1:length(Q2_new)
              KK2{w,1}=word_search_sample(Tagalog_words,Q2_new{w,1});   %Checking the legitimacy of each generated word 
            end  
              
            Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
  
      %-----------------------Syllable alteration from 'd' to 'r'-----------------------%              
            [q,qq,w,ww]=change_QWE(QWE);    %determines the number of syllables with letter 'd' and their respective
                                            %location in the word
            if q~=0 || w~=0
                  
              KK2=change_QWE_process2_m2(QWE,q,qq,w,ww,m, Tagalog_words);   %generator function for 'd' or 'r' syllables  
                
              Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
              
            end  
      %---------------------------------------------------------------------------------%              
                                     
        elseif m==3     %Syllable Alteration if the input Baybayin word has three characters
            word2{1,1}=QWE{1,1}; word2{1,2}=QWE{1,2}; word2{1,3}=QWE{1,3}; 
            word2{2,1}=QWE{1,1}; word2{2,2}=QWE{1,2}; word2{2,3}=QWE{2,3};
            word2{3,1}=QWE{1,1}; word2{3,2}=QWE{2,2}; word2{3,3}=QWE{1,3};
            word2{4,1}=QWE{1,1}; word2{4,2}=QWE{2,2}; word2{4,3}=QWE{2,3};
            word2{5,1}=QWE{2,1}; word2{5,2}=QWE{1,2}; word2{5,3}=QWE{1,3}; 
            word2{6,1}=QWE{2,1}; word2{6,2}=QWE{1,2}; word2{6,3}=QWE{2,3};
            word2{7,1}=QWE{2,1}; word2{7,2}=QWE{2,2}; word2{7,3}=QWE{1,3};
            word2{8,1}=QWE{2,1}; word2{8,2}=QWE{2,2}; word2{8,3}=QWE{2,3};
            
            
            for ww=1:8
              B2=word2(ww,1:3);
              Check2=find(~cellfun(@isempty,B2));
              nume=numel(Check2);
                if nume~=length(B2)
                   Q2{ww,1}=[];
                else
                   Q2{ww,1}=strjoin(word2(ww,:),'');
                end
            end
            
            Q2_new=Q2(~cellfun(@isempty,Q2));
            
            KK2=cell(length(Q2_new),1);
            for w=1:length(Q2_new)
              KK2{w,1}=word_search_sample(Tagalog_words,Q2_new{w,1});   %Checking the legitimacy of each generated word  
            end  
            
            Check1=find(~cellfun(@isempty,KK2),1);
          
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end

      %-----------------------Syllable alteration from 'd' to 'r'-----------------------%              
        [q,qq,w,ww]=change_QWE(QWE);    %determines the number of syllables with letter 'd' and their respective
                                        %location in the word
            if q~=0 || w~=0
                
                
              KK2=change_QWE_process2_m3(QWE,q,qq,w,ww,m, Tagalog_words);  %generator function for 'd' or 'r' syllables
                
              Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
              
            end      
      %---------------------------------------------------------------------------------%                  
            
            
        else %Syllable Alteration if the input Baybayin word has four or more character
                    
        word3=[];
        [~, col4]=size(QWE);    
            for z=1:2
                syllab0=QWE(z,1);
                syllab11=cat(1,syllab0,syllab0);
                for z2=1:2
                    syllab1{1,1}=QWE{z2,2}; syllab1{2,1}=QWE{z2,2};
                                     
                        for zz=1:1                   
                            syllab2=QWE(zz,3:col4);
                            syllab3=QWE(zz,3:col4-1);
                            syllab4=QWE(2,col4);
                            syllab5=cat(2,syllab3,syllab4);
                            syllab6=cat(1,syllab2,syllab5);
                        end
                    pseudo_word1=cat(2,syllab1,syllab6);
                    pseudo_word2=first_loop_new(syllab11,QWE,pseudo_word1);     %new word generator function
                    word3=cat(1,word3,pseudo_word2);
                end
                
            end
            [rowQ,~]=size(word3);
            
                for ww=1:rowQ
              B2=word3(ww,1:m);
              Check2=find(~cellfun(@isempty,B2));
              nume=numel(Check2);
                if nume~=length(B2)
                   Q2{ww,1}=[];
                else
                   Q2{ww,1}=strjoin(word3(ww,:),'');
                end
                
                end
            
            Q2_new=Q2(~cellfun(@isempty,Q2));
            
            KK2=cell(length(Q2_new),1);
            for w=1:length(Q2_new)
              KK2{w,1}=word_search_sample(Tagalog_words,Q2_new{w,1});   %Checking the legitimacy of each generated word  
            end  
              
            Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
      
      %-----------------------Syllable alteration from 'd' to 'r'-----------------------%              
            [q,qq,w,ww]=change_QWE(QWE);    %determines the number of syllables with letter 'd' and their respective
                                            %location in the word
            if q~=0 || w~=0
                
                
              KK2=change_QWE_process2_m4(QWE,q,qq,w,ww,m, Tagalog_words);   %generator function for 'd' or 'r' syllables  
                
              Check1=find(~cellfun(@isempty,KK2),1);
            
              if isempty(Check1)
               output{1,1}=KK;  
              else
               Check=find(~cellfun(@isempty,KK2),1);
               output{1,1}=KK2{Check,1};   
              end
              
            end
      %---------------------------------------------------------------------------------%                        
                                        
        end     
        
       
 end
%----------------------------------------------------------------------------------%
%===========================================================================================%
 
%-------------------------------Print Recognized Word-------------------------------%

 if isempty(Check1)     %If the system observes no legitimate Latin Tagalog word found,
                        %the system outputs all the generated Latin words.
    fprintf('The word is not in the dictionary. The possible translations are as follows...');
    if  m~=1 && ~isempty(Q2_new1)
        Q2_new=[];
    elseif m==1    
        Q2_new1=Q2_new;
        Q2_new=[];
    end
 KK2=cat(1,Q2_new,Q2_new1);
 for kk2=1:length(KK2)
           if strcmp(output,KK2{kk2})
               KK2{kk2}=[];
           end
 end
 KK2=KK2(~cellfun(@isempty,KK2));
 
 else   %If a legitimate Latin Tagalog word is found,
        %the system outputs all the legitimate Latin word equivalent of 
        %the input Baybayin word.
     
        for kk2=1:length(KK2)
           if strcmp(output,KK2{kk2})
               KK2{kk2}=[];
           end
        end

KK2=KK2(~cellfun(@isempty,KK2));

        
 end 
        output=cat(1,output,KK2);
%toc;
end
