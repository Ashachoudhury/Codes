rm -rf eq*
for i in {1..70..1};
do
        mkdir eq$i
        /usr/local/gromacs/bin/gmx_mpi grompp -f npt$i.mdp -o eq$i/npt.tpr -c min.gro -r min.gro -n index.ndx -p topol.top -maxwarn 10
done
mpirun -np 70 /usr/local/gromacs/bin/gmx_mpi mdrun -deffnm npt -multidir eq{1..70} -ntomp 1
for i in {1..70..1};
do
        /usr/local/gromacs/bin/gmx_mpi grompp -f md$i.mdp -o eq$i/md.tpr -c eq$i/npt.gro -r eq$i/npt.gro -t eq$i/npt.cpt -n index.ndx -p topol.top -maxwarn 10
done
mpirun -np 70 /usr/local/gromacs/bin/gmx_mpi mdrun -deffnm md -multidir eq{1..70} -replex 100 -ntomp 1 -pin on
