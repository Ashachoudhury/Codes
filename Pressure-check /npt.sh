cp npt.cpt production-0.cpt
cp npt.gro production-0.gro
rm pressure-stat.txt
rm pressure-check.txt
rm pressure.txt
i=1
echo $i
while [[ $i -gt 0 && $i -lt 100 ]]
   do
   j=$(($i-1))
   /usr/bin/gmx grompp -f npt.mdp -c production-$j.gro -t production-$j.cpt -p system.top -o production-$i.tpr -maxwarn 1
   /usr/bin/gmx mdrun -deffnm production-$i
   p=$(/usr/bin/gmx energy -f production-$i.edr -o pressure.xvg < index.txt | grep Pressure | awk '{print $2}')
   echo $p > pressure.txt
   echo $i $p >> pressure-stat.txt
   python check.py
   check=$(cat pressure-check.txt)
   rm \#*
   if [[ $check -eq 1 ]]
     then
       break
   fi
   i=$(($i+1))
   done
