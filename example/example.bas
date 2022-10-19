<consts.bas
<|info.bas
<init.bas
<|figlet.bas
print "{clr}"
poke ~TEXT_COLOR,1
print $buildinfo$
print
print

:loop
  for $i=0 to $textlen
    print $text$($i)
    poke ~TEXT_COLOR,int(rnd(1)*14+1)
  next $i
  print "{home}"
  print
  print
  print
goto >loop
end