import math
from matplotlib.pyplot import *

import csv

d = dict()
for line in open('test1.txt', 'r'):
  fields = line.strip().split()
  print fields
  name = fields[0]
  numseqs = int(fields[1])
  numsecs = float(fields[2])
  # throughput = math.log10(float(numseqs)/numsecs)
  throughput = (float(numseqs)/numsecs)
  point = (numseqs, throughput)
  if d.get(name) == None:
    d[name] = []
  d[name].append(point)

maxval = dict()
for n in d.keys():
  xs, ys = zip(*d[n])
  maxval[n] = max(ys)

list = sorted(maxval.items(), key=lambda x: x[1])
list.reverse()
print list

names,dummy = zip(*list)
print names

ptypes = [ 'r', 'g', 'r--', 'c', 'm', 'y:', 'b', 'g--', 'b--', 'c--', 'm--', 'y--' ] 
marker = [ '^', '^', 's', 'o', 'o', 'o', 'o', 's', 's', 's', 's' ]

i = 0
for n in names:
  # print n,max,ptypes[i]
  xs, ys = zip(*d[n])
  print ys
  semilogy(xs,ys,ptypes[i],label=n, linewidth=2, marker=marker[i])
  i = i+1

xlim(0,45000)
ylim(10,16000)
# vlines(xs, ymin, ymax, color='k', linestyles='solid')

ylabel('Throughput Seq/s')
xlabel('Translated protein sequences')

legend(names, 'upper right', shadow=True)

title('Translate DNA sequences to protein')

# sys.exit()
show()

