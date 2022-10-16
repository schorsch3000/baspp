 0 af$="build on heilig at 2022-10-16 by heilig"
 1 poke53280,0
 2 poke53281,0
 3 dimag$(5)
 4 af=5
 5 ag$(0)="bbbb    a    ssss pppp  pppp  "
 6 ag$(1)="b   b  a a  s     p   p p   p "
 7 ag$(2)="bbbb  aaaaa  sss  pppp  pppp  "
 8 ag$(3)="b   b a   a     s p     p     "
 9 ag$(4)="bbbb  a   a ssss  p     p     "
10 print"{clr}"
11 poke646,1
12 printaf$
13 print
14 print
15 ag=1
16 forah=0toaf
17 printag$(ah)
18 poke646,ag
19 ag=ag+1
20 ifag=16thenag=1
21 nextah
22 print"{home}"
23 print
24 print
25 print
26 goto16
27 end
