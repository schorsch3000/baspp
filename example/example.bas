<consts.bas
<|info.bas
<init.bas
<|figlet.bas
print "{clr}"
poke ~TEXT_COLOR,1
print $buildinfo$
print
print
$color=1
:loop
for $i=0 to $textlen
  print $text$($i)
  poke ~TEXT_COLOR,$color
  $color=$color+1
  if $color=16 then $color=1
next $i
print "{home}"
print
print
print
goto >loop
end