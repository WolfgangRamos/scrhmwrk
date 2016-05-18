# scrhmwrk – A class (not only) for computer science and math homework assignments

This class provides functionality for typsetting school/university
homework assignments while giving access to the features of the
`scrartcl` class.

# Licence

These files may be distributed and/or modified under the conditions of
the LaTeX Project Public License, either version 1.3 of this license
or (at your option) any later version. The latest version of this
license is in:

http://www.latex-project.org/lppl.txt

and version 1.3 or later is part of all distributions of LaTeX version
2005/12/01 or later.

# Installation

Run `make cls` to build `scrhmwrk.cls` from the `.dtx`-file. Then
build the documentation with `make pdf`.

Put `scrhmwrk.cls` in your TEX search path. Ideally you should use the
directory the environment variable `TEXMFHOME` points to (use `echo
${TEXMFHOME}` to show that directory). You can put the files in a
subdirectory if you like. I suggeset something like
`${TEXMFHOME}/tex/latex/commonstuff/scrhmwrk`. **Caution:** If you use
a different directory of the TEX search path you might need to run
`mktexlsr` (possibly as superuser) to make your TEX distribution find
the new files.

