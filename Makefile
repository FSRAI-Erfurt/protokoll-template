# Latex build utils:

# Ensure that Make Version supports .RECIPEPREFIX
ifeq ($(origin .RECIPEPREFIX), undefined)
	$(error This Make version does not support RECIPEPREFIX. Please Use GNU Make 4.0 or Later!)
endif

# Ensure that all project Dependencies are installed
ensure-commands-exists = $(foreach command,$1,\
  $(if $(shell command -v $(command)),some string,$(error "Could not find executable '$(command)' - please install '$(command)'")))
_ := $(call ensure-commands-exists,curl sed touch jq awk find)

# MAKE behavioral rules
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
MAKEFLAGS += --no-print-directory
MAKEFLAGS += --silent
.ONESHELL:
.SECONDEXPANSION:
.RECIPEPREFIX := >
.DEFAULT_GOAL := build
.PHONY: clean help build

LATEX != command -v pdflatex
BUILD_DIR := build
SRC_DIR := src
LATEX_FILE := $(SRC_DIR)/main.tex

#HELP: Builds the latex document
build:
# ensure that the build directory exists
> mkdir -p $(BUILD_DIR)
# build the latex document twice to ensure that all references are resolved
# this is a wierd quirk of latex as packages like toc and hyperref need to be
# run twice to resolve all references and links
> $(LATEX) -output-directory=$(BUILD_DIR) $(LATEX_FILE) > /dev/null 
> $(LATEX) -output-directory=$(BUILD_DIR) $(LATEX_FILE) > /dev/null

#HELP: Cleans the build directory
clean:
> rm -rf $(BUILD_DIR)

#HELP: prints this screen
help:
> @printf "Available targets\n\n"
> @awk '/^[a-zA-Z\-_0-9]+:/ {
>   helpMessage = match(lastLine, /^#HELP: (.*)/);
>   if (helpMessage) {
>     helpCommand = substr($$1, 0, index($$1, ":")-1);
>     helpMessage = substr(lastLine, RSTART + 6, RLENGTH);
>     gsub(/\\n/, "\n", helpMessage);
>     printf "\033[36m%-30s\033[0m %s\n", helpCommand, helpMessage;
>   }
> }
> { lastLine = $$0 }' $(MAKEFILE_LIST)

