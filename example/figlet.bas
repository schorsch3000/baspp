#!/usr/bin/env bash
text="$(figlet -f letter.tlf BASPP | grep -v "^\s*$")"
lines="$(echo "$text" | wc -l)"

echo "dim \$text\$($lines)"
echo "\$textlen=$lines"
I=0
while IFS= read -r line
do
    echo "\$text\$($I)=\"$line\"" | tr [:upper:] [:lower:]
    let I++
done < <(printf '%s\n' "$text")