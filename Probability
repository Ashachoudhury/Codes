#Run as following
#python probability.py top-multiframe.txt(file containing order parameter values) 100(bin number)
import os
import numpy as np
import sys
filename = sys.argv[1]
bin = int(sys.argv[2])
#output = sys.argv[3]
#get the frame number and atom number for different atoms
exec(open("line-number.py").read())
nline = file_len(filename)
print (nline)
#get the coordinate of each atom in each frame
a = 1
n = 0
s = -1
#list1 = []
list2 = []
fname=filename
with open(fname) as file:
     for i, line in enumerate(file):
             list1 = line.split()
             #print(list1)
             list2.append(float(list1[0]))


width = (np.amax(list2)-np.amin(list2))/bin
list3=np.histogram(list2, bins=bin)
list4=list3[0]/(nline*width)
list5=list3[1]
np.savetxt('tmp1.txt', list4)
np.savetxt('tmp2.txt', list5)
os.system('paste tmp2.txt tmp1.txt > output.txt')
os.system('rm tmp2.txt tmp1.txt')
