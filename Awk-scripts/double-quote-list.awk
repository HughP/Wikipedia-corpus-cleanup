#!/bin/awk -f

#Author: Albert Bickford
#	   : Hugh Paterson III
#Date: 27 July 2015
#Liceense: GPL


#Start the script Awk processes the input a single line at a time.
#Set the variable 'first' to an even number. So that the toggle statement at the end works.
BEGIN {first=2}
#If the line ends with a single a double quote then move to the next line.
/^"$/ {first=2 ; next}
#Lets skip the first instance
/^"/ {$0 = substr($0,2)}

#Lets take the input and make an array with all the items delimited by the regex string '""'.
{ max = split($0,a,/""/);
		for (i = first ; i <= max ; i=i+2 ){
			
			#Lets print all cases of 'a'
			#print a[i]
			
			#Lets print with custom formating all cases of 'max' followed by 'tab' followed by 'a' followed by a 'newline'
			printf max "\t" a[i] "\n"		
			#print [match(a, /^a$/)] >> latin.txt
			#print max
			#print in column one if the string ends in -a -m -s -ae or -ii
			#print in column two (or don't print) if string contains: two ʼ, one ʼ and one diacritic, a į (ogonk), or contains ł or Ł
			#else print in column three
			}
#		Let's create a toggle statement 
#		if (int((max + 0)/2) = max/2){
#			first = 3-first
#			}
}

#If I go to an external file then I can only print lines which are from my lists.... and pass those to future input.