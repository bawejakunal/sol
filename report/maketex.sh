#!/bin/bash

# Compile twice for content table correctness
pdflatex -synctex=1 -interaction=nonstopmode --shell-escape $1 &&
pdflatex -synctex=1 -interaction=nonstopmode --shell-escape $1