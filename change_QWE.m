%========================================================================%
%Note:                                                                   %
%This is a subfunction from the Baybayin Word Reader System              % 
%(Baybayin_word_reader.m) for determining the number of syllables with   %
%letter 'd' and their respective location in the word.                   %  
%------------------------------------------------------------------------%

%QWE= the set of all equivalent syllables respective to the acquired
%     Latin word equivalent of the Baybayin word input

function [q,qq,w,ww]=change_QWE(QWE)

A=QWE(1,:);
a=length(A);
q=zeros(1,a);
w=zeros(1,a);
qq=0;
ww=0;

for i=1:a
if strcmp(A{i},'de') || strcmp(A{i},'di')
q(i)=1;
qq(i)=i;
elseif strcmp(A{i},'do') || strcmp(A{i},'du')
w(i)=1;
ww(i)=i;
end
end
q=sum(q);
w=sum(w);

end
