rm head.txt tail.txt range.txt
for system in wt aliphatic aromatic
do
        for condition in water 330k urea
        do
if [ "$system" == "aromatic" ]
then
/usr/bin/gmx rms -f $system/$condition/trajectory-500ns-nopbc-protein.xtc -s $system/$condition/system.tpr -n $system/$condition/index.ndx -o rmsd.xvg < index2.txt
/usr/bin/gmx gyrate -f $system/$condition/trajectory-500ns-nopbc-protein.xtc -s $system/$condition/system.tpr -n $system/$condition/index.ndx -o rg.xvg < index3.txt
else
/usr/bin/gmx rms -f $system/$condition/trajectory-500ns-nopbc-protein.xtc -s $system/$condition/first-frame-protein.gro -n $system/$condition/index.ndx -o rmsd.xvg < index2.txt
/usr/bin/gmx gyrate -f $system/$condition/trajectory-500ns-nopbc-protein.xtc -s $system/$condition/first-frame-protein.gro -n $system/$condition/index.ndx -o rg.xvg < index3.txt
fi
grep -v "@" rmsd.xvg | grep -v "#" > rmsd-$system-$condition.txt
grep -v "@" rg.xvg | grep -v "#" > rg-$system-$condition.txt
paste rg-$system-$condition.txt rmsd-$system-$condition.txt | awk '{print $2,$7,$1}' > rg_rmsd_$system-$condition.txt
a=$(sort -nu -k 1 rg_rmsd_$system-$condition.txt | head -n1 |awk '{print $1}')
b=$(sort -nu -k 2 rg_rmsd_$system-$condition.txt | head -n1 |awk '{print $2}')
echo $a $b >> head.txt
a=$(sort -nu -k 1 rg_rmsd_$system-$condition.txt | tail -n1 |awk '{print $1}')
b=$(sort -nu -k 2 rg_rmsd_$system-$condition.txt | tail -n1 |awk '{print $2}')
echo $a $b >> tail.txt
done
done
a=$(sort -nu -k 1 head.txt | head -n1 |awk '{print $1}')
b=$(sort -nu -k 2 head.txt | head -n1 |awk '{print $2}')
echo $a $b >> range.txt
a=$(sort -nu -k 1 tail.txt | tail -n1 |awk '{print $1}')
b=$(sort -nu -k 2 tail.txt | tail -n1 |awk '{print $2}')
echo $a $b >> range.txt
rm \#*
rm head.txt
rm tail.txt
rm rg.xvg
rm rmsd.xvg
