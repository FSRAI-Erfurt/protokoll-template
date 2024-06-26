# FSAI Protokoll Template

Authors:
- Luise Schultze
- Lucas Brendgen

## Einleitung:
TODO :)

## How to use:
for ease of use we provide a preconfigured envirunment using nixos direnv. we also provide a Makefile for building the template.

### Requirements:
- pdflatex
- (make)

### Building the template:
```bash
make 
```
or if you dont want to use make
```bash
# building a latex project requires multiple runs of pdflatex to resolve all references
pdflatex -output-directory=build src/main.tex
pdflatex -output-directory=build src/main.tex
```


