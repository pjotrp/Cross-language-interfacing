from matplotlib.pyplot import *

import csv

d = dict()
for line in open('test2.txt', 'r'):
  fields = line.strip().split()
  print fields
  name = fields[0]
  numseqs = int(fields[1])
  numsecs = float(fields[2])
  point = (numseqs, numsecs)
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

ptypes = [ 'r', 'g', 'b', 'c', 'm', 'y--', 'r--', 'g:', 'b--', 'c--', 'm--', 'g:', 'r:' ]
marker = [ '^', 'o', 's', 's', 'o', 'o', 'o', '^', 'o', 'o', 's', 's', 's', 's' ]

i = 0
for n in names:
  print n,max,ptypes[i]
  xs, ys = zip(*d[n])
  print ys
  plot(xs,ys,ptypes[i],label=n, linewidth=2, marker=marker[i])
  i = i+1

xlim(800,25000)
ylim(-0.1,120)
# vlines(xs, ymin, ymax, color='k', linestyles='solid')

ylabel('time (sec)')
xlabel('sequences')

legend(names, 'upper left', shadow=True)

title('Translate mRNA sequences to protein (lower is better)')


# sys.exit()
show()

