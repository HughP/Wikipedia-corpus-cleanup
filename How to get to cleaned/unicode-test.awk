

{ gensub(/([[:alnum:]])([^[:alnum:]])/,"\1")

{ print }

}


BEGIN {first=2}
{ FS = """"" }
/^"$/ {first=2 ; next}
/^"/ {$0 = substr($0,2)}

{
	max = split()
		for (i = first ; i ≤ max ; i = i+2 ){
			print a[i]
			}
		if (int(max/2) = max/2){
			first = 3 - first
			}
}

{print $0}
/[[:alnum:]][^[:alnum:]]/ {print "yes"}



Sed for double quotes included


s/^.*("".*"").*$/\1/g


Sed for double quotes excluded


s/^.*""(.*)"".*$/\1/g


Sed get rigt of quotes at beginign of line

s/^"//


Pattern delete forign words


s/""[^"]*""//g



perl snippet

 }
      
      
      while ($corpusLine =~ s/($word)//g)
      {
         #print "found $1 - now looking in $corpusLine\n";
         $wordCount{$1} = $wordCount{$1} + 1;
         }