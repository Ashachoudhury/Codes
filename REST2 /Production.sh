cat lambda.txt | while read i;
do
        mkdir eq$i
        plumed partial_tempering $i < processed_hot.top > eq$i/topol$i.top
        /usr/local/gromacs/bin/gmx_mpi grompp -maxwarn 1 -o eq$i/md.tpr -f md_rest2.mdp -c md.gro -p eq$i/topol$i.top
done
mpirun -np 10 /usr/local/gromacs/bin/gmx_mpi mdrun -deffnm md -plumed ../plumed.dat -multidir eq* -replex 100 -hrex -dlb no -ntomp 1 -v
