%========================================================================%
%Note:                                                                   %
%This is a subfunction from the Baybayin Word Reader System              % 
%(Baybayin_word_reader.m) for generating other words with syllables      %
%'de', 'di', 'do', or 'du' which are combine or interchange with         %
%'re', 'ri', 'ro', or 'ru', respectively.                                %
%                                                                        %
%This subfunction applies to the 2-character case of Baybayin word       %
%------------------------------------------------------------------------%

%QWE= the set of all equivalent syllables respective to the acquired
%     Latin word equivalent of the Baybayin word input
%q  = the number of 'de' or 'di' syllables in the word
%qq = the respective locations of the 'de' or 'di' syllables in the word
%y  = the number of 'do' or 'du' syllables in the word
%yy = the respective locations of the 'do' or 'du' syllables in the word
%m  = the total number of Baybayin characters found
%Tagalog_words = the Tagalog Word Dictionary

function [K5, Q2_new1]=change_QWE_process2_m2(QWE,q,qq,y,yy,m,Tagalog_words)


A=cell(2,2);
A{1,1}='de'; A{2,1}='di';
A{1,2}='re'; A{2,2}='ri';

B=cell(2,2);
B{1,1}='do'; B{2,1}='du';
B{1,2}='ro'; B{2,2}='ru';

M=permn([1 2],q);
if isempty(M)
    MM=1;
else
[MM,~]=size(M);
end

N=permn([1 2], y);
if isempty(N)
    NN=1;
else
[NN,~]=size(N);
end

qq( :, ~any(qq,1)) = [];
yy( :, ~any(yy,1)) = [];
K5=[];
Q2_new1=cell(NN,1);
for j=1:NN
    if isempty(yy)
        QWE=QWE;
    else
        NNN=N(j,:);
        for t=1:length(yy)
            QWE(:,yy(t))=B(:,NNN(t));
        end
        
        
    end
    
 Q2_new3=cell(MM,1);       
    for jj=1:MM
      if isempty(qq)
        QWE=QWE;
    else
        MMM=M(jj,:);
        for t=1:length(qq)
            QWE(:,qq(t))=A(:,MMM(t));
        end
        
        
      end  
                

Q2=cell(2.^m,1);

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
            Q2_new3{jj}=Q2_new;
            
            KK2=cell(length(Q2_new),1);
            for w=1:length(Q2_new)
              KK2{w,1}=word_search_sample(Tagalog_words,Q2_new{w,1}); %Checking the legitimacy of each generated word 
            end  
           
            
            K4=KK2(~cellfun('isempty',KK2));
            K5=cat(1,K5,K4);
            
    end
    Q2_new1{j}=Q2_new3;
end

end