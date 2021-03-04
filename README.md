# A-Baybayin-Word-Recognition-System
A proposed algorithm to recognize Baybayin writing system at word level.

<b> NOTE: The whole system files (Baybayin word images examples, classifiers, etc.) described here can be downloaded in Release section. Its source filename is `A.Baybayin.Word.Recognition.System.zip`. The following link provides the complete system file page:
  
https://github.com/rbp0803/A-Baybayin-Word-Recognition-System/releases/tag/v1.0
</b>

The given codes and variables are produced entirely in MATLAB whose functions or uses are describe below:

## Variables

```
Multi-SVM classifiers
• Baybayin_Character_Classifier_00379.mat - for classification of Baybayin Characters
```
```
Binary classifiers Baybayin diacritic classification
• Subscript_Classifier_00006.mat - for discriminating a dot/bar from a cross/X symbols
• Superscript_Classifier_00000.mat - for discriminating a dot from a bar symbols.
```

```
Binary classifiers which will be used for reclassification of confusive Baybayin characters
• AVSMa_00225.mat
• KaVSEI_00100.mat
• HaVSSa_00050.mat
• LaVSTa_00100.mat
• PaVSYa_00550.mat
(Note: smile.mat does not have any function. It is just there to uphold the sequence of the confuselist.) 
```

## Function Codes/Scripts
###### The Baybayin word recognition system
```
• Baybayin_word_reader.m - contains the script of the main system and has subfunction that supports the word recognition algorithm.
• c2bw.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) for converting the input rgb image into binary
           data using the modified kmeans function.
• kmeans_mod.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) for clustering a grayscaled image into 2 intensities 
                 intended for image binarization.
• Baybayin_only_accentor.m - subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) for extracting respective equivalent syllables
                             from the converted Baybayin word.
• change_QWE.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) for determining the number of syllables with                          
                 letter 'd' and their respective location in the word.
• change_QWE_process2_m2.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) for generating other words with syllables
                             'de', 'di', 'do', or 'du' which are combine or interchange with 're', 'ri', 'ro', or 'ru', respectively. This 
                             subfunction applies to the 2-character case of Baybayin word.
• change_QWE_process2_m3.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) that executes similar to
                             change_QWE_process2_m2.m function but this applies to the 3-character case of Baybayin word.
• change_QWE_process2_m4.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) that executes similar to
                             change_QWE_process2_m2.m and change_QWE_process2_m3.m functions but this function applies if the Baybayin word has       
                             four (4) or more characters.
• first_loop_new.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) that is responsible for generating all the
                     possible vowel combinations 'e'/'i' or 'o'/'u' for four or more Baybayin characters.
• part_of_the_character_finder.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) for determining the components of a 
                                   Baybayin character which will further hints us the true number of Baybayin characters from the input Baybayin word.
• permn.m - a combinatorial algorithm that is used to take the right combination of syllables syllable alteration.
• word_search_sample.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) that determines the legitimacy of the generated
                         Latin word through searching its availability in the database or dictionary.          
```
###### The Baybayin SVM-OCR System    
```
• Baybayin_only.m - a subfunction from the Baybayin Word Reader System (Baybayin_word_reader.m) named BAYBAYIN SVM-OCR SYSTEM that outputs the                                                       equivalent Latin unit of each Baybayin character. This function contains subfunctions provided below.
• feature_vector_extractor.m - a subfunction from the Baybayin SVM-OCR System (Baybayin_only.m) that outputs the 1x3136 feature vector array of the 
                               input square matrix. 
• Baybayin_letter_revised_segueway_Baybayin_only.m - a subfunction from the Baybayin SVM-OCR System (Baybayin_only.m) for classifying one component   
                                                     Baybayin characters.
• seg_Baybayin_only_vowel_distinctor.m - a subfunction from the Baybayin SVM-OCR System (Baybayin_only.m) for classifying Baybayin characters with                                                                         diacritics.                   
• seg2_Baybayin_only_vowel_distinctor.m - a subfunction from the Baybayin OCR System (Baybayin_only.m) that is intentionally made to recognize the 
                                          Baybayin character 'E/I'. Otherwise, the algorithm is designed to find if the other components are part 
                                          of the main body.
```
### A Sample Run

`Example_run_Baybayin_word_recognition.m` contains a script that executes the proposed Baybayin word recogntion system.

## Tagalog Words Database (Dictionary)

`Tagalog_words_74419+.xlsx` is a spreadsheet file that contains 74000+ Tagalog words (and some default phrases) collected from publicly available
                            Tagalog word archives in the internet.

## Acknowledgement

We would like to acknowledge the following sources for the creation of Tagalog words database, acquisition of Baybayin words from tattoo, shirt, signage and writings images, and for the implementation of an external MATLAB function (<i> permn <i>).
  1. Francisco, R. (2017, January 13). Tagalog Dictionary Scraper [Repository]. Retrieve from: https://github.com/raymelon/tagalog-dictionary-scraper/blob/master/tagalog\_dict.txt
  2. Tagalog Dictionary Available for Download. (n.d.). Retrieve from:\\ http://www.tagalog2.com/tagalog_excel.htm
  3. Gensaya, C. J. F. (2018, January 21). Tagalog Words Stemmer using Python [Repository]. Retrieve from: \\https://github.com/crlwingen/TagalogStemmerPython/blob/master/output/root\_word.txt
  4. Imperial, J. (2020, March 24). FilWordNetExtractor [Repository]. Retrieve from:\\ https://github.com/imperialite/FilWordNetExtractor/blob/master/FilWordNet\%20files/words.xlsx
  5. ARRIAN (2011, June 27). FONDVOXCURO - Baybayin Tattoos [Blog]. Retrieve from: https://s30fondvoxcuro1.blogspot.com/2011/06/baybayin-tattoos.html?m=0
  6. Etsy, Incorporated (2021). Baybayin Pilipinas Tshirt Design [Online Store]. Retrieve from: https://www.etsy.com/ie/listing/840857569/baybayin-pilipinas-tshirt-design
  7. \item GMA Public Affairs (2019, August 30). Stand for Truth: Baybayin, magagamit na sa smartphone? [Youtube Video, 00:12 mark]. Retrieve from: https://www.youtube.com/watch?v=HaM3mpXBlgU
  8. Calipusan, Ricky Jr. (2020, December 24). Ricky's Calligraphy [Facebook Post]. Retrieve from: https://www.facebook.com/photo?fbid=1391529684512434&set=gm.3415224601937527
  9. Jos (10584) (2019, January 19). permn, MATLAB Central File Exchange. Retrieved from: https://www.mathworks.com/matlabcentral/fileexchange/7147-permn
