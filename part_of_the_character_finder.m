%========================================================================%
%Note:                                                                   %
%This is a subfunction from the Baybayin Word Reader System              % 
%(Baybayin_word_reader.m) for determining the components of a Baybayin   %
%character which will further hints us the true number of Baybayin       % 
%characters from the input Baybayin word.                                %  
%------------------------------------------------------------------------%

%X=predetermined abscissa locations (zero represents it is a part of the preceding component)

function K=part_of_the_character_finder(X)

Kn=nnz(X);
K=cell(Kn,1);
Finder=find(X);

for i=1:Kn
    if i==Kn
        
        K{i}=zeros(1,length(X)+1-Finder(Kn));
        C=K{i};
        C(1)=X(Finder(i));
        K{i}=C;
        break;
    end
 K{i}=zeros(1,Finder(i+1)-Finder(i));
 C=K{i};
 C(1)=X(Finder(i));
 K{i}=C;
end

end


