#!/bin/awk -f

#Author: Hugh Paterson III
#Date: 27 July 2015
#License: GPL

BEGIN{first=1}

#If the line has a ł move to the next line.
/ł|Ł/ {first=1 ; next}
/̨|´|ę́ę́|ǫ|ó|ą|áá|ą́ą́|óó|íí|éé|é|í|į́|ę́|á|neʼ|Dene|į|aaʼ|iiʼ|Tʼ|kʼ|tʼ|tl|hiTSʼezh/ {first=1 ; next}



# Lets add to our array all lines which end with -a -m -s -ae or -ii. we can use the '|' 'or' syntax. 

#Actually I am not getting this to work as expected. So I just skipped all lines with Navaho characters. The regex with the line endings are not picking up just the latin words either.
#Latin in this case is truly being "non-Navajo". Idealy for multicorpus work it would be true "latin".
{ latin = split($0,b,/^ae$|^um$|^us$/);
 for (i=first; i<=latin; i++){
			print b[i]
			#print [match(a, /^a$/)] >> latin.txt
			#print max
			#print in column one if the string ends in -a -m -s -ae or -ii
			#print in column two (or don't print) if string contains: two ʼ, one ʼ and one diacritic, a į (ogonk), or contains ł or Ł
			#else print in column three
			}
#		if (int((max + 0)/2) = max/2){
#			first = 3-first
#			}
}