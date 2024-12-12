cat temp.txt | while read replica temp;
do
        sed -e 's/TEMP/'$temp'/g' npt.mdp > npt$replica.mdp
        sed -e 's/TEMP/'$temp'/g' md.mdp > md$replica.mdp
done
