for system in wt al ar
do
        for condition in water 330k urea
        do
#paste com_Na_$i.xvg e_Na_A_$i.xvg | grep -v "#" | grep -v "@" | awk '{print $2, $4}' > Na-a_$i.txt
rm free-energy-surf-$system-$condition.txt
rm tmp.txt
cat << eof > free-energy-surface_a.f
c234567
      integer :: n, x, i, k, l, p, m, rgl, rgh, rml, rmh
      integer :: fr1, fr2, rpf
      real ::  a, b, c, y, d, gl, ml, gh, mh
      call system("cp rgrm-$system-$condition.txt file1")
      call system("wc -l file1 | awk '{print \$1}'> a.txt")
      open(1,file='a.txt',status='old')
      read(1,*)n
      open(6,file='range.txt',status='old')
      read(6,*)gl, ml
      read(6,*)gh, mh
      rgl=abs(gl*100) - 2
      rgh=abs(gh*100) + 2
      rml=0
      rmh=abs(mh*100) + 2
      write(*,90)rgl, rgh, rml, rmh
90    FORMAT(4I3)
      open(2,file='free-energy-surf-$system-$condition.txt',status='new')
      open(3,file='rgrm-$system-$condition.txt',status='old')
c      do 10 k=40,100,1
      do 10 k=rgl,rgh,1
      open(4,file='tmp.txt',status='new')
      rewind(3)
      m=0
       do i=1,n
        read(3,*)a,b,fr1
        if (a > k*0.01 .AND. a <= (k+1)*0.01) then
          write(4,*)k,b,fr1
          m=m+1
        endif
       enddo
      close(4)
      open(5,file='tmp.txt',status='old')
c      do 20 l=0,50,1
      do 20 l=rml,rmh,1
       rewind(5)
       x=0
       rpf = 0
       do p=1,m
        read(5,*)c,d,fr2
        if (d > l*0.01 .AND. d <= (l+1)*0.01) then
         x = x + 1
         rpf = fr2
c         write(*,*) x
        endif
       enddo
       y = x/n
       write(2,91)(k*0.01)+0.005,(l*0.01)+0.005,x,rpf
91    FORMAT(2F6.3, 2I10)
20    continue
      close(5)
      call system("rm -f tmp.txt")
10    continue
      end
eof
rm free-energy-surface.out
f95 free-energy-surface_a.f -o free-energy-surface.out
./free-energy-surface.out
frame=$(cat a.txt)
echo $frame
awk '{print $1, $2, -1.97*.3*log($3/'$frame'), $4}' free-energy-surf-$system-$condition.txt > fes-$system-$condition.txt
min=$(sort -nu -k 3 fes-$system-$condition.txt | tail -n1 | awk '{print $3}')
echo $min
sed -i 's/inf/'$min'/g' fes-$system-$condition.txt
rm free-energy-surf-$system-$condition.txt
done
done
