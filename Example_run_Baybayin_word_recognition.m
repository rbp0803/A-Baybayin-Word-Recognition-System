%Example script to implement the Proposed Baybayin Word Recognition System
%We need to load first the Baybayin classifier in the workspace.
%After that, you can copy the command to the command window then press
%return. Or, you can simply Run this script.

%Mdl= SVM Model for Baybayin characters (56x56)
%MAT Filename: Baybayin_Character_Classifier_00379

output=Baybayin_word_reader(Baybayin_Character_Classifier_00379, 'Baybayin Word - Pilipinas.png')

%You can also try the other given image.

%output=Baybayin_word_reader(Baybayin_Character_Classifier_00379, 'Baybayin Word - Pinagpala.png')