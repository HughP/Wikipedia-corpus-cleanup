#!/bin/sed -f

s/.$//
s/^article//g
s/NOARTICLE//g
s/ = //g
s#</ref>##g
s/<small>//g
s/<br>//g
s/^"//g
s/^"$//g
s/""/ /g
s/  / /g
s/   / /g
s/[ \t]*$//
s/^[ \t]*//
/^$/d