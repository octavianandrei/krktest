#!/bin/bash

#use the subject 4 text for playing
subject_4=$(echo "4. Script kiddies: Source or come up with a text manipulation problem and solve it with at least two of awk, sed, tr
and / or grep. Check the question below first though, maybe. [10pts]")
#grab number of points for this exercise / using tr and remove []
points=$(echo $subject_4 | awk 'NF>1{print $NF}' | tr -d "[]")
#awk with variables to combine text and send it to an output file
echo $subject_4 | awk 'BEGIN{var=ARGV[1];ARGV[1]=""} {print var, $2,$11}' "$points" > output.txt
#sed the output file for final text
sed -i 's/Script/for script/g' output.txt
#display the final output text and adding a grep color
cat output.txt | grep --color '10pts'
