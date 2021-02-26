%========================================================================%
%Note:                                                                   %
%This is a subfunction from the Baybayin OCR System (Baybayin_only.m)    % 
%that outputs the 1x3136 feature vector array of the input square matrix.% 
% -----------------------------------------------------------------------%

%data1=56x56 image data
function feature_vector_extracted=feature_vector_extractor(data1)

[row,col]=size(data1);
m=length(data1)/col;
n=col^2;

A=zeros(m,n);

for i= 1:m
    B=zeros(col);
    C=zeros(1,n);
    
    B=data1(col*(i-1)+1:i*col,:);
    for j=1:col
        C(1,col*(j-1)+1:j*col)=B(j,:);    
    end
    A(i,:)=C;
end
   feature_vector_extracted=A;     
        
        
    