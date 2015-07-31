#!/bin/bash

#Author: Hugh Paterson III
#Date: 29 July 2015
#Purpose: This script cleans up wikipedia dump so that it can be processed.

################################################################################
# Corpus Clean Up
################################################################################

#Find the files we are going to operate on.
CORPORA=$(find * -iname '*wiki-ori.txt')


#For each of the files, lets extract and count the non-target language words and
#their characters. These are contained in double quotes (in the navajo text).
for i in $CORPORA; do
	#We extract the words and then reverse the words. So that we can sort the 
	#words by suffix. It is often the case that latin words make up a large 
	#percentage of these terms.
	#Current behavior is putting these files in the same location as the corproa.
	#However, these should probably go in their own folder/dir.
	awk -f Awk-scripts/double-quote-list.awk "${i}" | rev > "${i%%.txt}"-extracted-terms-rev.txt
	LC_ALL=C sort "${i%%.txt}"-extracted-terms-rev.txt | rev > "${i%%.txt}"-extracted-terms.txt	
done

EXTRACTED_LIST=$(find * -iname '*-extracted-terms.txt')

for i in $EXTRACTED_LIST; do
	awk -f Awk-scripts/latin-list.awk "${i}" > "${i%%.txt}"-latin-terms.txt
done

#Now to keep things clean lets go back and delete those source files for $EXTRACTED_LIST.
for i in $CORPORA; do
	rm -rf "${i%%.txt}"-extracted-terms-rev.txt
	rm -rf "${i%%.txt}"-extracted-terms.txt	
done

#Now lets get rid of the extra punctuation characters which we know are extraneous
#and are not really typed by users. (See the comments below for specifics.)

#First create the version of the corpus we are going to edit and title it.
for i in $CORPORA; do
	cp "${i}" "${i%%.txt}"-clean.txt
done

#Lets create a lit of "cleanded corpora" to be operated on.
CLEAN_CORPORA_LIST=$(find * -iname '*-clean.txt')

for i in $CLEAN_CORPORA_LIST; do
	#Lets remove:
	#Change all line endings from windows line endings to unix line endings.
	#Remove all instances of where the term 'article' is the first word on a line.
	#Remove all instances of NOARTICLE
	#Remove equal signs '=' when used for headding formating this is ' = '.
	#Remove line beginging single instance of a double quote
	#Remove line ending single instance of a double quote
	#Remove pre-identified markup tags by name. Tags include: </ref>, <small>, <br>.
	#Remove all instances of two consecutive spaces replace with a single instance of a space
	#Remove all instances of three consecutive spaces replace with a single instance of a space
	#Remove all instances of line trailing white space
	#Remove all instances of line leading white space
	#Remove all instaces of instances of '\n\n'.
	sed -i.bak -f Sed-scripts/faux-punctuation-removal.sed $i
	rm -rf *.bak #Remove sed backup
done

#Lets make a copy at this point because we might need to come back to it.



##Now Lets put a space around all the existing characters which are included in the POSIX class of punctuation.
#
##I need to do 6 things with the corpora.
##1. I need to recreated the finger sroke path with a given keyboard to: measure finger load, Finger travel distance, key load, rotations and line jumps.
##2. I need to create a phoneme to finger stroke ratio. - How many key strokes on average does it take to produce a phoneme?
##3. I need to create a diacritic density computation. - What is the reading density of this orthography?
##4. I need to describe the writing script use in a corpus. - What percentage of the Navajo writing experinece is actually writing Navajo?
##5. I need to create a finger stroke to "letter" ratio. - What is a "letter"? How many finger strokes do not produce a "letter"?
##6. I need to create a phoneme span index. - This is the length of keystrokes between the onset of a phoneme and the resolution of the same phoneme.
#
## The purpose of this script is to make a list of all the items within a double set of double quotes ("" some term ""). These sets of double quotes surround items in the Wikipedia corpora which are presented in the wikipedia web pages in italics. In the Navajo corpus the use of italics generally means that the terms are non-navajo words. They may be English, Latin or some other language. The reason these need to be extracted and accounted for is that when phoneme counts are conducted against the corpus. That is the wikipedia corpus is used to varify the phoneme percentages in both the study in the 1960s and in the New Testament book of James. If non-Navajo language text is included in the corpus, then phoneme counts will be disporportional ot other corproas. This is especially true when the corpus sizes are smaller, such as in this case. When these terms which are contained within the sets of double quotes are extracted from the corpus. We can count the characters used via the functional-units count and also count them with UnicodeCCount. This will give us some quantification to remove from global counts. 
#
#
#REMOVE
#
#Pattern "$ -->\n AND THEN \n\n --> \n
#
#Pattern copy out contents of ""thing to copy"" So that a list can be made.
#Count spaces.
#Insert spaces around puntuation marks. So that puntuation marks are not inclueded in word strings.
#
#UnicodeCCount for characters... Find Non-visible characters, discover what they are.
#   Need spaces around them: between numbers: '–'
#   							'wordend"'
#   							
#   							'wordend punctuation: ',' ');' ';'
#   						
#Account for the following terms:
#
#   1 中文,
#   1 华语/華語,					  
#   							     1 مصر
#   1 ᏣᎳᎩ
#   							     1 عيسى‎
#   							     
#   1 язык"
#   1 Έρις").
#   1 שקל‎)
#   1 大韓民國)
#   1 πους),
#   1 δεινός
#   1 σαῦρος
#   1 Монгол
#   1 Россия
#   1 ゼルダの伝説",
#   1 μικρός,
#   1 России,
#   1 العربي;
#   1 السورية
#   2 العربية
#   1 جمهورية
#   1 παιδεία"
#   1 Πλούτων").
#   1 الشعبية)
#   1 गणराज्य)
#   1 България
#   1 יֵשׁוּעַ
#   1 বাংলাদেশ)
#   1 ‘Ὠκεανός,
#   1 Република
#   1 Федерация
#   1 агентство
#   1 الجزائرية
#   1 الجمهورية
#   1 Российская
#   1 Δημοκρατία)
#   1 ὀργανισμός,
#   1 Федеральное
#   1 космическое
#   1 الديمقراطية
#   1 Херцеговина)
#   1 Հանրապետություն)
#count text with UCount to get spaces.