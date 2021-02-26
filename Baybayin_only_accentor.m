%========================================================================%
%Note:                                                                   %
%This is a subfunction from the Baybayin Word Reader System              % 
%(Baybayin_word_reader.m) for extracting respective equivalent syllables %
%from the converted Baybayin word.                                       %  
%------------------------------------------------------------------------%

%input= syllable of the original Latin word output 

function P=Baybayin_only_accentor(input)


if strcmp(input,'a')
    P{1,1}='a';
    P{2,1}=[];
    
elseif strcmp(input,'ba')
    P{1,1}='ba';
    P{2,1}=[];
    
elseif strcmp(input,'be') || strcmp(input,'bi')
    P{1,1}='be';
    P{2,1}='bi';
    
elseif strcmp(input,'bo') || strcmp(input,'bu')
    P{1,1}='bo';
    P{2,1}='bu';
    
elseif strcmp(input,'b')
    P{1,1}='b';
    P{2,1}=[]; 
    
elseif strcmp(input,'ka')
    P{1,1}='ka';
    P{2,1}=[];
    
elseif strcmp(input,'ke') || strcmp(input,'ki')
    P{1,1}='ke';
    P{2,1}='ki';
    
elseif strcmp(input,'ko') || strcmp(input,'ku')
    P{1,1}='ko';
    P{2,1}='ku';
    
elseif strcmp(input,'k')
    P{1,1}='k';
    P{2,1}=[];
    
elseif strcmp(input,'da')
    P{1,1}='da';
    P{2,1}='ra';    
    
elseif strcmp(input,'de') || strcmp(input,'di')
    P{1,1}='de';
    P{2,1}='di';    
    
elseif strcmp(input,'do') || strcmp(input,'du')
    P{1,1}='do';
    P{2,1}='du';
    
elseif strcmp(input,'d')
    P{1,1}='d';
    P{2,1}='r';
    
    
elseif strcmp(input,'e') || strcmp(input,'i')
    P{1,1}='e';
    P{2,1}='i';    
    
elseif strcmp(input,'ga')
    P{1,1}='ga';
    P{2,1}=[];   
    
elseif strcmp(input,'ge') || strcmp(input,'gi')
    P{1,1}='ge';
    P{2,1}='gi';    
    
elseif strcmp(input,'go') || strcmp(input,'gu')
    P{1,1}='go';
    P{2,1}='gu';
    
elseif strcmp(input,'g')
    P{1,1}='g';
    P{2,1}=[];    
    
elseif strcmp(input,'ha')
    P{1,1}='ha';
    P{2,1}=[];   
    
elseif strcmp(input,'he') || strcmp(input,'hi')
    P{1,1}='he';
    P{2,1}='hi';    
    
elseif strcmp(input,'ho') || strcmp(input,'hu')
    P{1,1}='ho';
    P{2,1}='hu';
    
elseif strcmp(input,'h')
    P{1,1}='h';
    P{2,1}=[];    
    
elseif strcmp(input,'la')
    P{1,1}='la';
    P{2,1}=[];   
    
elseif strcmp(input,'le') || strcmp(input,'li')
    P{1,1}='le';
    P{2,1}='li';    
    
elseif strcmp(input,'lo') || strcmp(input,'lu')
    P{1,1}='lo';
    P{2,1}='lu';
    
elseif strcmp(input,'l')
    P{1,1}='l';
    P{2,1}=[];
    
elseif strcmp(input,'ma')
    P{1,1}='ma';
    P{2,1}=[];   
    
elseif strcmp(input,'me') || strcmp(input,'mi')
    P{1,1}='me';
    P{2,1}='mi';    
    
elseif strcmp(input,'mo') || strcmp(input,'mu')
    P{1,1}='mo';
    P{2,1}='mu';
    
elseif strcmp(input,'m')
    P{1,1}='m';
    P{2,1}=[];   
    
elseif strcmp(input,'na')
    P{1,1}='na';
    P{2,1}=[];   
    
elseif strcmp(input,'ne') || strcmp(input,'ni')
    P{1,1}='ne';
    P{2,1}='ni';    
    
elseif strcmp(input,'no') || strcmp(input,'nu')
    P{1,1}='no';
    P{2,1}='nu';
    
elseif strcmp(input,'n')
    P{1,1}='n';
    P{2,1}=[];    
  
elseif strcmp(input,'nga')
    P{1,1}='nga';
    P{2,1}=[];   
    
elseif strcmp(input,'nge') || strcmp(input,'ngi')
    P{1,1}='nge';
    P{2,1}='ngi';    
    
elseif strcmp(input,'ngo') || strcmp(input,'ngu')
    P{1,1}='ngo';
    P{2,1}='ngu';
    
elseif strcmp(input,'ng')
    P{1,1}='ng';
    P{2,1}=[];    
    
elseif strcmp(input,'o') || strcmp(input,'u')
    P{1,1}='o';
    P{2,1}='u';   
    
elseif strcmp(input,'pa')
    P{1,1}='pa';
    P{2,1}=[];   
    
elseif strcmp(input,'pe') || strcmp(input,'pi')
    P{1,1}='pe';
    P{2,1}='pi';    
    
elseif strcmp(input,'po') || strcmp(input,'pu')
    P{1,1}='po';
    P{2,1}='pu';
    
elseif strcmp(input,'p')
    P{1,1}='p';
    P{2,1}=[];    
 
elseif strcmp(input,'sa')
    P{1,1}='sa';
    P{2,1}=[];   
    
elseif strcmp(input,'se') || strcmp(input,'si')
    P{1,1}='se';
    P{2,1}='si';    
    
elseif strcmp(input,'so') || strcmp(input,'su')
    P{1,1}='so';
    P{2,1}='su';
    
elseif strcmp(input,'s')
    P{1,1}='s';
    P{2,1}=[];    
  
elseif strcmp(input,'ta')
    P{1,1}='ta';
    P{2,1}=[];   
    
elseif strcmp(input,'te') || strcmp(input,'ti')
    P{1,1}='te';
    P{2,1}='ti';    
    
elseif strcmp(input,'to') || strcmp(input,'tu')
    P{1,1}='to';
    P{2,1}='tu';
    
elseif strcmp(input,'t')
    P{1,1}='t';
    P{2,1}=[];
    
elseif strcmp(input,'wa')
    P{1,1}='wa';
    P{2,1}=[];   
    
elseif strcmp(input,'we') || strcmp(input,'wi')
    P{1,1}='we';
    P{2,1}='wi';    
    
elseif strcmp(input,'wo') || strcmp(input,'wu')
    P{1,1}='wo';
    P{2,1}='wu';
    
elseif strcmp(input,'w')
    P{1,1}='w';
    P{2,1}=[];    
    
elseif strcmp(input,'ya')
    P{1,1}='ya';
    P{2,1}=[];   
    
elseif strcmp(input,'ye') || strcmp(input,'yi')
    P{1,1}='ye';
    P{2,1}='yi';    
    
elseif strcmp(input,'yo') || strcmp(input,'yu')
    P{1,1}='yo';
    P{2,1}='yu';
    
elseif strcmp(input,'y')
    P{1,1}='y';
    P{2,1}=[];   
        
end
   







end          