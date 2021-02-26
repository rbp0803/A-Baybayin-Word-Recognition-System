%========================================================================%
%Note:                                                                   %
%This is a subfunction from the Baybayin Word Reader System              % 
%(Baybayin_word_reader.m) that is responsible for generating all the     %
%possible vowel combinations 'e'/'i' or 'o'/'u' for four or more         %
%Baybayin characters.                                                    %   
%------------------------------------------------------------------------%

%syllabe1 = the first syllable of the Latin word equivalent of the Baybayin input
%QWE      = the set of all equivalent syllables respective to the acquired
%           Latin word equivalent of the Baybayin word input
%A        = the set of equivalent Latin syllables from the second up to the last
%           character of the Baybayin word input

function Q2=first_loop_new(syllable1,QWE,A)
Q2=cat(2,syllable1,A); 

[~, col]=size(A);

nnn=col-2;

P=(1:nnn);

for i=1:nnn
    
    PP=combnk(P,i);
    
    [rowP, ~]=size(PP);
    
    for ii=1:rowP
        Z=PP(ii,:);
        Z=sort(Z);
        
        B=A;
        for iii=1:length(Z)
        
         QWE1=QWE(2,Z(iii)+2);
         QWE1=cat(1,QWE1,QWE1);
         B(:,Z(iii)+1)=QWE1;
        
        end
       
         Pseudo_Word=cat(2,syllable1,B);
         Q2=cat(1,Q2,Pseudo_Word);
    end
    
end

end
    
    
    