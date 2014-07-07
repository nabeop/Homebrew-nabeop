#!/bin/sh

############# IMPORTANT NOTE FOR USERS   ##########################

# If you have installed latex in an unusual place, specify that place here
yourlatexpath=""

# common case
commonlatexpath="/usr/local/bin/"

# MacPort case
macportlatexpath="/opt/local/bin/"

# Fink case
finklatexpath="/sw/local/bin/:/sw/bin/"

# TeXLive case (MacTeX?)
texlivetexpath="/usr/texbin/:/Applications/pTeX.app/teTeX/bin/"

##################################################################


#arguments:
#  $1: index
#  $2: equation sequence (must be enclosed by double quotation  "")
#  $3: flag for rotation. the third arugment = "r" if you want to rotate the text.

#path setting for latex commands
PATH="${yourlatexpath}:${texlivetexpath}:${commonlatexpath}:${macportlatexpath}:${finklatexpath}:${PATH}"

/bin/echo $PATH

#file name and equation body
name=latex$1
eq=$2

#go to the working folder
cd ~/Library/Caches/MjoGraph

#create .tex file
if [ $3 = "r" ]; then
    /bin/echo "\\documentclass[12pt]{article}\\usepackage{amssymb,amsmath,rotating}\\pagestyle{empty}\\renewcommand{\\rmdefault}{phv} \\renewcommand{\\sfdefault}{ptm} \\renewcommand{\\ttdefault}{pcr}" "\\""begin{document} \\begin{sideways}$"${eq}"$ \\end{sideways} \\""end{document}" > $name.tex
else
    /bin/echo "\\documentclass[12pt]{article}\\usepackage{amssymb,amsmath}\\pagestyle{empty}\\renewcommand{\\rmdefault}{phv} \\renewcommand{\\sfdefault}{ptm} \\renewcommand{\\ttdefault}{pcr}" "\\""begin{document} $"${eq}"$ \\""end{document}" > $name.tex
fi




#check
cat $name.tex

#compile and create .pdf file
pdflatex -interaction nonstopmode $name.tex
pdfcrop $name.pdf tmp1.pdf
ps2pdf14 -dAutoRotatePages#/None tmp1.pdf tmp2.pdf
#ps2pdf14 -dAutoRotatePages=/None tmp1.pdf tmp2.pdf
mv -f tmp2.pdf $name.pdf

#clean up
#rm -f $name.log $name.aux $name.tex

