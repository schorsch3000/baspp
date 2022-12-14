# baspp

`baspp` is a preprocessor for basic, mainly to be used in combination with `petcat` to target basic used in comodore computers.

## Features

- no need for line numbers
- uses named lables instead
- you can have comments in your source code that will not end up in your final code
- constants that will just be replaced with their values
- hex and binary notation
- usefull variable names
- simple increment and decrement
- include file content or command output
- remove spaces
- magic constants
-

## Usage

To run `baspp` just call it with the filename as a single parameter, optional options might be set.

To create a useable basic programm for eg. the c64 you need to run `petcat` on the output of `baspp`.
`baspp myinput.bas | petcat -w2 -o myoutput.prg`

## Options

Currently, there are 2 options implemented:

- startLineNumber which defaults to 0
- lineStep which defaults to 1

options can be set in 3 ways:

- as a command line parameter
- in the source code
- as an environment variable

this list is in the weighted order, so if you set the same option in multiple ways, the one topmost in the list above will be used.

### Command line parameter

The syntax for the command line parameter is `--optionName=optionValue`.

### Source code

The syntax for the source code is the same as for the CLI `--optionName=optionValue` and needs to be without padding in a single line.

### Environment variable

The syntax for the environment variable is `OPTIONNAME=optionValue`, yes, environment variables have to be all uppercase.

## syntax

### line numbers

Just write your code as you would do it in basic, but without line numbers. `baspp` will add them for you.
Line numbering is done starting by the option `startLineNumber` and incremented by the option `lineStep`,
Which is starting by 0 and incremented by 1 by default.

If you want to have a specific line of code at a specific line number, you can use the `#<linenumber>` directive.
with the default options this example:

```basic
print 0
print 1
#10
print 10
```

will result in:

```basic
0 print 0
1 print 1
10 print 10
```

This can be useful to have a known entry point for your program.
in this example you might want to start your program with `run 10`

Caution: If you use the `#<linenumber>` directive, you need to make sure that
the previous line numbers are smaller.

### labels

Usually for `goto` or `gosub` you would use line numbers, but with `baspp` you can use labels.
to set a label just prefix it by a colon.

labels must not be indented or mixed up with anything in their lines.

to use a label, just prefix it with a `>`, it will be replaced with the line number of the label.
example:

```basic
:mylabel
print "hello world"
goto >mylabel
```

will result in:

```basic
0 print"hello world"
1 goto0
```

### comments

You can have your basic style `rem` commends, they will stay untouched.
but you can also use `//` for comments, they will be removed from the final code.

### constants

you can set a constant by `~=nameOfTheConstant` and use it by `~nameOfTheConstant`.
example:

```basic
~=myConstant=42
print ~myConstant
```

will result in:

```basic
0 print42
```

### hex and binary notation

you can use hex and binary notation by prefixing the number with `0x` or `0b`.
example:

```basic
print 0x42
print 0b10101010
```

will result in:

```basic
0 print66
1 print170
```

### Variable name

In basic you can have variable names as long as you like, but they are distinguished just by their first letter.
to be able to have meaningfully variable names you can prefix your variables with $ and give them long names.
`baspp` will replace them with 2 letter alternatives that are unique.
example:

```basic
$myMothersMaidenName="Doe"
$myMothersLastName="Smith"
print $myMothersMaidenName
print $myMothersLastName
```

will result in:

```basic
0 af="Doe"
1 ag="Smith"
2 printaf
3 printag
```

since `baspp` will not parse your basic code you should either use plain basic variables or `baspp` variables, but not both.

there are 5 variable names that will never be generated by `baspp` to avoid collision:

```
if
or
ti
fn
st
```

you can use `ti` or `st` as variable names if you need them

#### increment and decrement

When using `$` variables you can use `++` and `--` to increment and decrement the variable.
This simply adds or subtracts 1 from the variable.

```basic
$myVar1=0
$myVar1++
$myVar2=2
$myVar2--
```

will result in:

```basic
0 af=0
1 af=af+1
2 ag=2
3 ag=ag-1
```

**Cautions:**
You can't use `++` or `--` on variables that are not `$` variables.
You can't use `++` or `--` on variables that are not defined before.
You can't use `++` or `--` inplace, or you can, baspp is fine with it, but the results are not what you like them to:

```basic
$myVar1=0
:loop
print $myVar1++
goto >loop
```

will result in:

```basic
0 af=0
1 printaf=af+1
2 goto1
```

which is really not what you whant it to be

### include

you can include the content of a file by `<filename`,
or the output of a command by `<|command`.
include statements must not be indented or mixed up with anything in their lines.

### remove spaces

since the resulting code is not meant to be read by humans, all spaces in your basic code are removed to speed up execution and lower filesize.

### magic constants

Currently, there is only one magic constant implemented: `__LINE__` which will be replaced with the current line number of the rendered basic file.
example:

```basic
print __LINE__
#10
print __LINE__
```

will result in

```basic
0 print0
10 print10
```

This is useful for example while debugging, or if you want to load additional files at runtime, which will reenter your programm.

Example:

```basic
print "loading file"
if peek(42) < __LINE__ then poke 42, __LINE__ : load "a",8,1 //this will load 'a' into some position in ram and restarts this programm assuming it will not overwrite basic ram, eg: loading a charset
if peek(42) < __LINE__ then poke 42, __LINE__ : load "b",8,1
if peek(42) < __LINE__ then poke 42, __LINE__ : load "c",8,1
print "doing something with the loaded data"
```

will result in

```basic
0 print"loading file"
1 ifpeek(42)<1thenpoke42,1:load"a",8,1
2 ifpeek(42)<2thenpoke42,2:load"b",8,1
3 ifpeek(42)<3thenpoke42,3:load"c",8,1
4 print"doing something with the loaded data"
```
