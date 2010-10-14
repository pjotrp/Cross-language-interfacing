from matplotlib.pyplot import *

import csv

d = dict()
for line in open('test1.txt', 'r'):
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

ptypes = [ 'r', 'g', 'b', 'c', 'm', 'y:', 'r--', 'g--', 'b--', 'c--', 'm--', 'y--' ] 

i = 0
for n in names:
  # print n,max,ptypes[i]
  xs, ys = zip(*d[n])
  print ys
  plot(xs,ys,ptypes[i],label=n, linewidth=2, marker='o')
  i = i+1

# xlim(45,510)
# ylim(-0.1,6)
# vlines(xs, ymin, ymax, color='k', linestyles='solid')

ylabel('time (sec)')
xlabel('sequences')

legend(names, 'upper left', shadow=True)

title('Translate DNA sequences to protein (lower is better)')

# sys.exit()
show()

